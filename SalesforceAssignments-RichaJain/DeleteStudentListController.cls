public class DeleteStudentListController {

    public String deletionStatus {get;set;}
    public boolean ifAnySelected {get;set;}
    
    ApexPages.StandardSetController setCon;
    private List<Student__c> studentList = new List<Student__c>();
    
    public DeleteStudentListController(ApexPages.StandardSetController stdSetController) {
    	setCon = stdSetController; 
        ifAnySelected =true;
        if (setCon.getSelected().size() == 0){
            deletionStatus = 'No Records Selected';
            ifAnySelected = false;
        }
    }    

	public PageReference redirectToListAfterDelete() {
        delete (Student__c[])setCon.getSelected();
        System.debug('Entered the redirect method');
  		pagereference pageref= new pagereference('https://ap5.salesforce.com/a05?fcf=00B7F000008EWqu');      
        pageref.setRedirect(false);
		return pageRef;
	}
    
}