public class FarmerCreditTriggerHandler {
    Public static void UpdateReparentCreditRollUpSum(list<Farmer_Credit__c>OldList, List<Farmer_Credit__c>NewList, map<id,Farmer_Credit__c>CFoldmap){
        Set<string>ClientFarmerId=new Set<String>();
        for(Farmer_Credit__c SI:NewList){
            if(SI.Client_farmer__c!=null){
                ClientFarmerId.add(SI.Client_farmer__c);
                ClientFarmerId.add(CFoldmap.get(SI.id).Client_farmer__c);
            }
        } 
        // string OtherCreditRecordTypeLabel=system.Label.OtherCreditRecordTypeId;
      //  string KitCreditRecordTypeLabel=system.Label.KitCreditRecordTypeId;
       
         
        Map<Id, Decimal> accountTotalCreditMap = new Map<Id, Decimal>();
        Map<Id, Decimal> accountTotalCashCreditMap = new Map<Id, Decimal>();
        Map<Id, Decimal> accountTotalSeedsCreditMap = new Map<Id, Decimal>();
        List<Account> accountsToUpdate = [SELECT Id FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id,(SELECT Total_Invoice_Value__c,Cash_Credit__c,Seeds_Credit__c FROM Farmer_Credits__r) from Account where id in:ClientFarmerId];
        
        for (Account acc : accountsToUpdate) {
            accountTotalCreditMap.put(acc.Id, 0);
            accountTotalCashCreditMap.put(acc.id,0);
            accountTotalSeedsCreditMap.put(acc.id,0);
        }
        
        for (Farmer_Credit__c CF : [SELECT Client_farmer__c, Total_Invoice_Value__c,Cash_Credit__c,Seeds_Credit__c FROM Farmer_Credit__c
                                    WHERE Client_farmer__c IN :ClientFarmerId])
        {
           if(Cf.Total_Invoice_Value__c!=null)
            {
            accountTotalCreditMap.put(CF.Client_farmer__c, accountTotalCreditMap.get(CF.Client_farmer__c) + CF.Total_Invoice_Value__c);
            }
           if(CF.Cash_Credit__c!=null)
          {
            accountTotalCashCreditMap.put(CF.Client_farmer__c, accountTotalCashCreditMap.get(CF.Client_farmer__c) + CF.Cash_Credit__c);
          }
             if(CF.Seeds_Credit__c!=null)
          {
            accountTotalSeedsCreditMap.put(CF.Client_farmer__c, accountTotalSeedsCreditMap.get(CF.Client_farmer__c) + CF.Seeds_Credit__c);
          }
        }
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        for (Account acc : accountsToUpdate) {
            Decimal totalCreditValue = accountTotalCreditMap.get(acc.Id);
            acc.Total_Farmer_Credit__c = totalCreditValue;
            Decimal totalCashCreditValue = accountTotalCashCreditMap.get(acc.Id);
            acc.Total_Cash_Credit__c = totalCashCreditValue;
            Decimal totalSeedsCreditValue = accountTotalSeedsCreditMap.get(acc.Id);
            acc.Total_Seeds_Credit__c = totalSeedsCreditValue;
            accountsToUpdateWithRollup.add(acc);
        }
        
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    }
    Public static void updateCreditRollupsum(List<Farmer_Credit__c>FCList){
        Set<string>ClientFarmerId=new Set<String>();
        for(Farmer_Credit__c SI:FCList){
            if(SI.Client_farmer__c!=null){
                ClientFarmerId.add(SI.Client_farmer__c);
                
            }
        }
        
       // string KitCreditRecordTypeLabel=system.Label.KitCreditRecordTypeId;
       // string OtherCreditRecordTypeLabel=system.Label.OtherCreditRecordTypeId;
        Map<Id, Decimal> accountTotalCreditMap = new Map<Id, Decimal>();
        Map<Id, Decimal> accountTotalCashCreditMap = new Map<Id, Decimal>();
        Map<Id, Decimal> accountTotalSeedsCreditMap = new Map<Id, Decimal>();
        List<Account> accountsToUpdate = [SELECT Id FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id, (SELECT Total_Invoice_Value__c,Cash_Credit__c,Seeds_Credit__c FROM Farmer_Credits__r) from Account where id in:ClientFarmerId];
        
        for (Account acc : accountsToUpdate) {
            accountTotalCreditMap.put(acc.Id, 0);
            accountTotalCashCreditMap.put(acc.id,0);
            accountTotalSeedsCreditMap.put(acc.id,0);
        }
        
        for (Farmer_Credit__c CF : [SELECT Client_farmer__c, Total_Invoice_Value__c,Cash_Credit__c,Seeds_Credit__c  FROM Farmer_Credit__c WHERE Client_farmer__c IN :ClientFarmerId]) {
            if(Cf.Total_Invoice_Value__c!=null)
            {
            accountTotalCreditMap.put(CF.Client_farmer__c, accountTotalCreditMap.get(CF.Client_farmer__c) + CF.Total_Invoice_Value__c);
            }
           if(CF.Cash_Credit__c!=null)
          {
            accountTotalCashCreditMap.put(CF.Client_farmer__c, accountTotalCashCreditMap.get(CF.Client_farmer__c) + CF.Cash_Credit__c);
          }
             if(CF.Seeds_Credit__c!=null)
          {
            accountTotalSeedsCreditMap.put(CF.Client_farmer__c, accountTotalSeedsCreditMap.get(CF.Client_farmer__c) + CF.Seeds_Credit__c);
          }
        }
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        for (Account acc : accountsToUpdate) {
            Decimal totalCreditValue = accountTotalCreditMap.get(acc.Id);
            acc.Total_Farmer_Credit__c = totalCreditValue;
            Decimal totalCashCreditValue = accountTotalCashCreditMap.get(acc.Id);
            acc.Total_Cash_Credit__c = totalCashCreditValue;
            Decimal totalSeedsCreditValue = accountTotalSeedsCreditMap.get(acc.Id);
            acc.Total_Seeds_Credit__c = totalSeedsCreditValue;
            accountsToUpdateWithRollup.add(acc);
        }
        
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    }
}