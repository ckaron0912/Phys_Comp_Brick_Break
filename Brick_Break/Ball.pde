class Ball
{
  PVector position;
  PVector velocity;
  float diameter; 
  float r;
  color clr;
  boolean isPowerupActive;
  float defaultSpeed = 4;
  
  Ball()
  {
    position = new PVector(400, 300);
    velocity = new PVector(2, -3);
    velocity.setMag(defaultSpeed);
    diameter = 10;
    r = diameter/2;
    clr = color(0, 0, 0);
    isPowerupActive = false;
  }

  void update()
  {
    noStroke();
    fill(clr);
    ellipse(position.x, position.y, diameter, diameter);

    position.add(velocity);
    
    inBounds();
  }

  void reset()
  {
    position = new PVector(random(50, 750), 300);
    velocity = new PVector(random(-3, 3), random(-2, -5));
    velocity.setMag(defaultSpeed);
    clr = color(0, 0, 0);
    noPowerup();
  }
  
  void inBounds()
  {
    //Wall Collisions
    if (b1.position.x + b1.diameter / 2 >= width || b1.position.x - b1.diameter / 2 <= 0)
    {
      b1.velocity.x *= -1;
    }
    //Ceiling Collision
    if (b1.position.y - b1.diameter / 2 <= 0)
    {
      b1.velocity.y *= -1;
    }
  }
  
  void noPowerup()
  {
    isPowerupActive = false;
    velocity.y = defaultSpeed;
  }
  
  void slow()
  {
    isPowerupActive = true;
    velocity.setMag(defaultSpeed / 2);
  }
}