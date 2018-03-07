trigger StopDeletionClassTrigger on Class__c (before delete) {

    List<Student__c> femaleStudents = [SELECT Id FROM Student__c where Sex__c ='FEMALE' and Class__c in :Trigger.oldMap.keySet()];
        
    if (femaleStudents.size() > 0){
        Trigger.old.get(0).addError('Deletion not allowed for Female Students');
    }
}