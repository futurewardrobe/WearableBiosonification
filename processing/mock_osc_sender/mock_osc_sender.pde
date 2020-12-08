import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int data = 0;

void setup() {
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this, 8666);
  myRemoteLocation = new NetAddress("127.0.0.1", 8444);
}


void draw() {
  background(0);  
  
  OscMessage msg = new OscMessage("/osc/port/0");
  msg.add(data);
  oscP5.send(msg, myRemoteLocation);
  data = (data + 1) % 4096;
  
  delay(5);
}
