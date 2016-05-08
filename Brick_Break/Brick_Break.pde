import processing.serial.*;

String portName = "COM3";
Serial port;
PFont font;
int paddleX = 0;
int rows = 5;
int columns = 5; 
int score = 0;
int lives = 5; 

Paddle p1 = new Paddle(); 
Ball b1 = new Ball(); 
Brick[] bricks = new Brick[rows*columns]; 

void setup(){
 
  size(800, 500);
  font = createFont("Courier", 24);
  textFont(font);
  noStroke();
  // #1 in Serial.list() usually FTdiameterI adaptor
  println(Serial.list());
  portName = Serial.list()[1];
  port = new Serial(this, portName, 9600);
  makeBricks();
}

void draw(){
  
  background(255, 255, 255);
  
  if(port.available() > 0){
    
    paddleX = (int)map(port.read(), 0, 255, 0, 800);
    port.clear();
  }
  println(paddleX);
  
  for (int i = 0; i<rows*columns; i++)
  {
    bricks[i].update();
  }

  p1.update(paddleX);
  b1.update();
}

void makeBricks()
{
    //Setup array of all bricks on screen
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      bricks[i*rows + j] = new Brick((i+1) *100, (j+1) * 50); 
    }
  }
}
  
  void ballHit()
  {
    //Wall Collisions
    if (b1.x + b1.diameter / 2 >= width || b1.x - b1.diameter / 2 <= 0)
    {
      b1.vx*=-1;
    }
    //Ceiling Collision
    if (b1.y - b1.diameter / 2 <= 0)
    {
      b1.vy*=-1;
    }
    
    //Paddle Collisions
    //Left
    if (b1.y == p1.y && b1.x > p1.x && b1.x <= p1.x + (p1.w / 2) )
    {
      b1.vx =-3;
      b1.vy *= -1;
    }
    //Right
    if (b1.y == p1.y && b1.x > p1.x + (p1.w/2) && b1.x <= p1.x + p1.w )
    {
      b1.vx =3;
      b1.vy *= -1;
    }
    
    // Brick Collsions
    for (int i = 0; i < rows*columns; i ++)
    {
      //Bottom
      if (b1.y - b1. diameter / 2 <= bricks[i].y + bricks[i].h &&  b1.y - b1.diameter/2 >= bricks[i].y && b1.x >= bricks[i].x && b1.x <= bricks[i].x + bricks[i].w  && bricks[i].active == true )
      {
        b1.vy*=-1;
        bricks[i].collidesWith();
        score += 1;
      }
      //Top
      if (b1.y + b1.diameter / 2 >= bricks[i].y && b1.y - b1.diameter /2 <= bricks[i].y + bricks[i].h/2 && b1.x >= bricks[i].x && b1.x <= bricks[i].x + bricks[i].w && bricks[i].active == true ) 
      {
        b1.vy*=-1;
        bricks[i].collidesWith();
        score += 1;
        }
        //Left
        if (b1.x + b1.diameter / 2 >= bricks[i].x && b1.x + b1.diameter / 2 <= bricks[i].x + bricks[i].w / 2 && b1.y >= bricks[i].y && b1.y <= bricks[i].y + bricks[i].h  && bricks[i].active == true)
        {
          b1.vx*=-1;
          bricks[i].collidesWith();
          score += 1;
        }
        //Right
        if (b1.x - b1.diameter/2 <= bricks[i].x + bricks[i].w && b1.x +b1.diameter / 2 >= bricks[i].x + bricks[i].w / 2 && b1.y >= bricks[i].y && b1.y <= bricks[i].y + bricks[i].h  && bricks[i].active == true)
        {
          b1.vx*=-1;
          bricks[i].collidesWith();
          score += 1;
        }
      }
      //Ball goes offscreen
      if (b1.y > height)
      {
        b1.reset();
        lives -= 1;
      }
    }