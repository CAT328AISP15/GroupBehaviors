
ArrayList<Box> boxes;
void setup()
{
  size(800, 800);
  print("Hold the Right Arrow key to use the seperate method, use the Left Arrow Key for cohesion");
  boxes = new ArrayList<Box>();
}

void draw()
{
  
  background(255);
  if(mousePressed && boxes.size() < 30) // creates boxes when mouse button is pressed (adds them to an array)
  {
    Box new1 = new Box();
    boxes.add(new1);
  }
  
  for(Box j: boxes) //traverse through Array of Box objects
  {
    
    j.update();
    if(keyPressed)
      if(key == CODED)
      if(keyCode == RIGHT)
        j.seperate(boxes);
      if(keyCode == LEFT)
        j.cohesion(boxes);
    //j.seek(new PVector(107, 700));
    j.construct();
    
  }
  
  
  
  
  
}
