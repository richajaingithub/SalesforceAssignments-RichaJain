public class StudentClassDetails {

    private static final List<Boolean> isWorkingDay;
	private static final Integer workingDaysInWeek;
    private static final Date monday = Date.newInstance(1900, 1, 3);
	private static Integer getDayOfWeek(Date value) {
    	return Math.mod(monday.daysBetween(value), 7);
	}
	static {
	    	isWorkingDay = new List<Boolean> { true, true, true, true, true, false, false };
    	   	workingDaysInWeek = 5;
	}    
    
    // 1. Create a class and a static function which take classid as argument and returns all names of the students in that class as a list.
    public static List<String> getAllStudentNamesForClass(String classId){
             
        List<String> students = new List<String>();
        
        if(null !=classId){
        List<Student__c> StudentNamesOfClass = [select First_name__c, last_name__c from student__c where class__r.id =:classId];
            for(Integer i=0;i<StudentNamesOfClass.size();i++){
            	students.add(StudentNamesOfClass.get(i).First_name__c + ' ' +StudentNamesOfClass.get(i).Last_name__c);
                System.debug(students.get(i));
            }
        }
        return students;
    }
         
       // 2. Create a function which returns a map where key is class and value is set of studentid in it.
        public Map<Id,Set<Id>> getClassWithStudents(){
           
            Map<Id,Set<Id>> classStudentMap = new Map<Id,Set<Id>>();
            
            List<Student__c> studentList = [select Class__c, Id from Student__c]; 
            
            Set<Id> studentSet = new Set<Id>();
            
            for (Student__c s: studentList){
                if (!classStudentMap.containsKey(s.Class__c)){
                    Set<Id> setofStudent = new Set<Id>();
                    setofStudent.add(s.Id);
                    classStudentMap.put(s.Class__c,setofStudent);
                }else{
                    Set<Id> sSet=classStudentMap.get(s.Class__c);
                    classStudentMap.get(s.Class__c).add(s.Id);
                    classStudentMap.put(s.Class__c,sSet);
                }
            }
            
            // Print the Map values
             for (Id key : classStudentMap.keySet()) {
    				Set<Id> studentIds = classStudentMap.get(key);
                 for (Id sid :studentIds){
    				System.debug('Class= '+key + ' ' + 'StudentID ='+ sid);
					}
                 System.debug('Starting with the new Class id for their Student details');
             }
            return classStudentMap ;
        }
   
    // 3. Create a function which take 2 dates as argument and return number of working days between two days excluding both days(Saturday and Sunday is nonworking)
    public static Integer getWorkingDays(Date startDate, Date endDate) {
    
    if(workingDaysInWeek == 0 || startDate == null || endDate == null) {
        return 0;
    } else {
        Integer difference = startDate.daysBetween(endDate);
        if(difference == 0) {
           
            return isWorkingDay[getDayOfWeek(startDate)] ? 1 : 0;
        } else if(workingDaysInWeek == 7) {
         
            return difference;
        } else {
            Integer wholeWeeks = Math.floor(difference / 7).intValue();
            Integer workingDays = wholeWeeks * workingDaysInWeek;
            Integer dayOfWeek = getDayOfWeek(endDate);
            for(Integer remainder = Math.mod(difference, 7); remainder >= 0; remainder--) {
                if(isWorkingDay[dayOfWeek]) {
                    workingDays++;
                }
                dayOfWeek--;
                if(dayOfWeek < 0) {
                    dayOfWeek = 6;
                }
            }
            System.debug('Working days between '+startDate + ' and '+ endDate + ' ='+workingDays);
            return workingDays;
        }
      }
   }
    
    
    
}