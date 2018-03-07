public class FetchAllSObjects {
 public List<String> getAllSObjects()
 {   
      List<String> allSObjects = new List<String>();
      for(Schema.SObjectType f : Schema.getGlobalDescribe().Values())
      {
         allSObjects.add(f.getDescribe().getLabel());
      }
      return allSObjects;
  }
}