public class RecordTypeAssgnClass {
    
    Contact con; 
	public String contactId {get; set;} 
    
    public RecordTypeAssgnClass(){  }
    
	public RecordTypeAssgnClass(ApexPages.StandardController controller) {
    	contactId = controller.getId();
        System.debug(contactId);
    	con= [SELECT id, RecordTypeId  from Contact where id = : contactId];
        
    }
    public String recordType{
        get{
            RecordType typeName= [SELECT name from RecordType where sObjectType='Contact' and Id = : con.RecordTypeId];
        return typeName.name;
            }
        set;
    }
}