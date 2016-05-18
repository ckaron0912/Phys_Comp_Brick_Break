import processing.serial.*;

String portName = "COM3";
Serial port;
PFont font;
int paddleX = 0;
int rows = 7;
int columns = 10; 
int score = 0;
int lives = 5; 
boolean gameOver = false;

Paddle p1 = new Paddle(); 
Ball b1 = new Ball(); 
Brick[][] bricks = new Brick[rows][columns]; 

void setup(){
 
  size(900, 600);
  font = createFont("Courier", 24);
  textFont(font);
  noStroke();
  // #1 in Serial.list() usually FTdiameterI adaptor
  //println(Serial.list());
  portName = Serial.list()[1];
  port = new Serial(this, portName, 9600);
  makeBricks();
}

void draw(){
  
  background(255, 255, 255);
  
  if(port.available() > 0){
    
    paddleX = (int)map(port.read(), 0, 255, width - p1.w, 0);
    port.clear();
  }
  //println(paddleX);
  
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      bricks[i][j].update();
    }
  }

  p1.update(paddleX);
  b1.update();
  collisions();
  drawHUD();
}

void makeBricks()
{
    //Setup array of all bricks on screen
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      if(i == rows - 1 && j % 2 == 0)
        bricks[i][j] = new SteelBrick((j+2)*65, (i+3)*25);
        
      else if(i == rows - 1 && j % 2 == 1)
        bricks[i][j] = new SlowBrick((j+2)*65, (i+3)*25);
      
      else
        bricks[i][j] = new Brick((j+2)*65, (i+3)*25);
    }
  }
}
  
void collisions()
{
  p1.collidesWith(b1);
  
  // Brick Collsions
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      bricks[i][j].collidesWith(b1);
    }
  }
  
  //Ball goes offscreen
  if (b1.position.y > height)
  {
    b1.reset();
    lives -= 1;
  }
}

void drawHUD()
{
  fill(0);
  text("Score: " + score, 300, 30);
  text("Lives: " + lives, 500, 30);
  noFill();
}