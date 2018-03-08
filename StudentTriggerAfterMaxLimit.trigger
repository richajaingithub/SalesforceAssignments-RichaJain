trigger StudentTriggerAfterMaxLimit on Student__c(before insert) {
    
       for (Student__c item :Trigger.New ){
           if (item.class__r.MaxSize__c == item.class__r.NumberOfStudents__c) {
            System.debug('Found Error - Class is Full');
            item.addError('Class is Full.... No more Students can be added here');
        }
     }    
}