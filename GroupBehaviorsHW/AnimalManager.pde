public static class AnimalManager
{
  static HashMap<String, ArrayList<Entity>> m_animalLists = new HashMap();
  
  AnimalManager()
  {
    m_animalLists = new HashMap();
  }
  AnimalManager(String[] types)
  {
    for(String s : types)
    {
      addType(s);
    }
  }
  
  //////////////////////////////////////////////////////////////////////
  public static ArrayList getList(String listName)
  {
    if(m_animalLists.containsKey(listName))
    {
      return m_animalLists.get(listName);
    }
    return null;
  }
  public static void addAnimal(String animalType, Entity animal)
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
  public static void addType(String animalType)
  {
    if(!m_animalLists.containsKey(animalType))
    {
      m_animalLists.put(animalType, new ArrayList<Entity>());
    } 
  }
  
  //////////////////////////////////////////////////////////////////////
  public static void updateAll()
  {
    for(String keys : m_animalLists.keySet())
    {
      for(Entity animal : m_animalLists.get(keys))
      {
        animal.update();
      }
    }
  }
  public static void renderAll()
  {
    for(String keys : m_animalLists.keySet())
    {
      for(Entity animal : m_animalLists.get(keys))
      {
        animal.render();
      }
    }
  }
  
  //////////////////////////////////////////////////////////////////////
  //looking around functions
  //////////////////////////////////////////////////////////////////////
  public static void allLook()
  {
    for(String keys : m_animalLists.keySet()) //for each list
    {
      for(Entity animal : m_animalLists.get(keys)) //for each animal in each list
      {
        for(String entityListKey : m_animalLists.keySet()) //send the animal every entity list to look at
        {
          animal.lookAround(m_animalLists.get(entityListKey));
        }
      }
    }
  }
  public static void allLookAt(ArrayList<Entity> targets)
  {
    for(String keys : m_animalLists.keySet()) //for each list
    {
      for(Entity animal : m_animalLists.get(keys)) //for each animal in each list
      {
        animal.lookAround(targets);
      }
    }
  }
  public static void allLookAt(String targets)
  {
    allLookAt(m_animalLists.get(targets));
  }
  public static void allLookAt(ArrayList<Entity> lookers, ArrayList<Entity> targets)
  {
    for(Entity animal : lookers) //for each animal in each list
    {
      animal.lookAround(targets);
    }
  }
  public static void allLookAt(String lookers, String targets)
  {
    allLookAt(m_animalLists.get(lookers), m_animalLists.get(targets));
  }
  public static void allLookAt(ArrayList<Entity> lookers, 
                               ArrayList<Entity> targets, 
                               boolean isSeperating,
                               boolean isAligning,
                               boolean isCohesing)
  {
    for(Entity animal : lookers) //for each animal in each list
    {
      animal.lookAround(targets, isSeperating, isAligning, isCohesing);
    }
  }
  public static void allLookAt(String lookers, 
                               String targets, 
                               boolean isSeperating,
                               boolean isAligning,
                               boolean isCohesing)
  {
    allLookAt(m_animalLists.get(lookers), m_animalLists.get(targets), isSeperating, isAligning, isCohesing);
  }
}
