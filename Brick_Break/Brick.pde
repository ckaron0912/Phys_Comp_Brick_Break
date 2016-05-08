class Brick{
 
  int x, y, w, h;
  color clr;
  boolean active;
  
  Brick(int _x, int _y){
    
    x = _x;
    y = _y;
    h = 50;
    w = 100;
    active = true;
  }
  
  void update(){
    if(active)
    {
      noStroke();
      fill(clr);
      rect(x, y, w, h);
    }
  }
  
  
  void collidesWith()
  {
    active=false;
  }
}