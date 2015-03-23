class Vehicle
{
  float maxSpeed;
  float maxForce;
  float r;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Vehicle(float x, float y)
  {
    location = new PVector(x, y);
    r = 6;
    maxSpeed = 1.5;
    maxForce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }
  
  void update()
  {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display()
  {
     stroke(255);
     fill(255, 200, 0);
     pushMatrix();
     translate(location.x, location.y);
     triangle(0,0,3,6,6,0);
     popMatrix();
  }
  
  PVector separate(ArrayList<Vehicle> vehicles)
 {
   float howFarApart = r *1.5;
   PVector sum = new PVector();
   int count = 0;
   for(Vehicle other: vehicles)
   {
     float d = PVector.dist(location,other.location);
     
     if(d>0 && d<howFarApart)
     {
       PVector diff = PVector.sub(location,other.location);
       diff.normalize();
       diff.div(d);
       sum.add(diff);
       count++;
     }
   }
   if(count > 0)
   {
     sum.div(count);
     sum.normalize();
     sum.mult(maxSpeed);
     sum.sub(velocity);
     sum.limit(maxForce);
   }
   return sum;
  }
  
  PVector seek(PVector target) 
  {
   PVector desired = PVector.sub(target,location);
   desired.setMag(maxSpeed);
   PVector steer = PVector.sub(desired,velocity);
   steer.limit(maxForce); 
   return steer;
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void applyBehaviors(ArrayList<Vehicle> vehicles, Vehicle2 chase)
  {
   PVector getAway = separate(vehicles);
   PVector mouse = new PVector(chase.getX(),chase.getY());
   PVector seekForce = seek(mouse);
   getAway.mult(1.5);
   applyForce(getAway);
   applyForce(seekForce);
  }
  
 
}
