public class AddStudentInClass {

    public String firstName {get;set;}
    public String lastName {get;set;}
    public String className {get;set;}
    public String msg {get;set;}
    
    public AddStudentInClass(ApexPages.StandardController controller){}
    
    public void saveStudentinThisClass(){
        try{
        System.debug('Start saving the Student');
        Student__c st = new Student__c();
        st.First_Name__c = firstName;
        st.Last_Name__c = lastName;
        st.Class__c = apexpages.currentpage().getparameters().get('ClassId');  
        insert st;
        System.debug('Savedthe Student');
            msg = 'Record saved successfully';
        }catch(Exception e){
            msg = 'Process Failed';
        }
        
    }
}