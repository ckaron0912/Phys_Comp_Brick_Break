class Brick{
 
  int x, y, w, h;
  color clr;
  boolean active;
  
  Brick(int _x, int _y){
    
    x = _x;
    y = _y;
    h = 20;
    w = 60;
    active = true;
    clr = color(random(50, 200), random(50, 200), random(50, 200));
  }
  
  void update(){
    if(active)
    {
      noStroke();
      fill(clr);
      rect(x, y, w, h);
    }
  }
  
  
  void collidesWith(Ball b1)
  {
    //Bottom
    if (b1.position.y - b1. diameter / 2 <= this.y + this.h &&  b1.position.y - b1.diameter/2 >= this.y && b1.position.x >= this.x && b1.position.x <= this.x + this.w  && this.active)
    {
      b1.velocity.y*=-1;
      b1.clr = this.clr;
      active=false;
      score += 1;
    }
    //Top
    if (b1.position.y + b1.diameter / 2 >= this.y && b1.position.y - b1.diameter /2 <= this.y + this.h/2 && b1.position.x >= this.x && b1.position.x <= this.x + this.w && this.active) 
    {
      b1.velocity.y*=-1;
      b1.clr = this.clr;
      active=false;
      score += 1;
    }
    //Left
    if (b1.position.x + b1.diameter / 2 >= this.x && b1.position.x + b1.diameter / 2 <= this.x + this.w / 2 && b1.position.y >= this.y && b1.position.y <= this.y + this.h  && this.active)
    {
      b1.velocity.x*=-1;
      b1.clr = this.clr;
      active=false;
      score += 1;
    }
    //Right
    if (b1.position.x - b1.diameter/2 <= this.x + this.w && b1.position.x +b1.diameter / 2 >= this.x + this.w / 2 && b1.position.y >= this.y && b1.position.y <= this.y + this.h  && this.active)
    {
      b1.velocity.x*=-1;
      b1.clr = this.clr;
      active=false;
      score += 1;
    }
  }
}