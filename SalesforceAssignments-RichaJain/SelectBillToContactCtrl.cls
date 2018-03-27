public class SelectBillToContactCtrl {
	
    public Id selectedContact {get;set;}
    Opportunity Opp ;
    
    public List<selectOption> contactNames{  
        get{
            
    		if (null != ApexPages.currentPage().getParameters().get('id') ){
    			Opp = SelectBillToContactDao.getOpportunityDetails(ApexPages.currentPage().getParameters().get('id'));  
    		}            
            List<SelectOption> options = new List<SelectOption>();
            List<Contact> names=SelectBillToContactDao.getAllContactsForManager();              
            for (Contact contactItem : names){
                options.add(new SelectOption(contactItem.Id,contactItem.Name));
            }
            return options;
        } 
	   set;
    }
    
    public PageReference save(){ 
        Opp.BillToContact__c = selectedContact; 
        update opp;        
        PageReference pgRref = new PageReference('/'+Opp.Id);        
        return pgRref;
    }
        
    public PageReference clear(){ 
        Opp.BillToContact__c = null; 
        update opp;        
        PageReference pgRref = new PageReference('/'+Opp.Id);        
        return pgRref;
    }
        
    public PageReference cancel(){
		PageReference pgRref = new PageReference('/'+Opp.Id);        
        return pgRref;
    }
}