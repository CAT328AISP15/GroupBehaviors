/*
seperation
int count = 0;
void seperate (ArrayList <Vehicle> boids>
{
  PVector sum;
  for(Vehicle boid: boids)
   {
     float distance = PVector.dist(location, other.location);
     if(distance > 0 && distance < 50)
       {
       PVector diff = PVector.sub(location, boids.location); // flee equation
       diff.normalize();
       sum.add(diff);
       count++;\
       }
   }
   
   sum.div(count);
   sum.normlalize;
   sum.mult(maxSpeed);
   PVector steed = PVector.sub(sum, velocity);
   steer.limit(maxForce);
   applyForce(steer);
}


alignment

*/

ArrayList<box> boxes;
void setup()
{
  size(800, 800);
 
  boxes = new ArrayList<box>();
}

void draw()
{
  background(255);
  if(mousePressed && boxes.size() < 30)
  {
    box new1 = new box();
    boxes.add(new1);
  }
  
  for(box j: boxes)
  {
    
    j.update();
    j.seek(new PVector(mouseX, mouseY));
   // j.seperate(boxes);
    j.cohesion(boxes);
    j.construct();
    
  }
  
  
  
}
