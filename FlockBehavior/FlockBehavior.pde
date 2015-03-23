ArrayList<Vehicle> vehicles;
Vehicle2 nomad;

void setup()
{
  size(800,400);
  vehicles = new ArrayList<Vehicle>();
  nomad = new Vehicle2(width/2, height/2);
  for (int i = 0; i < 50; i++) 
  {
   vehicles.add(new Vehicle(random(width),random(height)));
  }
}

void draw()
{
  background(0);
  nomad.wander();
  nomad.run();
  for(Vehicle yes : vehicles)
  {
    yes.display();
    yes.update();
    yes.applyBehaviors(vehicles, nomad);
  }
}

void mousePressed()
{
  vehicles.add(new Vehicle(mouseX,mouseY));
}
