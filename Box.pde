class Box
{
  PVector location, acceleration, velocity;
  float maxSpeed, maxForce;
  
  Box()
  {
    location = new PVector(random(0, width/2), random(0, height/2));// cnsturcted in the upper left quadrant
    acceleration = new PVector(0, 0);
    velocity = new PVector(0.6, 0);
    maxSpeed = 2;
    maxForce = 1;
  }
  

  void construct()
  {
    fill(20, 167, 237);
    rectMode(CENTER);
    rect(location.x, location.y, 10, 10);
  }

  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    this.checkedges();
  }

  void applyForce(PVector force)
  {
    acceleration.add(force);
  }

  void seek(PVector target)
  {
    PVector desired =  PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    applyForce(steer);
  }
  
  void seperate (ArrayList<Box> boxes)
  {
    float desiredSeperation = 10;
    PVector sum = new PVector();
    int count = 0;
    for (Box other: boxes)
    {
      float distance = PVector.dist(location, other.location);
      if (distance > 0 && distance < desiredSeperation)  // if there is distance and that distance is lower than the "view" of this object
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
        count++;
      }
      if (count > 0) 
      {
      sum.div(count);
      sum.setMag(maxSpeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxForce);
      applyForce(steer);
      }
    
   }
}  

  void cohesion (ArrayList<Box> boxes)
  {
    float desiredSeperation = 100;
    PVector sum = new PVector();
    int count = 0;
    for (Box other: boxes)
    {
      float distance = PVector.dist(location, other.location);
       if (distance > 0 && distance < desiredSeperation)
      {
        PVector diff = PVector.sub(other.location, location); // inverse of locatoion to other (seperate)
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
        count++;
                                                              //something may be wrong with the logic of the code
        sum.div(count);
        sum.setMag(maxSpeed);
        PVector steer = PVector.sub(sum,velocity);
        steer.limit(maxForce);
        applyForce(steer);
      }
    
     }
     
    }
    void arrive(PVector target) 
   {
      PVector desired = PVector.sub(target,location);
      float d = desired.mag();
      desired.normalize();
  
      if (d < 100) 
      {
        float m = map(d,0,100,0,maxSpeed);
        desired.mult(m);
      } 
      else 
        desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxForce);
      applyForce(steer);
  }
  
  
     void checkedges() //bounces on all walls, if reach the ceiling comes out from the bottom of the screen
     {
       if (location.x > width)
        {
         velocity.x *= -1;
         velocity.x -= 0.003;
         location.x = width;
        }
       else if (location.x < 0) 
        {
          velocity.x *= -1;
          velocity.x += 0.003;
          location.x = 0;
        }
          
       if (location.y > height)
        { 
          velocity.y *= -1;
          velocity.y += 0.09;
          location.y = height;
        }
       else if (location.y < 0) 
          location.y = height;
     }

}
