class Paddle
{
  float x; 
  float y; 
  float w;
  float h;


  Paddle()
  {
    x = width/2;
    y = 580;
    w = 100;
    h = 10;
  }

  void update(int x_in)
  {
    x = x_in; 
    fill(0);
    rect(x, y, w, h);
  }
  
  void collidesWith(Ball b1)
  {
    //Paddle Collisions
    //Left
    if (b1.position.y + (b1.diameter/2) > p1.y && b1.position.x >= p1.x && b1.position.x < p1.x + (p1.w/2))
    {
      b1.velocity.x = -3;
      b1.velocity.y *= -1;
    }
    //Right
    if (b1.position.y + (b1.diameter/2) > p1.y && b1.position.x >= p1.x + (p1.w/2) && b1.position.x + (b1.diameter/2) < p1.x + p1.w)
    {
      b1.velocity.x = 3;
      b1.velocity.y *= -1;
    }
  }
}