class Paddle
{
  float x; 
  float y; 
  float w;
  float h;


  Paddle()
  {
    x = width/2;
    y = 500;
    w = 100;
    h = 10;
  }

  void update(int x_in)
  {
    x = x_in; 
    fill(255);
    rect(x, y, w, h);
  }
}