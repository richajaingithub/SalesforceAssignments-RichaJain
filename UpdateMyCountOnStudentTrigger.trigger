trigger UpdateMyCountOnStudentTrigger on Student__c (after insert, after update) {
  
          try {
                for (Student__c co : Trigger.new){
                    Class__c po = [SELECT Id,NumberOfStudents__c FROM Class__c WHERE Id = :co.Class__c];
                    po.MyCount__c = po.NumberOfStudents__c;
                    update po;
                }
            } catch (Exception e) {
                System.debug(e);
       }
   }