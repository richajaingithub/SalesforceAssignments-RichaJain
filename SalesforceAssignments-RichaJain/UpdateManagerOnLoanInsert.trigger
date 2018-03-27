trigger UpdateManagerOnLoanInsert on Loan__c (before insert) {
	    
    Map<String,CityManager__c > cityMap = new Map<String,CityManager__c >([SELECT Name,Manager__c from CityManager__c ]);
        
    for (Loan__c loanItem:Trigger.New){
          System.debug('---- loanItem.CityManager__c = '+ loanItem.CityManager__c + ' cityMap.get(loanItem.CityManager__c) = '+ cityMap.get(loanItem.CityManager__c).Manager__c);
          loanItem.Manager__c = cityMap.get(loanItem.CityManager__c).Manager__c;
    }
}