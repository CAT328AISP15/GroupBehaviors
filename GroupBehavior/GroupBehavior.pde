Flock flock1;
Flock flock2;

float _offSet = 0.0;

void setup()
{
  size(640, 480);
  
  flock1 = new Flock();
  flock2 = new Flock();
  
  for(int i = 0; i < 20; i++)
  {
     Boid b = new Boid((int)random(width) - (width)/2, (int)random(height));
     color c = #0000CC;
     flock1.addBoid(b, c);
  }
  
  for(int i = 0; i < 20; i++)
  {
     Boid b = new Boid((int)random(width) + (width)/2, (int)random(height));
     color c = #003300;
     flock2.addBoid(b, c);
  }
}

void draw()
{
  background(#e0f2f6);
  
  _offSet += 0.01;
  
  float noiseValueX = noise(_offSet) * width;
  float noiseValueY = noise(_offSet) * height;
    
  flock1.run(new PVector(noiseValueX + 50, 5)); // Adding 50 to get it target the center of the paddle
  flock2.run(new PVector(5, noiseValueY + 50)); // Adding 50 to get it target the center of the paddle
  
  flock1.seperateFromFlock(flock2.boids);
  flock2.seperateFromFlock(flock1.boids);
  
  rect(noiseValueX, 5, 100, 5);
  rect(5, noiseValueY, 5, 100);
}

void mouseClicked()
{
  flock1.addBoid(new Boid(mouseX, mouseY), #0000CC);
  flock2.addBoid(new Boid(mouseX, mouseY), #003300);
}
