import oscP5.*;
import netP5.*;

import controlP5.*;

private static NetAddress oscOutAddress;
private static OscMessage mMessage;

ControlP5 cp5;
int select_sound;
float sample_offset;
float random_offset;
float random_pitch;
float grain_size;
float grain_density;
float grainplay_chance;

public class Sensor {
  private static final short AVGSIZE = 20;
  private static final short DISPLAYSIZE = 300;
  private static final short RAWSIZE = 30000;

  private final static int OSC_OUT_PERIOD = 100;
  private final static int OSC_OUT_PORT = 8666;
  private final static String OSC_OUT_HOST = "localhost";
  private final static String OSC_OUT_PATTERN = "/pulsum-osc/";

  private short rawValues[] = new short[RAWSIZE+1];
  private short averageValues[] = new short[DISPLAYSIZE*2+1];
  private short currentRunningAverage[] = new short[AVGSIZE];
  private int averageSum;
  private short averageIndex;

  // begin/end indices for different things
  private short averageEnd, rawEnd;
  private short maxValue, minValue;
  private String name;
  private PVector location, dimension;

  public Sensor(PApplet parent, PVector _location, PVector _dimension, String _name) {
    oscOutAddress = new NetAddress(OSC_OUT_HOST, OSC_OUT_PORT);
    mMessage = new OscMessage(OSC_OUT_PATTERN);

    // set location/dimension of graphs and name of sensor
    location = _location;
    dimension = _dimension;
    name = _name;

    // initial end indices
    //   "end" points to one after the last value in range
    rawEnd = (short)((rawValues.length)-1);
    averageEnd = (short)((averageValues.length)-1);

    // init values
    for (int i=0; i<(rawValues.length); ++i) {
      rawValues[i] = 0;
    }
    for (int i=0; i<(averageValues.length); ++i) {
      averageValues[i] = 0;
    }
    for (int i=0; i<(currentRunningAverage.length); ++i) {
      currentRunningAverage[i] = 0;
    }

    minValue = (short)0x7fff;
    maxValue = 0;
    averageSum = 0;
    averageIndex = 0;
    
    // place the sliders
    cp5 = new ControlP5(parent);
    
    int sliderWidth = (int)(width-(dimension.x+location.x+30));
    int sliderHeight = (int)((height-(location.y*2))/7);
    
    cp5.addSlider("select_sound")
     .setPosition(dimension.x+location.x+20,location.y)
     .setRange(1,13)
     .setSize(sliderWidth, sliderHeight-2)
     .setNumberOfTickMarks(13);
     ;
    cp5.getController("select_sound").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
    
    cp5.addSlider("sample_offset")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*1)+1)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("sample_offset").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
    
    cp5.addSlider("random_offset")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*2)+2)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("random_offset").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
    
    cp5.addSlider("random_pitch")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*3)+3)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("random_pitch").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);

    cp5.addSlider("grain_size")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*4)+4)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("grain_size").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
    
    cp5.addSlider("grain_density")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*5)+5)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("grain_density").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
    
    cp5.addSlider("grainplay_chance")
     .setPosition(dimension.x+location.x+20,location.y+(sliderHeight*6)+6)
     .setRange(0.0,1.0)
     .setSize(sliderWidth, sliderHeight-2)
     ;
    cp5.getController("grainplay_chance").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM).setPaddingX(0);
  }

  public short getMin() {
    return minValue;
  }
  public short getMax() {
    return maxValue;
  }
  public String getName() {
    return name;
  }

  public short getRawValue() {
    // last written value is at end-1
    // make sure index is positive
    int getFromIndex = (rawEnd > 0)?(rawEnd-1):((rawValues.length)-1);
    return rawValues[getFromIndex];
  }

  public short getAverageValue() {
    // last written value is at end-1
    // make sure index is positive
    int getFromIndex = (averageEnd > 0)?(averageEnd-1):((averageValues.length)-1);
    return averageValues[getFromIndex];
  }
  public short getAverageValueNormalized() {
    // very weird function....
    //println(getAverageValue(), getMin(), getMax());
    //println(constrain(getAverageValue(), 0, 4095));
    //println(map(getAverageValue(), getMin(), getMax(), 0, 4095));
    return (short)constrain((short)map(getAverageValue(), getMin(), getMax(), 0, 4095), 0, 4095);
  }


  public void addValue(short val) {
    // write value to raw array and update end index
    rawValues[rawEnd] = val;
    rawEnd = (short)((rawEnd+1)%(rawValues.length));

    // update running average
    averageSum -= currentRunningAverage[averageIndex];
    currentRunningAverage[averageIndex] = val;
    averageSum += currentRunningAverage[averageIndex];
    averageIndex = (short)((averageIndex+1)%(currentRunningAverage.length));

    // write to average values
    averageValues[averageEnd] = (short)(averageSum/(currentRunningAverage.length));
    averageEnd = (short)((averageEnd+1)%(averageValues.length));

    // find min/max of current averages
    short thisMinValue = (short)0x7fff;
    short thisMaxValue = 0;
    for (int i=0; i<(averageValues.length); ++i) {
      if (averageValues[i] > thisMaxValue) {
        thisMaxValue = averageValues[i];
      }
      if (averageValues[i] < thisMinValue) {
        thisMinValue = averageValues[i];
      }
    }

    // if there's a new min/max, update immediately
    //    else, slowly approach current min/max
    if (thisMaxValue > maxValue) {
      maxValue = thisMaxValue;
    }
    else {
      maxValue = (short)(0.99*maxValue + 0.01*thisMaxValue);
    }

    if (thisMinValue < minValue) {
      minValue = thisMinValue;
    }
    else {
      minValue += (short)(0.01*thisMinValue);
      minValue = (thisMinValue<minValue)?thisMinValue:minValue;
    }
  }

  public void sendOsc() {
    String mAddrPatt = OSC_OUT_PATTERN+getName()+"/";

    // min
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"min");
    mMessage.add(getMin());
    OscP5.flush(mMessage, oscOutAddress);

    // max
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"max");
    mMessage.add(getMax());
    OscP5.flush(mMessage, oscOutAddress);

    // filtered
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"filtrado");
    mMessage.add(getAverageValue());
    //mMessage.add(getAverageValueNormalized());
    OscP5.flush(mMessage, oscOutAddress);

    // raw
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"crudo");
    mMessage.add(getRawValue());
    OscP5.flush(mMessage, oscOutAddress);
    
    // select_sound
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"select_sound");
    mMessage.add(select_sound);
    OscP5.flush(mMessage, oscOutAddress);    
    
    // sample_offset
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"sample_offset");
    mMessage.add(sample_offset);
    OscP5.flush(mMessage, oscOutAddress);
    
    // random_offset
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"random_offset");
    mMessage.add(random_offset);
    OscP5.flush(mMessage, oscOutAddress);
    
    // random_pitch
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"random_pitch");
    mMessage.add(random_pitch);
    OscP5.flush(mMessage, oscOutAddress);
    
    // grain_size
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"grain_size");
    mMessage.add(grain_size);
    OscP5.flush(mMessage, oscOutAddress);
    
    // grain_density
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"grain_density");
    mMessage.add(grain_density);
    OscP5.flush(mMessage, oscOutAddress);
    
    // grainplay_chance
    mMessage.clear();
    mMessage.setAddrPattern(mAddrPatt+"grainplay_chance");
    mMessage.add(grainplay_chance);
    OscP5.flush(mMessage, oscOutAddress);
  }

  public void draw() {
    pushMatrix();
    translate(location.x, location.y);

    // background rectangle
    fill(100);
    rect(0, 0, dimension.x+location.x, dimension.y);

    // sensor title
    fill(255);
    textSize(16);
    text(name, 10, 16);

    // raw graph
    pushMatrix();
    translate(0, dimension.y/4);
    drawGraph(rawValues, (short)(rawValues.length), rawEnd, dimension.x/2, dimension.y/2);
    popMatrix();

    // avg graph
    pushMatrix();
    translate(dimension.x/2+10, dimension.y/4);
    drawGraph(averageValues, (short)(averageValues.length), averageEnd, dimension.x/2, dimension.y/2);
    popMatrix();

    // info string
    pushMatrix();
    translate(0, dimension.y*3/4);
    fill(255);
    textSize(16);
    String ss = "current: "+getRawValue()+" min: "+minValue+" max: "+maxValue;
    text(ss, 0, 16);
    popMatrix();

    popMatrix();  // translate
  }

  void drawGraph(short values[], short sizeOfValues, short lastIndex, float gwidth, float gheight) {
    // graph
    PShape ps = createShape();
    ps.beginShape();
    ps.fill(255);
    ps.vertex(0, gheight);
    for (int x=1, i=(int)(lastIndex-gwidth); x<gwidth; ++x, ++i) {
      int yIndex = i;
      while (yIndex<0) {
        yIndex += sizeOfValues;
      }
      yIndex = yIndex%sizeOfValues;

      short y0 = (short)map(values[yIndex], 4096, 0, 0, gheight);
      ps.vertex(x, y0);
    }
    ps.vertex(gwidth, gheight);
    ps.endShape(CLOSE);

    // background rectangle
    fill(90);
    noStroke();
    rect(0, 0, gwidth, gheight);
    shape(ps, 0, 0);
  }
}
