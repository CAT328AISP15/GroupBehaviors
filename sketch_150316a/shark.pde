class shark
{
  float x = 0;
  float y = 0;
  float maxforce;
  float maxspeed;
  float wandertheta;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
   shark(float x, float y)
   {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    maxspeed = 4;
    maxforce = 0.1;
    wandertheta = 0;
  }
  
   void update() 
   {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
   void seek(PVector target) 
   {
     PVector scent = PVector.add(target,velocity);
    PVector desired = PVector.sub(scent,location);
    desired.normalize();
    desired.mult(maxspeed);
     PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  void hammerhead()
  {
    
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    triangle(x,y,(x+40),(y-40),(x+40),(y+40));
    popMatrix();
  }
  void avoid(PVector target)
  {
    float d = PVector.dist(location,target);
    if (d < 8)
    {
      wander();
    }
  }
   void wander()
   {
    float wanderR = 300;         
    float wanderD = 100;         
    float change = 0.3;
    wandertheta += random(-change,change);     
    PVector circleloc = velocity.get();
    circleloc.normalize();            
    circleloc.mult(wanderD);          
    circleloc.add(location);              
    float h = velocity.heading2D();       
    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc,circleOffSet);
    seek(target);

     
    //if (debug) drawWanderStuff(location,circleloc,target,wanderR);
  }  
}
