global class EmailOpportunityOwner implements Database.Batchable<sObject>  {
    
     global Database.QueryLocator start(Database.BatchableContext bc) {
          return Database.getQueryLocator([Select Id,owner.email from Opportunity where LastModifiedDate < LAST_N_DAYS:30]);
       }

    global void execute(Database.BatchableContext bc, List<Opportunity> records){
      
      List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();  
        
     for(Opportunity opp:records){
      
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
	  List<String> sendTo = new List<String>();
      sendTo.add(opp.owner.email);
      mail.setToAddresses(sendTo);
      mail.setReplyTo('megha.negi@metacube.com');
      mail.setSenderDisplayName('Opportunity Scheduler Assignment');
    
      mail.setSubject('Opportunity not Updated since 30 days');
      String body = 'Dear ' ;
      body += 'Opportunity is not modified since last 30 days. Please take the required actions.   ';
    
      mail.setHtmlBody(body);
      mails.add(mail);
    }      
         Messaging.sendEmail(mails);
  }
      
    global void finish(Database.BatchableContext bc){
        System.debug('Completed');
    }

}