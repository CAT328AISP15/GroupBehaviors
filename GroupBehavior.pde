
TaskForce ss1;
FlowField f1;

void setup() 
{
  size(500, 500);
  ss1 = new TaskForce();
  f1 = new FlowField(10);
  for (int i = 0; i < 200; i++) 
  {
    Agent a = new Agent(width/2, height/2);
    ss1.addAgent(a);
  }
}

void mouseDragged() 
{
  ss1.addAgent(new Agent(mouseX, mouseY));
}

void draw() 
{
  background(255);
  ss1.run();
}

