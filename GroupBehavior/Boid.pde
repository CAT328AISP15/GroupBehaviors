class Boid
{
  PVector _loc;
  PVector _vel;
  PVector _accel;
  
  float _maxSpeed;
  float _maxForce;
  
  float _desiredSeparation;
  
  float _r;
  
  color _myColor;
  
  Boid(int x, int y)
  {
    initialize();
    
    _loc = new PVector(x, y);
  }
  
  void initialize()
  {
    _accel = new PVector(0,0);
    _vel = new PVector(0,0);
    
    _r = 10;
    _maxSpeed = 5;
    _maxForce = 0.1;
    
    _myColor = #690708;
    
    _desiredSeparation = _r * 2;
  }
  
  void flock(ArrayList<Boid> boids)
  {
    PVector sep = separate(boids);
    PVector ali = align(boids);
    PVector coh = cohesion(boids);
  
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
   
    applyForce(sep);
    applyForce(ali);
    applyForce(coh); 
  }
  
  void run(ArrayList<Boid> boids, PVector target)
  {
    flock(boids);
    applyForce(seek(target));
    update();
    display(); 
  }
  
  void update()
  {
    
    if(_loc.x > width)
    {
      _loc.x = 0;
    }
    
    if(_loc.x < 0)
    {
      _loc.x = width; 
    }
    
    if(_loc.y > height)
    {
      _loc.y = 0; 
    }
    
    if(_loc.y < 0)
    {
      _loc.y = height; 
    }
    
    _vel.add(_accel);
    _vel.limit(_maxSpeed);
    _loc.add(_vel);
    _accel.mult(0); 
  }
  
  void display()
  {
    float theta = _vel.heading() + PI/2;
   
    fill(_myColor);
    stroke(0);
    pushMatrix();
    translate(_loc.x, _loc.y);
    rotate(theta);
    beginShape();
    vertex(0, -_r*2);
    vertex(-_r, _r*2);
    vertex(_r, _r*2);
    endShape(CLOSE);
    popMatrix(); 
  }
  
  void applyForce(PVector force)
  {
    _accel.add(force); 
  }
  
  PVector seek(PVector target)
  {
    PVector desired = PVector.sub(target, _loc);
    desired.normalize();
    desired.mult(_maxSpeed);
    PVector steer = PVector.sub(desired, _vel);
    steer.limit(_maxForce);
   
   return steer; 
  }
  
  ///
  /// 
  ///
  
  PVector separate(ArrayList<Boid> boids)
  {
    PVector sum = new PVector();
    int count = 0;
   
    for(Boid other : boids)
    {
      float d = PVector.dist(_loc, other._loc);
      
      if( (d > 0) && (d < _desiredSeparation) )
      {
        PVector diff = PVector.sub(_loc, other._loc);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++; 
      }
    }
    
    if(count > 0)
    {
      sum.div(count);
      sum.normalize();
      sum.mult(_maxSpeed);
      PVector steer = PVector.sub(sum, _vel);
      steer.limit(_maxForce);
      
      return steer; 
    }
    else
    {
      return new PVector(0,0); 
    }
  }
  
  PVector align(ArrayList<Boid> boids)
  {
    float neighborBirds = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
   
    for(Boid other : boids)
    {
      float d = PVector.dist(_loc, other._loc);
      
      if( (d > 0) && (d < neighborBirds) )
      {
        sum.add(other._vel);
        count++; 
      }
    }
    
    if(count > 0)
    {
      sum.div(count);
      sum.normalize();
      sum.mult(_maxSpeed);
      PVector steer = PVector.sub(sum, _vel);
      steer.limit(_maxForce);
     
     return steer; 
    }
    else
    {
      return new PVector(0,0); 
    }
  }
  
  PVector cohesion(ArrayList<Boid> boids)
  {
    float neightborBirds = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
   
    for(Boid other : boids)
    {
      float d = PVector.dist(_loc, other._loc);
      
      if( (d > 0) && (d < neightborBirds) )
      {
        sum.add(other._loc);
        count++; 
      }
    }
    
    if(count > 0)
    {
      sum.div(count);
      return seek(sum); 
    }
    else
    {
      return new PVector(0,0); 
    }
  }
}
