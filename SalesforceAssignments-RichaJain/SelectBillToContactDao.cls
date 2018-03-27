public class SelectBillToContactDao {    
   
    public static Opportunity getOpportunityDetails(String managerId){
        if (null != managerId){
        	return [SELECT id, BillToContact__c from opportunity where Manager__c= :managerId]; 
        }
        return null;
    }
    
    public static List<Contact> getAllContactsForManager(){    
        
       if (null != ApexPages.currentPage().getParameters().get('id')){
       	   Account acc= [SELECT id,(SELECT id from Contacts) from Account where Id=:ApexPages.currentPage().getParameters().get('id')]; 
       	   return [SELECT Id,Name FROM Contact WHERE Id = :acc.contacts];
       }
       return null;
    }  
   
}