trigger OpportunityDeleteOppLines on Opportunity (after update) {
	
    System.debug('Entered the trigger - OpportunityDeleteOppLines');
    List<OpportunityLineItem> opi = new List<OpportunityLineItem>();
    for(Opportunity opp : Trigger.New)
    {
       String oldStatus = Trigger.oldMap.get(opp.Id).Custom_Status__c;
       if(oldStatus != 'Reset' && opp.Custom_Status__c == 'Reset' )
       {
           opi = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId = :opp.Id ];          
           System.debug('Added the items in the list' + opi.size());
	   }
    }
    delete opi;
}