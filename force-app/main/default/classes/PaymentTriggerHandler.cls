public class PaymentTriggerHandler
{
    public static void updateCashCreditAmountRollup(list<Payment__c>CashCreditList)
    {
        Set<string>ClientFarmerId=new Set<String>();
        
        for(Payment__c SI:CashCreditList){
            if(SI.Client_farmer__c!=null){
                ClientFarmerId.add(SI.Client_farmer__c);                
            }            
        }                
        Map<Id, Decimal> accountTotalCashCreditMap = new Map<Id, Decimal>();
        List<Account> accountsToUpdate = [SELECT Id FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id, (SELECT id,Total_Amount__c FROM Payments__r) from Account where id in:ClientFarmerId];        
        for (Account acc : accountsToUpdate) {
            accountTotalCashCreditMap.put(acc.Id, 0);
        }
         for (Payment__c PT : [SELECT id,Client_Farmer__c ,Total_Amount__c FROM Payment__c WHERE Client_farmer__c IN :ClientFarmerId]) {
            
            if(PT.Total_Amount__c!=null && PT.Client_Farmer__c!=null){
                accountTotalCashCreditMap.put(PT.Client_farmer__c, accountTotalCashCreditMap.get(PT.Client_farmer__c) + PT.Total_Amount__c);
            }
         }
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        
        for (Account acc : accountsToUpdate) {           
            Decimal totalCashCreditValue = accountTotalCashCreditMap.get(acc.Id);
            acc.Credit_Settlement_By_Cash__c = totalCashCreditValue;
            accountsToUpdateWithRollup.add(acc);
        }
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    } 

    public static void updateReparentCashCreditAmountRollup(list<Payment__c>OldList, List<Payment__c>NewList, map<id,Payment__c>CFoldmap)
    {
        Set<string>ClientFarmerId=new Set<String>();
        for(Payment__c PT:NewList){
            if(PT.Client_farmer__c!=null){
                ClientFarmerId.add(PT.Client_farmer__c);
                if (CFoldmap.get(PT.Id) != null && PT.Client_farmer__c != null) {
                ClientFarmerId.add(CFoldmap.get(PT.id).Client_farmer__c);
                }
            }
        }
        Map<Id, Decimal> accountTotalCashCreditMap = new Map<Id, Decimal>();
        List<Account> accountsToUpdate = [SELECT Id FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id, (SELECT id,Total_Amount__c FROM Payments__r) from Account where id in:ClientFarmerId];        
        for (Account acc : accountsToUpdate) {
            accountTotalCashCreditMap.put(acc.Id, 0);
        }
         for (Payment__c PT : [SELECT id,Client_Farmer__c ,Total_Amount__c FROM Payment__c WHERE Client_farmer__c IN :ClientFarmerId]) {
            
            if(PT.Total_Amount__c!=null && PT.Client_Farmer__c!=null){
                accountTotalCashCreditMap.put(PT.Client_farmer__c, accountTotalCashCreditMap.get(PT.Client_farmer__c) + PT.Total_Amount__c);
            }
         }
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        
        for (Account acc : accountsToUpdate) {           
            Decimal totalCashCreditValue = accountTotalCashCreditMap.get(acc.Id);
            acc.Credit_Settlement_By_Cash__c = totalCashCreditValue;
            accountsToUpdateWithRollup.add(acc);
        }
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    }
}