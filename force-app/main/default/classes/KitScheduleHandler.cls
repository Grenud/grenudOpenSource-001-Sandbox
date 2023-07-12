public class KitScheduleHandler {
    public static void updateKitScheduleFields(List<Kit_Schedule__c> KitScheduleList)
    {
        Set<Id> farmIds = new Set<Id>();
        for (Kit_Schedule__c KSObj : KitScheduleList) 
        {
            if (KSObj.Farm_Name__c != null)
            {
                farmIds.add(KSObj.Farm_Name__c);
            }
        }            
        if (!farmIds.isEmpty())
        {
            Map<Id, Farm__c> farmsMap = new Map<Id, Farm__c>([SELECT Id, Client_Farmer__c,Father_Name__c, Village__c, Block__c,District__c FROM Farm__c WHERE Id IN :farmIds]);
            for (Kit_Schedule__c KSObj : KitScheduleList) 
            {
                if (KSObj.Farm_Name__c != null) 
                {
                    Farm__c farm = farmsMap.get(KSObj.Farm_Name__c);
                    if (farm != null) 
                    {
                        KSObj.Client_Farmer__c = farm.Client_Farmer__c;
                        KSObj.Father_Name__c=farm.Father_Name__c;
                        KSObj.Village__c = farm.Village__c;
                        KSObj.Block__c = farm.Block__c;
                        KSobj.District__c=farm.Block__c;
                     }
                }
            }
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////
    //Prevent Create Duplicate Kit Schedule
    public static void PreventDuplicateKitSchedule(List<Kit_Schedule__c> KitScheduleList)
    {
        Set<Id> farmIds = new Set<Id>();
        for (Kit_Schedule__c KSObj : KitScheduleList) 
        {
            if (KSObj.Farm_Name__c != null)
            {
                farmIds.add(KSObj.Farm_Name__c);
            }
        }    
         List<Kit_Schedule__c> existingKitSchedules = [SELECT Id, Farm_Name__c FROM Kit_Schedule__c WHERE Farm_Name__c IN :farmIds];
            Map<Id, Boolean> hasExistingKitScheduleMap = new Map<Id, Boolean>();
            for (Kit_Schedule__c existingKitSchedule : existingKitSchedules) 
            {
             hasExistingKitScheduleMap.put(existingKitSchedule.Farm_Name__c, true);
               for (Kit_Schedule__c newKitSchedule : KitScheduleList) 
               {
                if (hasExistingKitScheduleMap.containsKey(newKitSchedule.Farm_Name__c)) 
                {
                 newKitSchedule.addError('Cannot create duplicate Kit Schedule for the Farm');
                }
              }
             }
    }
    public static void PopulateKitScheduleName(List<Kit_Schedule__c> NewKitScheduleList)
    {
        Set<ID>FarmName=new set<ID>();
        for (Kit_Schedule__c KSObj : NewKitScheduleList) 
        {
            if (KSObj.Farm_Name__c != null)
            {
                FarmName.add(KSObj.Farm_Name__c);
            }
        }   
        Map<Id,Farm__c>FarmMap= new Map<Id,Farm__c>([Select Id,Name from Farm__c where ID IN : FarmName]);
        system.debug(FarmMap);
        list<Kit_Schedule__c>LastKitSchedule=[select Id,Name,Series__c from Kit_Schedule__c where Farm_Name__c IN : FarmName Order BY series__c DESC LIMIT 1 ];
        if(LastKitSchedule.size()==0)
        {
             for(Kit_Schedule__c KSObj : NewKitScheduleList){
                 
                if(KSObj.Farm_Name__c != null)
                {
                     {
                         Farm__c farm = farmMap.get(KSObj.Farm_Name__c);
                         KSObj.Series__c=1;//integer.valueof(NewKitScheduleList.indexof(KSObj));
                         system.debug(KSObj.Series__c);
                         KSObj.Name = farm.Name +''+'KS'+1;
                     }
                }
             }
        }      
        else
        {
           for(Kit_Schedule__c KSObj : NewKitScheduleList){
                 
                if(KSObj.Farm_Name__c != null)
                {
                     {
                         Farm__c farm = farmMap.get(KSObj.Farm_Name__c);
                         KSObj.Series__c=LastKitSchedule[0].series__c+1;
                         KSObj.Name = farm.Name +'' + 'KS'+  string.valueof(KSObj.Series__c);    //LastKitSchedule[0].series__c;
                     }
                }
             } 
        }
    }
}