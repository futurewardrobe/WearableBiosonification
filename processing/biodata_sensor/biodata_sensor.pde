import oscP5.*;
import netP5.*;

final static int NUM_SENSORS = 1;
final static int OSC_IN_PORT = 8444;
final static String OSC_IN_ADDR = "/osc/port/0";

OscP5 oscP5;

Sensor ss[] = new Sensor[NUM_SENSORS];
long lastOscMillis;

void setup() {
  size(600, 700, P2D);
  //fullScreen(P2D);
  for (int i=0; i<ss.length; ++i) {
    ss[i] = new Sensor(new PVector(40, 20+i*110), new PVector(560, 660), "sensor"+i);
  }
  lastOscMillis = millis();
  oscP5 = new OscP5(this, OSC_IN_PORT);
}

void draw() {
  background(200);

  //// write oscs
  if (millis()-lastOscMillis > 100) {
    for (Sensor s:ss) {
      s.sendOsc();
    }
  }

  // draw
  for (Sensor s:ss) {
    s.draw();
  }
}

// incoming osc message eventhandler
void oscEvent(OscMessage msg) {
  if(msg.checkAddrPattern(OSC_IN_ADDR)) {
    int value = msg.get(0).intValue();
    ss[0].addValue((short)value);
  }
}
