public class OnlineShoppingApp {   
    
    public List<Product2> productList{get;set;}
    public List<Purchase_Order_Line_Item__c> purchaseList{get;set;}
    public Purchase_Order__c order{get;set;}
    public Set<Id> productsToPurchaseItem{get;set;}
    public Id ProdId{get;set;}
    public Double Price{get;set;}
    public boolean informationDisplayPopUp {get; set;}
    public boolean OrderDisplayPopUp {get; set;}
    public List<Purchase_Order__c> ListOfOrder{get;set;}  
    
    //Constructor
    public OnlineShoppingApp(){
          productList = new List<Product2>();
          purchaseList = new List<Purchase_Order_Line_Item__c>();
          informationDisplayPopUp = false;
          OrderDisplayPopUp = false;
          ListOfOrder=new List<Purchase_Order__c>();
          productsToPurchaseItem = new Set<Id>();
          getProductList();
        }        

    //get the product items
     public void getProductList(){
        string Query = 'SELECT id,name,price__c FROM Product2';
        productList = Database.query(Query);
    }
    
    public void addOrder(){    
     order = new Purchase_Order__c();
     insert order;
    }
    
    //get the cart list
    public void addToCart(){
       
        Boolean found = false;
        if(!purchaseList.isEmpty()){
            Purchase_Order_Line_Item__c  temp = new Purchase_Order_Line_Item__c();
            for(Purchase_Order_Line_Item__c list1 : purchaseList){
                temp = list1;
                if(list1.Product__c == prodId){
                    found = true;
                    break;
                }
            }
             if(found){             
             	temp.Quantity__c = ++temp.Quantity__c;
                 Product2 p =[SELECT Id,Name,Price__c FROM Product2 WHERE id=:ProdId ];
                 temp.Unit__c=p.Price__c*temp.Quantity__c;
            }else{            
               addElement();
            }
        } else if( ProdId!=null){
            addElement();
        } 
    }
    
    public void addElement() {
        Product2 p =[SELECT Id,Name,Price__c FROM Product2 WHERE id=:ProdId ];
        Purchase_Order_Line_Item__c item = new Purchase_Order_Line_Item__c();
        item.Name = p.Name;
        item.Product__c = p.Id;
        item.Quantity__c = 1;
        item.Unit__c = p.Price__c;
        item.Purchase_Order_ID__c = order.Id;
        insert item;
        
        purchaseList.add(item);      
    }
    
       public void generateBillForPlacedOrder(){
       
       informationDisplayPopUp = true;
       upsert purchaseList;
       purchaseList=[Select id,name,Product__c,Quantity__c,Unit__c,Price__c from Purchase_Order_Line_Item__c where Purchase_Order_Id__c=:order.Id];
    }
    
    //Confirm Order
     public void confirm(){
        double price=0;
        double quantity =0;
        for(Purchase_Order_Line_Item__c purchaseOrder : purchaseList){
           price= price+purchaseOrder.Price__c;
           quantity = quantity+purchaseOrder.Quantity__c;
        }
      
        system.debug(order);
        upsert order;
        system.debug(order);
        ListOfOrder=[Select id,Name,Customer_Name__c,Address__c,Email__c,Total_Cost__c from Purchase_Order__c where Customer_Name__c != null];
        OrderDisplayPopUp = true;
        system.debug(ListOfOrder);
        
        purchaseList.clear();
     
        informationDisplayPopUp = false;
    }
    
      // to remove the order from the cart.
     public Void removeFromCart(){       
         Purchase_Order_Line_Item__c productInCart = [Select id, name,Quantity__c,Unit__c,Price__c from Purchase_Order_Line_Item__c where id=:prodId];
         Integer index = 0;
         for(Purchase_Order_Line_Item__c purchaseOrder : purchaseList){
             if(purchaseOrder.Id == productInCart.Id){
                 break;
             }
               index++;
         }       
         purchaseList.remove(index);
         delete productInCart;
    }
}