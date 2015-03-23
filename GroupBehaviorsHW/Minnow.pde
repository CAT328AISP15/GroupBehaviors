public class Minnow extends Entity
{
  
  Minnow()
  {
    m_maxLookDistance = 50;
  }
  void update()
  {
    //arrive(mouseX, mouseY);
    updatePosition();
    wrapAround();
  }
  
  void render()
  {
    //push matrix
    pushMatrix();
    
    //translate and rotate
    translate(m_position.x, m_position.y);
    
    //draw
    fill(0);
    ellipse(0, 0, 10, 10);
    
    //pop matrix
    popMatrix();
  }
  
  void lookAround(ArrayList<Entity> entityList)
  {
    if(FlockingBools.isSeperating)
    {
      PVector sepForce = separate(entityList);
      sepForce.mult(2);
      applyForce(sepForce);
    }
    if(FlockingBools.isAligning)
    {
      PVector alignForce = align(entityList);
      alignForce.mult(3);
      applyForce(alignForce);
    }
    if(FlockingBools.isCohesing)
    {
      PVector coheseForce = cohesion(entityList);
      coheseForce.mult(1);
      applyForce(coheseForce);
    }
  }
  public void lookAround(ArrayList<Entity> entityList, 
                         boolean isSeperating,
                         boolean isAligning,
                         boolean isCohesing)
  {
    if(isSeperating)
    {
      PVector sepForce = separate(entityList);
      sepForce.mult(2);
      applyForce(sepForce);
    }
    if(isAligning)
    {
      PVector alignForce = align(entityList);
      alignForce.mult(3);
      applyForce(alignForce);
    }
    if(isCohesing)
    {
      PVector coheseForce = cohesion(entityList);
      coheseForce.mult(1);
      applyForce(coheseForce);
    }
  }
}
