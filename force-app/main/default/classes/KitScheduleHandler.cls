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
        
        if (!farmIds.isEmpty())
        {
            Map<Id, Farm__c> farmsMap = new Map<Id, Farm__c>([SELECT Id, Client_Farmer__c, Village__c, Block__c FROM Farm__c WHERE Id IN :farmIds]);
            for (Kit_Schedule__c KSObj : KitScheduleList) 
            {
                if (KSObj.Farm_Name__c != null) 
                {
                    Farm__c farm = farmsMap.get(KSObj.Farm_Name__c);
                    if (farm != null) 
                    {
                        KSObj.Client_Farmer__c = farm.Client_Farmer__c;
                        KSObj.Village__c = farm.Village__c;
                        KSObj.Block__c = farm.Block__c;
                     }
                }
            }
        }
    }
}