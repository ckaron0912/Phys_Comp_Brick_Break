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
    
  }
  
  void draw(){
    
  }
  
  boolean collidesWith(int ball){
    
    return false;
  }
}