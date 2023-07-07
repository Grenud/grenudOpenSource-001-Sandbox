public class AccountTriggerHandler {
    public static void handleAfterInsert(List<Account> newAccounts)
    {
         List<Farm__c> farmsToInsert = new List<Farm__c>();
        map<Id, decimal>AccIdPlotmap=new map<Id, decimal>();
        for(Account AccObj:newAccounts){
            if(AccObj.Total_Plot__c!=null){
            AccIdPlotmap.put(AccObj.id, AccObj.Total_Plot__c);
        }}
        for(Account AccObj:newAccounts){
            if(AccIdPlotmap.get(AccObj.id)!=null){
                for(Integer i=1; i<AccIdPlotmap.get(AccObj.id)+1; i++){
                   Farm__c farm = new Farm__c();
                farm.Name = AccObj.Farmer_Code__c +'F'+i;
                farm.Farmer_Code__c = AccObj.Farmer_Code__c;
                farm.Father_Name__c=AccObj.Father_Name__c;  
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
    }
    
    public static void handleAfterUpdate(List<Account> updatedAccounts, Map<Id, Account> oldAccountsMap)
    {
        List<Farm__c> farmsToInsert = new List<Farm__c>();
        map<Id, decimal>AccIdPlotmap=new map<Id, decimal>(); 
        map<Id,Integer>AccIdFarmLasNoMap=new map<id, integer>();
        for(Account AccObj:updatedAccounts){
            if(AccObj.Total_Plot__c!=null && oldAccountsMap.get(AccObj.id).Total_Plot__c!=null && AccObj.Total_Plot__c> oldAccountsMap.get(AccObj.id).Total_Plot__c ){
           decimal difference=AccObj.Total_Plot__c-oldAccountsMap.get(AccObj.id).Total_Plot__c;
                AccIdPlotmap.put(AccObj.id, difference);
        }
            if(AccObj.Total_Plot__c!=null && oldAccountsMap.get(AccObj.id).Total_Plot__c==null ){
               AccIdPlotmap.put(AccObj.id, AccObj.Total_Plot__c); 
            }
        }
    
         Map<String, Farm__c> lastFarmMap = new Map<String, Farm__c>();
        for (Farm__c farm : [SELECT Name, Farmer_Code__c FROM Farm__c WHERE Client_Farmer__c IN :AccIdPlotmap.keySet() ORDER BY Name DESC]) {
            if (!lastFarmMap.containsKey(farm.Farmer_Code__c)) {
                lastFarmMap.put(farm.Farmer_Code__c, farm);
            }
        }
        
        for (Account AccObj : updatedAccounts) {
            if (AccIdPlotmap.get(AccObj.id) != null) {
                Integer lastFarmNumber = 0;
                if (lastFarmMap.containsKey(AccObj.Farmer_Code__c)) {
                    String lastFarmName = lastFarmMap.get(AccObj.Farmer_Code__c).Name;
                    lastFarmNumber = Integer.valueOf(lastFarmName.substring(lastFarmName.lastIndexOf('F') + 1));
                }
                
                for (Integer i = lastFarmNumber + 1; i <= lastFarmNumber + AccIdPlotmap.get(AccObj.id); i++) {
                    Farm__c farm = new Farm__c();
                    farm.Name =AccObj.Farmer_Code__c + 'F' + i;
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
    }
       
}