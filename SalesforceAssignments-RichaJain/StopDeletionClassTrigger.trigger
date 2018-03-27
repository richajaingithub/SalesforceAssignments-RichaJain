trigger StopDeletionClassTrigger on Class__c (before delete) {

    List<Class__c> errorFemaleStudentsInClass = StopDeletionClassHandler.errorForDeletionIfAnyFemaleIsThere(Trigger.Old);
   
    for (Class__c cl : errorFemaleStudentsInClass){   
        trigger.oldMap.get(cl.Id).addError('Deletion not allowed if any Female Students are there in class');
    }
}