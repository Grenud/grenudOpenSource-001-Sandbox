trigger AccountTrigger on Account (after insert, after update) {
    if(trigger.isAfter && trigger.IsInsert){
        List<Farm__c> farmsToInsert = new List<Farm__c>();
        map<Id, decimal>AccIdPlotmap=new map<Id, decimal>();
        for(Account AccObj:Trigger.new){
            if(AccObj.Total_Plot__c!=null){
            AccIdPlotmap.put(AccObj.id, AccObj.Total_Plot__c);
        }}
        for(Account AccObj:Trigger.new){
            if(AccIdPlotmap.get(AccObj.id)!=null){
                for(Integer i=1; i<AccIdPlotmap.get(AccObj.id)+1; i++){
                   Farm__c farm = new Farm__c();
                farm.Name = AccObj.Farmer_Code__c +'F'+i;
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
    if(trigger.isAfter && trigger.IsUpdate){
       List<Farm__c> farmsToInsert = new List<Farm__c>();
        map<Id, decimal>AccIdPlotmap=new map<Id, decimal>(); 
        map<Id,Integer>AccIdFarmLasNoMap=new map<id, integer>();
        for(Account AccObj:Trigger.new){
            if(AccObj.Total_Plot__c!=null && trigger.oldmap.get(AccObj.id).Total_Plot__c!=null && AccObj.Total_Plot__c> trigger.oldmap.get(AccObj.id).Total_Plot__c ){
           decimal difference=AccObj.Total_Plot__c-trigger.oldmap.get(AccObj.id).Total_Plot__c;
                AccIdPlotmap.put(AccObj.id, difference);
        }
            if(AccObj.Total_Plot__c!=null && trigger.oldmap.get(AccObj.id).Total_Plot__c==null ){
               AccIdPlotmap.put(AccObj.id, AccObj.Total_Plot__c); 
            }
        }
     /*   List<Farm__c> existingFarms = [SELECT Name,Client_Farmer__c FROM Farm__c WHERE Client_Farmer__c In :AccIdPlotmap.keyset() ORDER BY Name DESC LIMIT 1];
        if(existingFarms.size()>0){
            for(Farm__c FarmObj:existingFarms){
                if(FarmObj.Client_Farmer__c!=null){
                   integer lastFarmNumber = Integer.valueOf(lastFarmName.substring(lastFarmName.lastIndexOf('F') + 1));
                    AccIdFarmLasNoMap.put(FarmObj.Client_Farmer__c,)
                }
            }
        }  
        for(Account AccObj:Trigger.new){
            if(AccIdPlotmap.get(AccObj.id)!=null){
                for(Integer i=1; i<AccIdPlotmap.get(AccObj.id)+1; i++){
                   Farm__c farm = new Farm__c();
                farm.Name = AccObj.Farmer_Code__c +'F'+i;
                farm.Farmer_Code__c = AccObj.Farmer_Code__c;
                farm.Client_Farmer__c = AccObj.Name;
                farm.Village__c = AccObj.Village__c;
                farm.Block__c = AccObj.Block__c;
                farm.District__c = AccObj.District__c; 
                    farmsToInsert.add(farm);
                }
            }
        }*/
         Map<String, Farm__c> lastFarmMap = new Map<String, Farm__c>();
        for (Farm__c farm : [SELECT Name, Farmer_Code__c FROM Farm__c WHERE Client_Farmer__c IN :AccIdPlotmap.keySet() ORDER BY Name DESC]) {
            if (!lastFarmMap.containsKey(farm.Farmer_Code__c)) {
                lastFarmMap.put(farm.Farmer_Code__c, farm);
            }
        }
        
        for (Account AccObj : Trigger.new) {
            if (AccIdPlotmap.get(AccObj.id) != null) {
                Integer lastFarmNumber = 0;
                if (lastFarmMap.containsKey(AccObj.Farmer_Code__c)) {
                    String lastFarmName = lastFarmMap.get(AccObj.Farmer_Code__c).Name;
                    lastFarmNumber = Integer.valueOf(lastFarmName.substring(lastFarmName.lastIndexOf('F') + 1));
                }
                
                for (Integer i = lastFarmNumber + 1; i <= lastFarmNumber + AccIdPlotmap.get(AccObj.id); i++) {
                    Farm__c farm = new Farm__c();
                    farm.Name = AccObj.Farmer_Code__c + 'F' + i;
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
    
  /*  Set<String> farmerCodes = new Set<String>();
    List<Farm__c> farmsToInsert = new List<Farm__c>();

    // Collect unique farmer codes from the updated Account records
    for (Account acc : Trigger.new) {
        farmerCodes.add(acc.Farmer_Code__c);
    }

    // Query existing farms with the same farmer codes
    Map<String, Farm__c> existingFarms = new Map<String, Farm__c>();
    for (Farm__c farm : [SELECT Id, Farmer_Code__c FROM Farm__c WHERE Farmer_Code__c IN :farmerCodes]) {
        existingFarms.put(farm.Farmer_Code__c, farm);
    }

    // Create Farm records for new farmer codes
    for (Account acc : Trigger.new) {
        if (!existingFarms.containsKey(acc.Farmer_Code__c)) {
            Integer totalPlots = acc.Total_Plot__c != null ? acc.Total_Plot__c.intValue() : 0;
            for (Integer i = 0; i < totalPlots; i++) {
                Farm__c farm = new Farm__c();
                farm.Name = acc.Name;
                farm.Farmer_Code__c = acc.Farmer_Code__c;
                farm.Client_Farmer__c = acc.Name;
                farm.Village__c = acc.Village__c;
                farm.Block__c = acc.Block__c;
                farm.District__c = acc.District__c;
                farmsToInsert.add(farm);
            }
        }
    }

    // Insert the new Farm records
    if (!farmsToInsert.isEmpty()) {
        insert farmsToInsert;
    } */
}