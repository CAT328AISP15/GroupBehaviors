//ALL CODE FROM SHIFFMAN THE NATURE OF CODE


flock t;
flock f;

float w = 0;


float b= 60;

void setup() {
  size(800,800);
  
  t = new flock();
  f = new flock();

    
  
  
  
  
}
void draw()
{
  background(47,214,214);
  PVector mouseL = new PVector (mouseX,mouseY);
    
    w += .001;
    float n = noise(w) * mouseX;
     float r = noise(w) * mouseY;

  
  t.swim(new PVector(n,400));
  f.swim(new PVector(400,r));
   
   if (b  > 0)
   {
     b-=1;
   }
   else if (b == 0)
   {
     
     t.addfish(new fish(mouseX,mouseY));
     f.addfish(new fish(random(mouseX),random(mouseY)));
     
     b = 60;
   }
   

}
//ALL CODE FROM SHIFFMAN THE NATURE OF CODE
