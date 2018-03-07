public class OpportunityPopulateManagerBillContact {
   
    public static void populateManagerBillContact(List<Opportunity> Opportunities){
     	
        Set<Id> billToContactSet = new Set<Id>();
        for (Opportunity opp:opportunities){
           	 billToContactSet.add(opp.BillToContact__c);
        }
                       
      	Map<Id,Contact> contactAccountMap = new Map<Id,Contact>([SELECT Id,Account.Id FROM Contact where Id = :billToContactSet ]);
        
        for (Opportunity oppItem : Opportunities){
             if(oppItem.BillToContact__c != null && oppItem.Manager__c == null )    {
                oppItem.Manager__c =contactAccountMap.get(oppItem.BillToContact__c).Account.Id ;             
          }
       }
    }
}