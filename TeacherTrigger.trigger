trigger TeacherTrigger on Teacher__c (before insert,before update) {

    // Prevent the insertion/update of Teacher if they teach Hindi Subjects.
    for(Teacher__c teacherRecord : Trigger.New ){
        if(teacherRecord.Subjects__c != null && teacherRecord.Subjects__c.indexOf('Hindi') != -1 )
        	teacherRecord.addError('Cannot modify the Teachers record who teach Hindi... So be ware');
    }
}