global class OpportunityScheduler {
    
       global void execute(SchedulableContext sc) {
      	EmailOpportunityOwner b = new EmailOpportunityOwner();
      	database.executebatch(b);
      }

}