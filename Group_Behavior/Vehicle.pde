class Vehicle {

  // All the usual stuff
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float temp = 0.0;
  float temp2 = 0.0;

    // Constructor initialize all values
  Vehicle(float x, float y) 
  {
    location = new PVector(x, y);
    r = 12;
    maxspeed = 5;
    maxforce = 0.2; 
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }

  void applyForce(PVector force) 
  {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  
  void applyBehaviors(ArrayList<Vehicle> vehicles) 
  {
     PVector separateForce = separate(vehicles);
     temp += .01;
     PVector seekForce = seek(new PVector((noise(temp) * width), (noise(temp) * height)));
     //PVector seekForce = seek(new PVector(mouseX,mouseY));
     separateForce.mult(2);
     seekForce.mult(1);
     applyForce(seekForce); 
     applyForce(separateForce);
     update();
     display();
  }
  
   void applyBehaviors2(ArrayList<Vehicle> vehicles) 
   {
     PVector separateForce = separate(vehicles2);
     temp += .01;
     PVector seekForce = seek(new PVector((noise(temp) * height), (noise(temp) * width)));
     separateForce.mult(2);
     seekForce.mult(1);
     applyForce(seekForce); 
     applyForce(separateForce);
     update();
     display();
   }
   
   void applyBehaviors3(ArrayList<Vehicle> vehicles) 
   {
     PVector separateForce = separate(vehicles3);
     PVector alignForce = align(vehicles3);
     //PVector cohesionForce = cohesion(vehicles3);
     cohesion(vehicles3);
     temp2 += 1;
     PVector seekForce = seek(new PVector(temp2, 400));
     separateForce.mult(2);
     seekForce.mult(1);
     applyForce(seekForce); 
     applyForce(separateForce);
     //applyForce(cohesionForce);
     update();
     display();
   }
   
    // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) 
  {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    return steer;
  }

  PVector align(ArrayList<Vehicle> vehicles)
  {
    PVector align =  new PVector(0,0);
    return align;
    //Did not get to finish 
  }
  
  void cohesion(ArrayList<Vehicle> vehicles)
  {
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) 
    {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if (d > desiredseparation) 
      {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.mult(-d);      // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    } 
    if (count > 0) 
    {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
  
  // Separation
  // Method checks for nearby vehicles and steers away
  PVector separate (ArrayList<Vehicle> vehicles) 
  {
    //float desiredseparation = r*2;
    float desiredseparation = 2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) 
    {
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) 
      {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    return sum;
  }
  
   // Method to update location
  void update() 
  {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }
  
  void display() 
  {
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0, 0, r, r);
    popMatrix();
  }
}
