trigger TeacherTrigger on Contact (before insert,before update) {
   
        if(trigger.isInsert){
            List<Contact> errorTeachers = TeacherTriggerHandler.validateTeacher(Trigger.New);
            for(Contact c : errorTeachers) {
                c.addError('Cannot Add the Teachers record who teach Hindi... So be ware');
            }
        }    
        if(trigger.isUpdate){
            List<Contact> errorTeachers = TeacherTriggerHandler.validateTeacher(Trigger.old);
            for(Contact c : errorTeachers) {
                c.addError('Cannot modify the Teachers record who teach Hindi... So be ware');
        }
     } 
      
}