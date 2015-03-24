// All this code comes from or is based off concepts from source below
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, 2011
// Dylan Conley
// A list of vehicles
ArrayList<Vehicle> vehicles;
ArrayList<Vehicle> vehicles2;
ArrayList<Vehicle> vehicles3;

void setup() 
{
  size(800,600);
  smooth();

  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  vehicles2 = new ArrayList<Vehicle>();
  vehicles3 = new ArrayList<Vehicle>();
  
}

void draw() 
{
  background(255);

  for (Vehicle v : vehicles) 
  {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles);
    v.applyBehaviors2(vehicles2);
    v.applyBehaviors3(vehicles3);
    // Call the generic run method (update, borders, display, etc.)
    //v.update();
    //v.display();
  }
  
  fill(0);
  text("Drag the mouse to generate new vehicles.",10,height-16);
}

void mouseDragged() 
{
  vehicles.add(new Vehicle(mouseX,mouseY));
  vehicles2.add(new Vehicle(mouseX,mouseY));
  vehicles3.add(new Vehicle(mouseX,mouseY));
  
  if (vehicles.size() > 100) 
  {
    vehicles.remove(0);
  }
  if (vehicles2.size() > 100) 
  {
    vehicles2.remove(0);
  }
  if (vehicles3.size() > 100) 
  {
    vehicles3.remove(0);
  }
}
