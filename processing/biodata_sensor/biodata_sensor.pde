import oscP5.*;
import netP5.*;

// adjust these constants to adjust the screen
final static int LOCATION_X = 40;
final static int LOCATION_Y = 20;
final static int DIMENSION_X = 560;
final static int DIMENSION_Y = 660;
final static boolean IS_FULLSCREEN = false;
final static int WINDOW_WIDTH = 600;
final static int WINDOW_HEIGHT =700;

final static int NUM_SENSORS = 1;
final static int OSC_IN_PORT = 8444;
final static String OSC_IN_ADDR = "/osc/port/0";

OscP5 oscP5;

Sensor ss[] = new Sensor[NUM_SENSORS];
long lastOscMillis;

void settings(){
  if(IS_FULLSCREEN){
    fullScreen(P2D, 1);
  } else{
    size(WINDOW_WIDTH, WINDOW_HEIGHT, P2D);
  }
}

void setup() {
  for (int i=0; i<ss.length; ++i) {
    ss[i] = new Sensor(new PVector(LOCATION_X, LOCATION_Y+i*110), new PVector(DIMENSION_X, DIMENSION_Y), "sensor"+i);
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
