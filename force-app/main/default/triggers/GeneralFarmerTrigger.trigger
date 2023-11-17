trigger GeneralFarmerTrigger on General_Farmer__c (before insert,before update) {
    if(trigger.isbefore && trigger.isinsert)
    {
      GeneralFarmerTriggerHandler.handleBeforeInsert(Trigger.new);
        GeneralFarmerTriggerHandler.preventDuplicatePhone(Trigger.new);
      
    }
    if (trigger.isbefore && Trigger.isUpdate) 
    {
       GeneralFarmerTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
      //  GeneralFarmerTriggerHandler.preventDuplicatePhone(Trigger.new);
    }

}