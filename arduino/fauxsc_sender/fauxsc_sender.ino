//#include <WiFi.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <OSCMessage.h>
#include <math.h>

#define READ_PERIOD 5
#define OSC_ADDRESS "/osc/port/0"
#define SENSOR_PIN A0
#define PNOISE_SPEED 0.01f        // by adjust this number you can determine how quick the waveform swings

char ssid[] = "********";       // enter the network name/ssid here
char pass[] = "********";             // enter the network password here

WiFiUDP udp;
const IPAddress outIp(192,168,1,15); // enter the ip address of the receiviing computere here
const unsigned int outPort = 8444;    // enter the port over which we want to send the OSC data
const unsigned int localPort = 8222;     // enter the port over which we are receiving OSC data (wont be used except to establish a UDP connection)

unsigned long lastRead;
int fauxVal;
double i;
int loopIndex;

static const byte p[] = {   151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96,
                            53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23, 190, 6,
                            148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177,
                            33, 88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139,
                            48, 27, 166, 77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92,
                            41, 55, 46, 245, 40, 244, 102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132,
                            187, 208, 89, 18, 169, 200, 196, 135, 130, 116, 188, 159, 86, 164, 100, 109, 198,
                            173, 186, 3, 64, 52, 217, 226, 250, 124, 123, 5, 202, 38, 147, 118, 126, 255, 82, 85,
                            212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42, 223, 183, 170, 213, 119,
                            248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9, 129, 22, 39, 253,
                            19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228, 251, 34,
                            242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
                            49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4,
                            150, 254, 138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66,
                            215, 61, 156, 180
                        };

double fade(double t) {
  return t * t * t * (t * (t * 6 - 15) + 10);
}
double lerp(double t, double a, double b) {
  return a + t * (b - a);
}
double grad(int hash, double x, double y, double z)
{
  int     h = hash & 15;          /* CONVERT LO 4 BITS OF HASH CODE */
  double  u = h < 8 ? x : y,      /* INTO 12 GRADIENT DIRECTIONS.   */
          v = h < 4 ? y : h == 12 || h == 14 ? x : z;
  return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}

#define P(x) p[(x) & 255]

double pnoise(double x, double y, double z)
{
  int   X = (int)floor(x) & 255,             /* FIND UNIT CUBE THAT */
        Y = (int)floor(y) & 255,             /* CONTAINS POINT.     */
        Z = (int)floor(z) & 255;
  x -= floor(x);                             /* FIND RELATIVE X,Y,Z */
  y -= floor(y);                             /* OF POINT IN CUBE.   */
  z -= floor(z);
  double  u = fade(x),                       /* COMPUTE FADE CURVES */
          v = fade(y),                       /* FOR EACH OF X,Y,Z.  */
          w = fade(z);
  int  A = P(X) + Y,
       AA = P(A) + Z,
       AB = P(A + 1) + Z,                    /* HASH COORDINATES OF */
       B = P(X + 1) + Y,
       BA = P(B) + Z,
       BB = P(B + 1) + Z;                    /* THE 8 CUBE CORNERS, */

  return lerp(w, lerp(v, lerp(u, grad(P(AA  ), x, y, z),        /* AND ADD */
                              grad(P(BA  ), x - 1, y, z)),               /* BLENDED */
                      lerp(u, grad(P(AB  ), x, y - 1, z),        /* RESULTS */
                           grad(P(BB  ), x - 1, y - 1, z))),          /* FROM  8 */
              lerp(v, lerp(u, grad(P(AA + 1), x, y, z - 1), /* CORNERS */
                           grad(P(BA + 1), x - 1, y, z - 1)),         /* OF CUBE */
                   lerp(u, grad(P(AB + 1), x, y - 1, z - 1),
                        grad(P(BB + 1), x - 1, y - 1, z - 1))));
}

void setup() {
  Serial.begin(115200);

  // Connect to wifi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");

  Serial.println("Wifi connected!");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  Serial.println("Starting UDP");
  udp.begin(localPort);
  Serial.println(localPort);
  
  lastRead = 0;
  i = 0;
  loopIndex = 0;
}

void loop() {
  if(millis() - lastRead > READ_PERIOD){

  i += PNOISE_SPEED;
  
  if(loopIndex == 0){
    fauxVal = int(pnoise(i + sin(i), i + cos(i), i) * 2048 + 2048);
  } else {
    fauxVal = 0;  
  }
  
  Serial.println(fauxVal);
    OSCMessage msg(OSC_ADDRESS);
    msg.add(fauxVal);
    udp.beginPacket(outIp, outPort);
    msg.send(udp);
    udp.endPacket();
    msg.empty();
    
    lastRead = millis();
    loopIndex += 1;
    loopIndex %= 2;
  }
}
