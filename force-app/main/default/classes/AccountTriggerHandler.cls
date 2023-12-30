public class AccountTriggerHandler {
    public static void handleAfterInsert(List<Account> newAccounts) {
        List<Farm__c> farmsToInsert = new List<Farm__c>();
        Map<Id, Integer> accountSeriesMap = new Map<Id, Integer>();

        Map<Id, Farm__c[]> existingFarmsMap = new Map<Id, Farm__c[]>();
        For(Account Acc:[SELECT Id, (Select id,Series__c from Farms__r) FROM Account WHERE ID IN :newAccounts]){
            existingFarmsMap.put(Acc.Id, Acc.Farms__r);
        }
            

        for (Account accObj : newAccounts) {
            // Determine the next series number based on existing Farm records
            Integer nextSeries = 1;
            if (existingFarmsMap.containsKey(accObj.Id)) {
                Farm__c[] existingFarms = existingFarmsMap.get(accObj.Id);
                nextSeries = existingFarms.size() + 1;
            }
            
            // Create the Farms with the appropriate series number
            if (accObj.Total_Plot__c != null) {
                for (Integer i = 1; i <= accObj.Total_Plot__c; i++) {
                    Farm__c farm = new Farm__c();
                    farm.Name = accObj.Farmer_Code__c + 'F' + nextSeries;
                    farm.Farmer_Code__c = accObj.Farmer_Code__c;
                    farm.Client_Farmer__c = accObj.Id;
                    farm.Series__c = nextSeries;
                    farmsToInsert.add(farm);
                    nextSeries++;
                }
            }
        }

        if (!farmsToInsert.isEmpty()) {
            insert farmsToInsert;
        }
    }
    
    public static void handleAfterUpdate(List<Account> updatedAccounts, Map<Id, Account> oldAccountsMap) {
    List<Farm__c> farmsToInsert = new List<Farm__c>();
    Map<Id, Decimal> accIdPlotMap = new Map<Id, Decimal>(); 
    Map<Id, Integer> accIdFarmLastNoMap = new Map<Id, Integer>();

    for (Account accObj : updatedAccounts) {
        if (accObj.Total_Plot__c != null && oldAccountsMap.get(accObj.Id).Total_Plot__c != null && accObj.Total_Plot__c > oldAccountsMap.get(accObj.Id).Total_Plot__c) {
            Decimal difference = accObj.Total_Plot__c - oldAccountsMap.get(accObj.Id).Total_Plot__c;
            accIdPlotMap.put(accObj.Id, difference);
        } else if (accObj.Total_Plot__c != null && oldAccountsMap.get(accObj.Id).Total_Plot__c == null) {
            accIdPlotMap.put(accObj.Id, accObj.Total_Plot__c); 
        }
    }

    Map<String, Farm__c> lastFarmMap = new Map<String, Farm__c>();
    for (Farm__c farm : [SELECT Name, Farmer_Code__c, Series__c FROM Farm__c WHERE Client_Farmer__c IN :accIdPlotMap.keySet() ORDER BY Series__c DESC]) {
        if (!lastFarmMap.containsKey(farm.Farmer_Code__c)) {
            lastFarmMap.put(farm.Farmer_Code__c, farm);
        }
    }
    
    for (Account accObj : updatedAccounts) {
        if (accIdPlotMap.get(accObj.Id) != null) {
            Integer lastFarmNumber = 0;
            if (lastFarmMap.containsKey(accObj.Farmer_Code__c)) {
                Farm__c lastFarm = lastFarmMap.get(accObj.Farmer_Code__c);
                lastFarmNumber = Integer.valueOf(lastFarm.Series__c);
                system.debug('lastFarmNumber'+lastFarmNumber);
            }
            Integer noOfRecords = lastFarmNumber + Integer.valueOf(accIdPlotMap.get(accObj.Id));
            for (Integer i = lastFarmNumber + 1; i <= noOfRecords; i++) {
                Farm__c farm = new Farm__c();
                farm.Name = accObj.Farmer_Code__c + 'F' + i;
                farm.Series__c = i;
                farm.Farmer_Code__c = accObj.Farmer_Code__c;
                farm.Client_Farmer__c = accObj.Id;
                farmsToInsert.add(farm);
            }
        }
    }

    if (!farmsToInsert.isEmpty()) {
        insert farmsToInsert;
    }
}
    
    public static void createContact(list<account>newAccount)
    {
        list<contact>conlist=new list<contact>();
        for(account acc:newAccount)
        {
            contact con = new contact();
            con.Phone=acc.Phone;
            con.LastName=acc.Name; 
            con.AccountId=acc.Id;
            conlist.add(con);
        }
        insert conlist;
    }
  
  /*  public static void handleAfterUpdate(List<Account> updatedAccounts, Map<Id, Account> oldAccountsMap)
    {
        List<Farm__c> farmsToInsert = new List<Farm__c>();
        map<Id, decimal>AccIdPlotmap=new map<Id, decimal>(); 
        map<Id,Integer>AccIdFarmLasNoMap=new map<id, integer>();
        for(Account AccObj:updatedAccounts){
            if(AccObj.Total_Plot__c!=null && oldAccountsMap.get(AccObj.id).Total_Plot__c!=null && AccObj.Total_Plot__c> oldAccountsMap.get(AccObj.id).Total_Plot__c ){
           decimal difference=AccObj.Total_Plot__c-oldAccountsMap.get(AccObj.id).Total_Plot__c;
                AccIdPlotmap.put(AccObj.id, difference);
        }
            else if(AccObj.Total_Plot__c!=null && oldAccountsMap.get(AccObj.id).Total_Plot__c==null ){
               AccIdPlotmap.put(AccObj.id, AccObj.Total_Plot__c); 
            }
        }
    
         Map<String, Farm__c> lastFarmMap = new Map<String, Farm__c>();
        for (Farm__c farm : [SELECT Name, Farmer_Code__c, Series__c FROM Farm__c WHERE Client_Farmer__c IN :AccIdPlotmap.keySet() ORDER BY Series__c DESC]) {
            if (!lastFarmMap.containsKey(farm.Farmer_Code__c)) {
                lastFarmMap.put(farm.Farmer_Code__c, farm);
            }
        }
        
        for (Account AccObj : updatedAccounts) {
            if (AccIdPlotmap.get(AccObj.id) != null) {
                Integer lastFarmNumber = 0;
                if (lastFarmMap.containsKey(AccObj.Farmer_Code__c)) {
                    String lastFarmName = lastFarmMap.get(AccObj.Farmer_Code__c).Name;
                    Integer startIndex = lastFarmName.indexOf('F');
                    startIndex = lastFarmName.indexOf('F', startIndex + 1);
                    String numberAfterSecondF = lastFarmName.substring(startIndex);
                    lastFarmNumber = Integer.valueOf(numberAfterSecondF);
                        //Integer.valueOf(lastFarmName.substring(lastFarmName.lastIndexOf('F') + 1));
                }
                  integer NoOfRecord=Integer.valueof(lastFarmNumber + AccIdPlotmap.get(AccObj.id));
                for (Integer i = lastFarmNumber + 1; i <= NoOfRecord; i++) {
                    Farm__c farm = new Farm__c();
                    farm.Name =AccObj.Farmer_Code__c + 'F' + i;
                     farm.Series__c=i;
                    farm.Farmer_Code__c = AccObj.Farmer_Code__c;
                    farm.Client_Farmer__c = AccObj.id;
                    farm.Village__c = AccObj.Village__c;
                    farm.Block__c = AccObj.Block__c;
                    farm.District__c = AccObj.District__c; 
                    farmsToInsert.add(farm);
                }
            }
        }
         if (!farmsToInsert.isEmpty()) {
        insert farmsToInsert;
    }
    }*/
       
  /*  public static void HandleAfterAdressUpdate(List<account>NewAccountList,Map<Id, Account> newAccountsMap, Map<Id, Account> oldAccountsMap)
    {
         Set<Id> accountIds = new Set<Id>();
    for (Account acc : NewAccountList) {
        Account oldAcc = oldAccountsMap.get(acc.Id);
        if (acc.Village__c != oldAcc.Village__c ||
            acc.Block__c != oldAcc.Block__c ||
            acc.District__c != oldAcc.District__c ||
            acc.Phone != oldAcc.Phone) 
        {
            accountIds.add(acc.Id);
        }
    }
    
    // Update related Farm__c records
    List<Farm__c> farmsToUpdate = [SELECT Id ,Client_Farmer__c FROM Farm__c WHERE Client_Farmer__c IN :accountIds];
    for (Farm__c farm : farmsToUpdate) {
        
        farm.Village__c = newAccountsMap.get(farm.Client_Farmer__c).Village__c;
        farm.Block__c = newAccountsMap.get(farm.Client_Farmer__c).Block__c;
        farm.District__c =newAccountsMap.get(farm.Client_Farmer__c).District__c;
        farm.Phone__c =newAccountsMap.get(farm.Client_Farmer__c).Phone;
    }
    update farmsToUpdate;
    
    // Update related Kit_Schedule__c records
    List<Kit_Schedule__c> kitSchedulesToUpdate = [SELECT Id,Farm_Name__c,Client_Farmer__c FROM Kit_Schedule__c WHERE Client_Farmer__c IN :accountIds];
    for (Kit_Schedule__c kitSchedule : kitSchedulesToUpdate) {
        if(kitSchedule.Client_Farmer__c!=null)
        {
            if(newAccountsMap.get(kitSchedule.Client_Farmer__c).Village__c!=null)
            {
                 kitSchedule.Village__c = newAccountsMap.get(kitSchedule.Client_Farmer__c).Village__c;
            }
          kitSchedule.Block__c = newAccountsMap.get(kitSchedule.Client_Farmer__c).Block__c;
          kitSchedule.District__c = newAccountsMap.get(kitSchedule.Client_Farmer__c).District__c;
        }    
    }
    update kitSchedulesToUpdate;
    
    // Update related Field_Visit__c records
    List<Field_Visit__c> fieldVisitsToUpdate = [SELECT Id,Farm_Name__c,Client_Farmer__c FROM Field_Visit__c WHERE Client_Farmer__c IN :accountIds];
    for (Field_Visit__c fieldVisit : fieldVisitsToUpdate) {
        if(Field_Visit__c.Client_Farmer__c!=null)
        fieldVisit.Village__c = newAccountsMap.get(fieldVisit.Client_Farmer__c).Village__c;
        fieldVisit.Block__c = newAccountsMap.get(fieldVisit.Client_Farmer__c).Block__c;
    }
    update fieldVisitsToUpdate;
    }*/
}