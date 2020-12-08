#include <WiFi.h>
#include <WiFiUdp.h>
#include <OSCMessage.h>

#define READ_PERIOD 5
#define OSC_ADDRESS "/osc/port/0"
#define SENSOR_PIN A0

char ssid[] = "**************";       // enter the network name/ssid here
char pass[] = "********";             // enter the network password here

WiFiUDP udp;
const IPAddress outIp(192,168,1,100); // enter the ip address of the receiviing computere here
const unsigned int outPort = 8444;    // enter the port over which we want to send the OSC data
const unsigned int localPort = 8222;     // enter the port over which we are receiving OSC data (wont be used except to establish a UDP connection)

unsigned long lastRead;

void setup() {
  Serial.begin(115200);

  // Connect to wifi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
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
}

void loop() {
  if(millis() - lastRead > READ_PERIOD){
    short readValue = analogRead(SENSOR_PIN);

    Serial.print("Value from sensor 0: ");
    Serial.println(readValue);

    OSCMessage msg(OSC_ADDRESS);
    msg.add(readValue);
    udp.beginPacket(outIp, outPort);
    msg.send(udp);
    udp.endPacket();
    msg.empty();
    
    lastRead = millis();
  }
}
