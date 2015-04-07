class TaskForce 
{
  ArrayList<Agent> taskForce;
  TaskForce() 
  {
    taskForce = new ArrayList<Agent>();
  }

  void run() 
  {
    for (Agent a : taskForce) 
    {
      a.run(taskForce);
    }
  }

  void addAgent(Agent b) 
  {
    taskForce.add(b);
  }

}
