
ArrayList<Entity> entityList;

public static final int FLOCKER_COUNT = 50;
public static final int BG_COLOR = 0xFFFFFFFF;

void setup()
{
  //setup screen
  size(800, 800);
  
  //create starting entities
  entityList = new ArrayList<Entity>();
  for(int i = 0; i < FLOCKER_COUNT; i++)
  {
    Minnow f = new Minnow();
    f.m_position.x = random(0, width);
    f.m_position.y = random(0, height);
    
    f.m_velocity.x = random(-1, 1);
    f.m_velocity.y = random(-1, 1);
    f.m_velocity.setMag(f.m_maxSpeed);
    entityList.add(f);
  }
}

void draw()
{
   //clear BG
  background(BG_COLOR);
  
  //update entities
  for(int i = entityList.size() - 1; i >= 0; i--)
  {
    entityList.get(i).lookAround(entityList);
    entityList.get(i).update();
  }

  //render entities
  for(int i = entityList.size() - 1; i >= 0; i--)
  {
    entityList.get(i).render();
  }
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

