import processing.serial.*;

String portName = "COM3";
Serial port;
int paddleX = 0;
PFont font;
float textX = 500; //temp text locations
float textY = 350;

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
  
  background(0, 0, 0);
  rect(100, 100, 100, 100);
  
  if(port.available() > 0){
    
    paddleX = port.read();
    port.clear();
  }
  text(paddleX, textX, textY);
  println(paddleX);
}