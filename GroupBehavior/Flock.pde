class Flock
{
  ArrayList<Boid> boids;
 
  Flock()
  {
    boids = new ArrayList<Boid>();
  }
  
  void run(PVector target)
  {
    for(Boid b : boids)
    {
      b.run(boids, target);
    } 
  }
  
  void seperateFromFlock(ArrayList<Boid> flockTarget)
  {
    for(Boid b : boids)
    {
      PVector sep = b.separate(flockTarget);
      b.applyForce(new PVector(sep.x * 20, sep.y * 20));
    } 
  }
  
  void addBoid(Boid b, color myColor)
  {
    b._myColor = myColor;
    boids.add(b); 
  }
}
