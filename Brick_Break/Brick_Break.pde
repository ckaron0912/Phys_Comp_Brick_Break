import processing.serial.*;

String portName = "COM3";
Serial port;
int paddleX = 0;
PFont font;

void setup(){
 
  size(800, 500);
  font = createFont("Courier", 24);
  textFont(font);
  noStroke();
  // #1 in Serial.list() usually FTDI adaptor
  println(Serial.list());
  portName = Serial.list()[1];
  port = new Serial(this, portName, 9600);
}

void draw(){
  
  background(255, 255, 255);
  
  if(port.available() > 0){
    
    paddleX = (int)map(port.read(), 0, 255, 0, 800);
    port.clear();
  }
  println(paddleX);
}