trigger GeneralFarmerTrigger on General_Farmer__c (before insert,before update) {
    if(trigger.isbefore && trigger.isinsert)
    {
      GeneralFarmerTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isUpdate) 
    {
        GeneralFarmerTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }

}