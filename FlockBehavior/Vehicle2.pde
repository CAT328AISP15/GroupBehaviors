class Vehicle2
{
 
 PVector location;
 PVector velocity;
 PVector acceleration;
 float r;
 float wandertheta;
 float maxforce;    
 float maxspeed;
 
 Vehicle2(float x, float y)
 {
   acceleration = new PVector(0,0);
   velocity = new PVector(0,0);
   location = new PVector(x,y);
   r = 6;
   wandertheta = 0;
   maxspeed = 2;
   maxforce = 0.02;
 }
 
 float getX()
 {
   return location.x;
 }
 
 float getY()
 {
   return location.y;
 }
 
 void run() 
 {
   update();
   borders();
   display();
 }
 
  void wander() {
    float wanderR = 25;         
    float wanderD = 80;         
    float change = 0.1;
    wandertheta += random(-change,change);   

    PVector circleloc = velocity.get();    
    circleloc.normalize();            
    circleloc.mult(wanderD);          
    circleloc.add(location);          
    
    float h = velocity.heading2D();   
    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc,circleOffSet);
    seek(target);

  }  

  void applyForce(PVector force) 
  {
    acceleration.add(force);
  }

  void seek(PVector target) 
  {
    PVector desired = PVector.sub(target,location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  
    applyForce(steer);
  }
  
  void update() 
  {
   velocity.add(acceleration);
   velocity.limit(maxspeed);
   location.add(velocity);
   acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading2D() + radians(90);
    fill(255,0,0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void borders() 
  {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}
 
