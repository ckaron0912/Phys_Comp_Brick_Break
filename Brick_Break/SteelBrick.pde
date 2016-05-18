class SteelBrick extends Brick
{
  SteelBrick(int _x, int _y)
  {
    super(_x, _y);
    clr = color(128, 128, 128);
    type = "steel";
  }
  
  boolean collidesWith(Ball b1)
  {
    //Bottom
    if (b1.position.y - b1. diameter / 2 <= this.y + this.h &&  b1.position.y - b1.diameter/2 >= this.y && b1.position.x >= this.x && b1.position.x <= this.x + this.w  && this.active)
    {
      b1.velocity.y*=-1;
      return true;
    }

    //Top
    if (b1.position.y + b1.diameter / 2 >= this.y && b1.position.y - b1.diameter /2 <= this.y + this.h/2 && b1.position.x >= this.x && b1.position.x <= this.x + this.w && this.active) 
    {
      b1.velocity.y*=-1;
      return true;
    }

    //Left
    if (b1.position.x + b1.diameter / 2 >= this.x && b1.position.x + b1.diameter / 2 <= this.x + this.w / 2 && b1.position.y >= this.y && b1.position.y <= this.y + this.h  && this.active)
    {
      b1.velocity.x*=-1;
      return true;
    }

    //Right
    if (b1.position.x - b1.diameter/2 <= this.x + this.w && b1.position.x +b1.diameter / 2 >= this.x + this.w / 2 && b1.position.y >= this.y && b1.position.y <= this.y + this.h  && this.active)
    {
      b1.velocity.x*=-1;
      return true;
    }
    
    return false;
  }
}