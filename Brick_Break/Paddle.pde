class Paddle
{
  float x; 
  float y; 
  float w;
  float h;
  int speed;


  Paddle()
  {
    x = width/2;
    y = 580;
    w = 100;
    h = 20;
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
    if(intersectsWith(b1))
    {
      Struct bounceStruct = bounce(b1);
      
      if(bounceStruct.bounce)
      {
        b1.velocity = new PVector(bounceStruct.x, bounceStruct.y);
        
        if(b1.isPowerupActive)
        {
          b1.velocity.setMag(b1.defaultSpeed/2);
        }
        else  b1.velocity.setMag(b1.defaultSpeed);
      }
    }
  }
  
  private boolean intersectsWith(Ball b1)
  {
    PVector half = new PVector(w/2, h/2);
    PVector center = new PVector(b1.position.x - (x + half.x), b1.position.y - (y + half.y));
    PVector side = new PVector(abs(center.x) - half.x, abs(center.y) - half.y);
    
    if(side.x > b1.r || side.y > b1.r)
      return false;
      
    if(side.x < -b1.r && side.y < -b1.r)
      return true;
      
    if(side.x < 0 || side.y < 0)
      return true;
      
    return side.x*side.x + side.y*side.y < b1.r*b1.r;
  }
  
  private Struct bounce(Ball b1)
  {
    PVector half = new PVector(w/2, h/2);
    PVector center = new PVector(b1.position.x - (x + half.x), b1.position.y - (y + half.y));
    PVector side = new PVector(abs(center.x) - half.x, abs(center.y) - half.y);
    Struct bounces = new Struct();
    boolean bounce;
    
    if (side.x >  b1.r || side.y >  b1.r) // outside
    {
      bounces.bounce = false;
      return bounces;
    }
    if (side.x < -b1.r && side.y < -b1.r) // inside
    {
      bounces.bounce = false;
      return bounces; 
    }
    if (side.x < 0 || side.y < 0) // intersects side or corner
    {
        float dx = 0, dy = 0;
        if (Math.abs (side.x) < b1.r && side.y < 0)
        {
            dx = center.x*side.x < 0 ? -1 : 1;
        }
        else if (Math.abs (side.y) < b1.r && side.x < 0)
        {
            dy = center.y*side.y < 0 ? -1 : 1;
        }
        PVector dv = center.normalize();
        //dv.x *= -1;
        bounces.bounce = true;
        bounces.x = dv.x;
        bounces.y = dv.y;
        return bounces;
    }
    
    // b1 is near the corner
    bounce = side.x*side.x + side.y*side.y  < b1.r*b1.r;
    if (!bounce)
    {
      bounces.bounce = false;
      return bounces;
    }
    
    float norm = sqrt (side.x*side.x+side.y*side.y);
    float dx = center.x < 0 ? -1 : 1;
    float dy = center.y < 0 ? -1 : 1;
    
    bounces.bounce = true;
    bounces.x = dx*side.x/norm;
    bounces.y = dy*side.y/norm;
    return bounces;
  }
}