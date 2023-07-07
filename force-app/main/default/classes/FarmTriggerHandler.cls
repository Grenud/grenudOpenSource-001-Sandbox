public class FarmTriggerHandler {
 public static void handleBeforeInsert(List<Farm__c> newFarms)
{
       Set<Id> clientIds = new Set<Id>();
    set<Id>FarmId= new set<Id>();
   Map<Id, Account> accountMap = new Map<Id, Account>();
    Map<String, String> clientIdCodeMap = new Map<String, String>();
    String myCustomLabel = System.Label.FarmFieldUserRecordTYpeID;

    for (Farm__c farm : newFarms) {
        if (farm.client_Farmer__c != null && farm.RecordTypeId == myCustomLabel) {
            clientIds.add(farm.client_Farmer__c);
            FarmId.add(farm.Id);
        }
    }

    List<Account> clientFarmers = [SELECT Id, Farmer_code__c,Village__c, Block__c, District__c, Father_Name__c FROM Account WHERE Id IN :clientIds];

    for (Account acc : clientFarmers) {
        clientIdCodeMap.put(acc.Id, acc.Farmer_code__c);
        accountMap.put(acc.Id, acc);
    }

    Farm__c lastFarm;
    try {
        lastFarm = [
            SELECT Farmer_Code__c, Series__c,client_Farmer__c, Name 
            FROM Farm__c 
            WHERE client_Farmer__c IN :clientIds 
            ORDER BY Series__c DESC 
            LIMIT 1
        ];
        
    } catch (QueryException e) {
        System.debug('No Farm record found');
    }

    Integer lastSeriesNumber = getLastSeriesNumber(lastFarm);
    //system.debug('lastSeriesNumber+'+lastSeriesNumber);
    for (Farm__c farm : newFarms) {
        if (farm.client_Farmer__c != null && farm.RecordTypeId == myCustomLabel) {
            Integer newSeriesNumber = lastSeriesNumber + 1;
            farm.Farmer_Code__c = clientIdCodeMap.get(farm.Client_Farmer__c);
            farm.Name = clientIdCodeMap.get(farm.Client_Farmer__c) + 'F' + newSeriesNumber;
            farm.Series__c=newSeriesNumber;
            lastSeriesNumber = newSeriesNumber;
            Account relatedAccount = accountMap.get(farm.client_Farmer__c);
            if (relatedAccount != null) {
                farm.Village__c = relatedAccount.Village__c;
                farm.Block__c = relatedAccount.Block__c;
                farm.District__c = relatedAccount.District__c;
                farm.Farmer_Code__c = relatedAccount.Farmer_code__c;
                farm.Father_Name__c = relatedAccount.Father_Name__c;
            }

        }
    }
}

private static Integer getLastSeriesNumber(Farm__c farm) {
    if (farm != null) {
        String seriesNumberString = farm.Name.substringAfter(farm.Farmer_Code__c + 'F');
        try {
            return Integer.valueOf(seriesNumberString);
        } catch (Exception e) {
            // Handle exception if series number is not a valid integer
        }
    }
    // Return default series number if no valid series number found
    return 0;
}
   public static void handleAfterInsert(List<Farm__c> newFarms) {
        Set<Id> idSet = new Set<Id>();
        List<Account> accountList = new List<Account>();
        
        for (Farm__c farm : newFarms) {
            idSet.add(farm.Client_Farmer__c);
        }
        
        List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Farms__r) FROM Account WHERE Id IN :idSet];
        
        for (Account acc : accounts) {
            Integer totalFarm = acc.Farms__r.size();
            acc.Total_Updated_Plot__c = totalFarm;
            accountList.add(acc);
        }
        
        update accountList;
    }
    
    public static void handleAfterDelete(List<Farm__c> deletedFarms) {
        Set<Id> idSet = new Set<Id>();
        List<Account> accountList = new List<Account>();
        
        for (Farm__c farm : deletedFarms) {
            idSet.add(farm.Client_Farmer__c);
        }
        
        List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Farms__r) FROM Account WHERE Id IN :idSet];
        
        for (Account acc : accounts) {
            Integer totalFarm = acc.Farms__r.size();
            acc.Total_Updated_Plot__c = totalFarm;
            accountList.add(acc);
        }
        
        update accountList;
    }
}