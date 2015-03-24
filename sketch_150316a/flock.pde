class flock
{
  ArrayList<fish> fishs;
  
  flock()
  {
    fishs = new ArrayList<fish>();
  }
  void swim(PVector target)
  {
    for (fish e : fishs)
    {
      e.swim(fishs,target);
    }
  }
  void addfish(fish e)
  {
    fishs.add(e);
  }
}
