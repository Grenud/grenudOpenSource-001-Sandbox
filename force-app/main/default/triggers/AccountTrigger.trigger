trigger AccountTrigger on Account (after insert, after update) {
    if(trigger.isAfter && trigger.IsInsert)
    {
        AccountTriggerHandler.createContact(trigger.new);
        AccountTriggerHandler.handleAfterInsert(Trigger.new);
    }
    
    if(trigger.isAfter && trigger.IsUpdate)
    {
       AccountTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
       //AccountTriggerHandler.HandleAfterAdressUpdate(Trigger.new,trigger.newMap,Trigger.oldMap);
    }  
}