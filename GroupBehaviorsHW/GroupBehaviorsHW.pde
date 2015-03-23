/*INSTRUCTIONS:
Starts with 50 Minnows (circles). At first they are aligning, seperating, and cohesing.
use "a", "s", and "c" to toggle each function's use. (removing seperating or sep and align are the most interesting)

Spawn a shark with left click
sharks try to catch minnows
minnows avoid sharks while flocking together according to their rules.
*/


//ArrayList<Entity> entityList;

public static final int FLOCKER_COUNT = 50;
public static final int BG_COLOR = 0xFFFFFFFF;

void setup()
{
  //setup screen
  size(800, 800);
  
  //create starting entities
//  entityList = new ArrayList<Entity>();
  AnimalManager.addType("Minnow");
  for(int i = 0; i < FLOCKER_COUNT; i++)
  {
    Minnow f = new Minnow();
    f.m_position.x = random(0, width);
    f.m_position.y = random(0, height);
    
    f.m_velocity.x = random(-1, 1);
    f.m_velocity.y = random(-1, 1);
    f.m_velocity.setMag(f.m_maxSpeed);
    AnimalManager.addAnimal("Minnow", f);
    AnimalManager.addType("Shark");
//    entityList.add(f);
  }
}

void draw()
{
   //clear BG
  background(BG_COLOR);
  
  //update entities
  AnimalManager.allLookAt("Minnow", "Minnow");
  AnimalManager.allLookAt("Minnow", "Shark", true, false, false);
  AnimalManager.allLookAt("Shark", "Minnow", false, false, true);
  AnimalManager.updateAll();
  AnimalManager.renderAll();
}

void keyPressed()
{
  println(key);
  switch(key)
  {
    case 'a':
      FlockingBools.isAligning = !FlockingBools.isAligning;
      break;
    case 's':
      FlockingBools.isSeperating = !FlockingBools.isSeperating;
      break;
    case 'c':
      FlockingBools.isCohesing = !FlockingBools.isCohesing;
      break;
    case 'm':
      FlockingBools.isSeekingMouse = !FlockingBools.isSeekingMouse;
      break;
    default:
      break;
  }
}

void mouseClicked()
{
  Shark s = new Shark();
  s.m_position.x = mouseX;
  s.m_position.y = mouseY;
  AnimalManager.addAnimal("Shark", s);
}

