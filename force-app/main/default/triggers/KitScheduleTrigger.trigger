trigger KitScheduleTrigger on Kit_Schedule__c (before insert)
{    
 KitScheduleHandler.updateKitScheduleFields(trigger.new);
 KitScheduleHandler.PopulateKitScheduleName(trigger.new);
 KitScheduleHandler.PreventDuplicateKitSchedule(trigger.new);
}