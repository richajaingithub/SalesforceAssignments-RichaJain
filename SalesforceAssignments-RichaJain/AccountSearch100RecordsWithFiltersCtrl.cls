public class AccountSearch100RecordsWithFiltersCtrl {

    public String billingCity {get;set;}
 	public String billingState {get;set;}
    public String billingCountry {get;set;}
    public List<Account> accountSearchResults {get;set;}   
    
    public PageReference search(){
           
        String query = 'select Name, AccountNumber,BillingCity,BillingState,BillingCountry from Account where id != Null ';
        
      	if(String.isNotEmpty(billingCity))
            query = query + ' and BillingCity like \'%'+billingcity+'%\'';      
        if(String.isNotEmpty(billingState))
            query = query + ' and billingState like \'%'+billingState+'%\'';       
        if(String.isNotEmpty(billingCountry))   
            query = query + ' and billingCountry like \'%'+billingCountry+'%\'';
         
        query = query + ' Order by Name Limit 100';
      
        accountSearchResults = Database.query(query);
        
        return null;
    }
}