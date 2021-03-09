import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float noiseSpeed = 0.01f;
int readPeriod = 5;
double lastRead = 0;
int loopIndex = 0;
int fauxVal = 0;
float xoff = 0;

void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this, 8666);
  myRemoteLocation = new NetAddress("127.0.0.1", 8444);
}

void draw() {
  background(0);  
  
  if(millis() - lastRead > readPeriod){
    xoff += noiseSpeed;
    
    if (loopIndex == 0){
      fauxVal = ceil(noise(xoff) * 4095);
    } else {
      fauxVal = 0;
    }
    
    OscMessage msg = new OscMessage("/osc/port/0");
    msg.add(fauxVal);
    oscP5.send(msg, myRemoteLocation);
    
    lastRead = millis();
    loopIndex += 1;
    loopIndex %= 2;
  }
}
