class Agent 
{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  int count;

  Agent(float x, float y) 
  {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x, y);
    r = 3.0;
    maxspeed = 3;
    maxforce = 0.05;
  }

  void run(ArrayList<Agent> taskForce) 
  {
    flock(taskForce);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) 
  {
    acceleration.add(force);
  }

  void flock(ArrayList<Agent> taskForce) 
  {
    PVector sep = separate(taskForce);
    PVector ali = align(taskForce);
    PVector coh = cohesion(taskForce);
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  void update() 
  {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  PVector seek(PVector target) 
  {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); 
    return steer;
  }

  void render() 
  {

    float theta = velocity.heading2D() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  PVector separate (ArrayList<Agent> taskForce) 
  {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    for (Agent other : taskForce) 
    {
      float d = PVector.dist(location, other.location);

      if ((d > 0) && (d < desiredseparation)) 
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);  
        steer.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  PVector align (ArrayList<Agent> taskForce) 
  {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;

    for (Agent other : taskForce) 
    {
      float d = PVector.dist(location, other.location);

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
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else 
    {
      return new PVector(0, 0);
    }
  }
  PVector cohesion (ArrayList<Agent> taskForce) 
  {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);

    for (Agent other : taskForce) 
    {
      float d = PVector.dist(location, other.location);

      if ((d > 0) && (d < neighbordist)) 
      {
        sum.add(other.location);
        count++;
      }
    }
    if (count > 0) 
    {
      sum.div(count);
      return seek(sum);
    } else 
    {
      return new PVector(0, 0);
    }
  }
  
  void follow(FlowField flow) 
  {
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
}

