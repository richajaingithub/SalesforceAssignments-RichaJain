public class StopDeletionClassHandler {
	public static List<Class__c> errorForDeletionIfAnyFemaleIsThere(List<Class__c> classes){        
        List<Class__c> femaleStudentsClass = [ SELECT Name ,(SELECT First_Name__c,Last_Name__c from Students__r where Sex__c = 'Female') FROM Class__c WHERE Id in :classes];
        return femaleStudentsClass;
    }
}