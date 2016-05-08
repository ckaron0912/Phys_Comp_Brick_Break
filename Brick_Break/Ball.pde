class Ball
{

  float x; 
  float y; 
  float vx; 
  float vy; 
  float diameter; 
  
  Ball()
  {
    x = 400;
    y = 250;
    vx = 0; 
    vy = 3; 
    diameter = 10;
  }


  void update()
  {
    noStroke();
    fill(255);
    ellipse(x, y, diameter, diameter);

    y += vy; 
    x += vx; 
  }


  void reset()
  {
    x = 400;
    y = 250;
    vx = 0;
    vy = 3;
  }
}