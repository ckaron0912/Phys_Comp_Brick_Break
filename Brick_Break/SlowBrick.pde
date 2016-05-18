class SlowBrick extends Brick
{
  SlowBrick(int _x, int _y)
  {
    super(_x, _y);
    clr = color(171, 144, 212);
  }
  
  boolean collidesWith(Ball b1)
  {
    if(super.collidesWith(b1))
    {
      b1.slow();
      return true;
    }
    
    return false;
  }
}