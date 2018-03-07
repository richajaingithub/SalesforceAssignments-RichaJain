public class StackAssgn3 {
  
    // on pop up - need to correct it : break the program when list is empty 
   	private static Integer INITIAL_CAPACITY_STACK = 5;
    private List<Object> items {get; set;}
        
    public StackAssgn3() {
        this.items = new List<Object>();
    }
    
    public Integer size() {
        return this.items.size();
    }
    
    public Boolean isEmpty() {
        return size() == 0;
    }
    
    public void push(Object itemToPush){
        if (INITIAL_CAPACITY_STACK == items.size()){
            System.debug('Stack is full, can not puch more items');
            return;
        }
        this.items.add(itemToPush);
    }
        
    public Object pop(){
         if (isEmpty()) {
            System.debug('Stack is empty, can not pop any items'); 
             return null;
        }
        return this.items.remove(size() - 1);
     }
    
    public void printAllStackItems(){
        System.debug('Items are below ');
        for(Object o : this.items){
            System.debug(' '+o);
        }
  
    }
}