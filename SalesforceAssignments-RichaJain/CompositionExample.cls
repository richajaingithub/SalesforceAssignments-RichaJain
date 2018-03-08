public class CompositionExample {

    public String soqlQuery {get;set;}
    public Integer noOfRecords {get;set;}
    public Integer size{get;set;}
	public String column{get;set;}
    public boolean errors{get;set;}
    public String sortField{get;set;}
    
    //Populate the list size when query returns any result
    public List<sObject> recordList{
        get{
            if(con != null && recordList == null){
                size= 5;
             con.setPageSize(size);
             noOfRecords = con.getResultSize();
             return con.getRecords();
             }
        else
            {
            noOfRecords =0;
            size=1;
            return null;
            }
    }
    set;
  }
    
    public List<String> fieldsList{
        get{
            if(SOQLQuery!=null){
                try{
                String query = SOQLquery.toUpperCase();
                String subString = query.substringBetween('SELECT ',' FROM'); 
                List<String> fieldsNameList = subString.split(',');
                fieldsList = new List<String>();
                for(String columnName : fieldsNameList){
                    columnName = columnName.trim();
                    if(columnName.contains('.')){
                        columnName = columnName.substringAfter('.');
                    }
                    fieldsList.add(columnName);
                }
            } catch(Exception e){
                errors=true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Wrong Query Entered. '+e.getMessage()));
                return null;
                }
              }
          return fieldsList;
        }
        set;
    } 
    
    // the current sort direction. defaults to ascending
    public String sortDirection {
        get  { if (sortDirection == null) {  sortDirection = 'asc'; } return sortDirection; 
             }
        set;
    }
    
    // Execute the passed Query
    public void executeQuery(){
       if (null != soqlQuery){
           try{
              con = new ApexPages.StandardSetController(Database.query(soqlQuery));
           }catch(Exception e){
               errors=true;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Wrong Query Entered. '+e.getMessage()));
           }
        }     
     }
    
    public void sort(){        
        sortDirection = sortDirection.equals('asc') ? 'desc' : 'asc';        
        System.debug('sortDirection = '+sortDirection);
        soqlQuery = soqlQuery + ' Order by ' +  sortField  + ' ' +sortDirection ;        
        executeQuery();
        System.debug('soqlQuery aftre sporting added = '+soqlQuery);
     }
    
    public Boolean hasNext {
        get {
            if(con != null)
                return con.getHasNext();
            else
                return false;
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            if(con != null)
                return con.getHasPrevious();
            else
                return false;
        }
        set;
    }
  
    public Integer pageNumber {
        get {
            if(con != null)
                return con.getPageNumber();
            else
                return 0;
        }
        set;
    }
    
    public void first() {
        con.first();
    }
  
    public void last() {
        con.last();
    }
  
    public void previous() {
        con.previous();
    }
  
    public void next() {
        con.next();
    }
    
    public ApexPages.StandardSetController con{
        get{
            return con;
        }
        set;
    }  
    
     public pageReference refresh() {
     	con=null;
        executeQuery();
        return null; 
     }
}