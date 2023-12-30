public with sharing class tracingDTController {
    @AuraEnabled(Cacheable =true)
    public static List<Supply_Billing__c> getSupply(String supplyName){
    
            String supplySelectName  ;
            List<Supply_Billing__c> supplySelect=[Select Id, Name from Supply_Billing__c where Name=:supplyName ];
            if(supplySelect.size()>0){
                supplySelectName = supplySelect[0].Name;

            }
        List<Supply_Billing__c> supplyList = [SELECT Id, Date__c,Invoice_No__c,Name, (SELECT Id, Name, Farmer_Name__c,General_Farmer__c,Paddy_Type__c, Village__c FROM Paddy_Purchases__r) FROM Supply_Billing__c WHERE Name = :supplySelectName];
        return supplyList;
    }
}