trigger StudentTriggerAfterMaxLimit on Student__c(before insert) {
    for(Student__C st : Trigger.New)
   {
     if(st.Class__C != null)
     {
       Class__c classST = [SELECT NumberOfStudents__c,MaxSize__c FROM Class__c WHERE ID = :st.Class__C];
       if(classST.NumberOfStudents__c>=classST.MaxSize__c)
       {
           st.addError('The class has already reached its limit');
       }
     }
   }  
}