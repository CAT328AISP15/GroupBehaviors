public static class AnimalManager
{
  static HashMap<String, ArrayList<Entity>> m_animalLists;
  
  AnimalManager()
  {
    m_animalLists = new HashMap();
  }
  AnimalManager(String[] types)
  {
    for(String s : types)
    {
      if(!m_animalLists.containsKey(s))
      {
        m_animalLists.put(s, new ArrayList<Entity>());
      } 
    }
  }
  
  ArrayList getList(String listName)
  {
    if(m_animalLists.containsKey(listName))
    {
      return m_animalLists.get(listName);
    }
    return null;
  }
  void addAnimal(String animalType, Entity animal)
  {
    if(!m_animalLists.containsKey(animalType))
    {
      println("TYPE NOT FOUND, ANIMAL NOT ADDED");
    }
    else
    {
      m_animalLists.get(animalType).add(animal);
    }
  }
  
  void updateAll()
  {
    for(String keys : m_animalLists.keySet())
    {
      for(Entity animal : m_animalLists.get(keys))
      {
        animal.update();
      }
    }
  }
  void renderAll()
  {
    for(String keys : m_animalLists.keySet())
    {
      for(Entity animal : m_animalLists.get(keys))
      {
        animal.render();
      }
    }
  }
}
