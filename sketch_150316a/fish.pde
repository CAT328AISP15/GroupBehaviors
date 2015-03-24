class fish
{
  float x = 0;
  float y = 0;
  
  float maxforce;
  float maxspeed;
  float scared;
  float adr;
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  fish(float x, float y) 
   {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    maxspeed = 4;
    scared = maxspeed * 4;
    maxforce = 0.1;
    adr = maxforce *4;
  }
  void swim(ArrayList<fish> fishs, PVector target)
  {
    flock(fishs);
    applyForce(seek(target));
    update();
    salmon();
    
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
  
  void flock(ArrayList<fish> fishs)
  {
    PVector sep = separate(fishs);   
    PVector ali = align(fishs);      
    PVector coh = cohesion(fishs);
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
  
  PVector seekReturn(PVector target) 
   {
    PVector desired = PVector.sub(target,location);
     if (location.x < 100)
     {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (location.x > 700 )
    {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (location.y < 100)
    {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > 700)
    {
      desired = new PVector(velocity.x, -maxspeed);
    }
    
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    return steer;
   
  }
  
   PVector seek(PVector target) 
   {
    PVector desired = PVector.sub(target,location);
   /*  if (location.x < 100)
     {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (location.x > 700 )
    {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (location.y < 100)
    {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > 700)
    {
      desired = new PVector(velocity.x, -maxspeed);
    }
   else {*/
    
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
     return steer;
   //}
  }
  void flee(PVector target) 
   {
    float d = PVector.dist(location,target);
    if(d < 40)
    {
      PVector desired = PVector.add(target,location);
      if (location.x < 200)
      {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (location.x > 600 )
    {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (location.y < 200) 
    {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > 600)
    {
      desired = new PVector(velocity.x, -maxspeed);
    }
   else 
   {
      desired.normalize();
      desired.mult(scared);
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(adr);
      applyForce(steer);
   }
    }
  }
  
  void salmon()
  {
    float theta = velocity.heading() + PI/2;
    fill(245,56,113);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    triangle(x,y,(x+20),(y-20),(x+20),(y+20));
    popMatrix();
    
  }
  PVector separate(ArrayList<fish> fishs)
  {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    for (fish other : fishs) 
    {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < desiredseparation))
      {
        PVector diff = PVector.sub(location,other.location);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;            
      }
    }
    if (count > 0)
    {
      steer.div((float)count);
    }
    if (steer.mag() > 0) 
    {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
  PVector align (ArrayList<fish> fishs)
  {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (fish other : fishs)
    {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist))
      {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) 
    {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else 
    {
      return new PVector(0,0);
    }
  }
    PVector cohesion (ArrayList<fish> fishs)
    {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);  
    int count = 0;
    for (fish other : fishs)
    {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist)) 
      {
        sum.add(other.location); 
        count++;
      }
    }
    if (count > 0)
    {
      sum.div(count);
      return seekReturn(sum); 
    }
    else
    {
      return new PVector(0,0);
    }
  }
}
