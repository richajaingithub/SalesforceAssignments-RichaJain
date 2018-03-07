public with sharing class JsonGenerator {
    public String jsonData {get;set;}
    public List<JsonValue> jsonString  {get;set;}
    
    public JsonGenerator(){
        List<Account> accountList = [SELECT Name,Industry from Account];
        jsonData = JSON.serialize(accountList);
        jsonString = (List<jsonvalue>)System.JSON.deserialize(jsonData , List<JsonValue>.class);
    }
    
     public class JsonValue{
         public String name{get;set;}
         public String industry{get;set;}              
    }
    
    
}