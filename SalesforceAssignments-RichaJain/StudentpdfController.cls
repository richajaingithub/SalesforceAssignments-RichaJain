public class StudentpdfController {
    	
    public Id idVal {get;set;}

	public StudentpdfController(ApexPages.StandardController stdController){
        idVal = stdController.getRecord().Id;	
    } 

	public pageReference savePDF(){ 
		PageReference pagePdf = new PageReference('/apex/GeneratePdfForStudentWithData'); 
		pagePdf.getParameters().put('id', idVal);        
		Blob pdfPageBlob; 
		pdfPageBlob = pagePdf.getContentAsPDF();
        System.debug('pdfPageBlob = '+pdfPageBlob);
    	Attachment a = new Attachment(); 
		a.Body = pdfPageBlob; 
		a.ParentID = idVal; 
		a.Name = 'StudentCustomPdf.pdf'; 
		a.Description = 'TestDescription1'; 
		
        insert a; 

		//return new PageReference('/' + idVal); 
		return pagePdf;
    } 
 
}