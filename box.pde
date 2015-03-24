class box
{
  PVector location, acceleration, velocity;
  float maxSpeed, maxForce;
  box()
  {
    location = new PVector(random(0, width), random(0, height));
    acceleration = new PVector(0, 0);
    velocity = new PVector(0.5, 0.8);
    maxSpeed = 5;
    maxForce = 2;
  }

  void construct()
  {
    fill(20, 167, 237);
    rectMode(CENTER);
    rect(location.x, location.y, 5, 10);
  }

  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force)
  {
    acceleration.add(force);
  }

// create a method to manipulate the force before applying it. then send it to the apply force

  void seek(PVector target)
  {
    PVector desired =  PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    applyForce(steer);
  }
  
  void seperate (ArrayList<box> boxes)
  {
    float desiredSeperation = 10;
    PVector sum = new PVector();
    int count = 0;
    for (box other: boxes)
    {
      float distance = PVector.dist(location, other.location);
      if (distance > 0 && distance < desiredSeperation)
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

void cohesion (ArrayList<box> boxes)
  {
    float desiredSeperation = 10;
    PVector sum = new PVector();
    int count = 0;
    for (box other: boxes)
    {
      float distance = PVector.dist(location, other.location);
       if (distance > 0 && distance < desiredSeperation)
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(distance);
        sum.sub(diff);
        count++;
    
    sum.div(count);
    sum.setMag(maxSpeed);
    PVector steer = PVector.sub(sum,velocity);
    steer.limit(maxForce);
    applyForce(steer);
    }
    
   }
}
}
