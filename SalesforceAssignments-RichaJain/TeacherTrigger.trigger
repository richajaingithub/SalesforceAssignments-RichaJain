trigger TeacherTrigger on Contact (before insert,before update) {
   // Prevent the insertion/update of Teacher if they teach Hindi Subjects.
    for(Contact rec : Trigger.New ){
        if(rec.Subjects__c != null && rec.Subjects__c.indexOf('Hindi') != -1 )
        	rec.addError('Cannot modify the Teachers record who teach Hindi... So be ware');
        	System.debug('Error occured');
        	
    }  
}