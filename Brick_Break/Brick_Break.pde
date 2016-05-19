import processing.serial.*;

String portName = "COM3";
Serial port;
PFont font;
int paddleX = 0;
int rows = 7;
int columns = 10; 
int score = 0;
int lives = 5; 
int numBricks = 0;
boolean gameOver = false;
boolean win = false;
boolean start = false;

Paddle p1 = new Paddle(); 
Ball b1 = new Ball(); 
Brick[][] bricks = new Brick[rows][columns]; 

void setup(){
 
  size(900, 600);
  font = createFont("Courier Bold", 24);
  textFont(font);
  noStroke();
  // #1 in Serial.list() usually FTdiameterI adaptor
  //println(Serial.list());
  portName = Serial.list()[0];
  port = new Serial(this, portName, 9600);
  makeBricks();
}

void resetGame()
{
  numBricks = 0;
  bricks = new Brick[rows][columns]; 
  makeBricks();
  start = false;
  win = false;
  gameOver = false;
  lives = 5;
  score = 0;
  b1.reset();
}

void draw(){
  
  background(255, 255, 255);
  if(!start)
  {
    screenSaver();
  }
  else if(gameOver)
  {
    displayLose();
  }
  else if(win)
  {
    displayWin();
  }
  else
  {
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
    checkWin();
  }
}

void screenSaver()
{
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      bricks[i][j].update();
    }
  }
  int constraint = (int)map(b1.position.x, 0, width, 0, width - p1.w);
  p1.update(constraint);
  b1.update();
  collisions();
  drawHUD();
  fill(0, 0, 0, 200);
  rect(0, 0, width, height);
  fill(255, 255, 255);
  textSize(50);
  text("How to play:", width/2 - 130, 150);
  textSize(30);
  text("Center knob!", width/2 - 90, 190);
  text("Spin to win!", width/2 - 80, 230);
  text("Press space to start!", width/2 - 130, height/2 - 10);
}

void keyPressed()
{
  if(key == ' ' && !start)
  {
    start = true;
    b1.reset();
    score = 0;
  }
  
  if(key == ' ' && gameOver || win)
  {
    resetGame();
  }
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
      {
        bricks[i][j] = new SlowBrick((j+2)*65, (i+3)*25);
        numBricks++;
      }
      else
      {
        bricks[i][j] = new Brick((j+2)*65, (i+3)*25);
        numBricks++;
      }
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
      if(bricks[i][j].active && bricks[i][j].collidesWith(b1) && bricks[i][j].type != "steel")
      {
        if(bricks[i][j].type == "normal")
        {
           b1.noPowerup(); 
        }
        numBricks--;
      }
    }
  }
  
  if(numBricks < 0 )
    numBricks = 0;
  
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

void checkWin()
{
  if(numBricks == 0)
    win = true;
    
  if(lives == 0)
    gameOver = true;
}

void displayWin()
{
  text("You win!", width/2 - 60, height/2);
  text("Score: " + score, width/2 - 60, height/2 + 30);
}

void displayLose()
{
  text("You lose!", width/2 - 60, height/2);
  text("Score: " + score, width/2 - 60, height/2 + 30);
}