public class ClassManageController 
{
 	Class__c clsdata;
    public Id selectedClsId {get;set;}
   
    public ClassManageController(ApexPages.StandardController controller) {}
    
    public List<Class__c> loadData(){
            List<Class__c> lstClass = [SELECT id, Name, ClassTeacher__c, Fee__c, MaxSize__c FROM Class__c];
            return lstClass;
    }
    
    public List<Class__c> getClass(){
           return (loadData());
    }
    
    public void deleteClass(){
           Class__c deleteClass= [SELECT id from Class__c WHERE id= : selectedClsId];
           try{
               delete deleteClass;
               loadData();
           }catch(Exception e) {
               e.getMessage();
           }
     }
    
     public void editClass(){
            clsdata= [SELECT id, Name, ClassTeacher__c, Fee__c, MaxSize__c FROM Class__c WHERE id = : selectedClsId ];
     }
    
     public Class__c getEditData(){
           return clsdata;
     }
    
     public void updateClass(){
        try{
            update clsdata;
            clsdata= null;
        }
        catch(Exception e){
                   e.getMessage();
        }
     }
    
    
     public void cancelEdit(){
           clsdata= null;
           loadData();
    }
}