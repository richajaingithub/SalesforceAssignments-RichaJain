public class CreateContactOnAccountsIfExistsNot {
        
      public static void populateAccountContacts(Id contactId){
      
      // Get account id for the passed contact id
      List<Contact> accountIdListp = [SELECT AccountId from Contact where Id=:contactId];
          
      // Get the account for the passed contact Id
      List<Account>	accountsDetails = [SELECT Id, Name, (SELECT AccountId, Name, Email, HomePhone  FROM Contacts where AccountId =:accountIdListp.get(0).AccountId ) FROM Account WHERE Id = :accountIdListp.get(0).AccountId ];
		  
          List<String> idList = new List<String>();
          String allContactsForAccount='';
          for (Account accountItem:accountsDetails )    {
              for(Contact con : accountItem.contacts){
 				     idList.add(con.Id);
              }              
          }
      	  allContactsForAccount = String.join(idList, ',');
          
          Account a = accountsDetails.get(0);
          // Update the account field 
          try{
         	 a.ContactIDs__c = allContactsForAccount;
         	 update a;         
         } catch(DmlException e) {
    	 	System.debug('An unexpected error has occurred: ' + e.getMessage());
         }
  
       }
}