trigger OppTriggerManagerUpd on Opportunity (before update) {
     OpportunityPopulateManagerBillContact.populateManagerBillContact(Trigger.New);
   
}