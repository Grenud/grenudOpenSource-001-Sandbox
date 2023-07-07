trigger FarmTrigger on Farm__c (before insert,after insert,after update,after delete,after undelete) 
{
     if (Trigger.isBefore && Trigger.isInsert) 
     {
       FarmTriggerHandler.handleBeforeInsert(Trigger.new);
     }

    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete)) {
        FarmTriggerHandler.handleAfterInsert(Trigger.new);
    }
    
    if (Trigger.isAfter && Trigger.isDelete) {
        FarmTriggerHandler.handleAfterDelete(Trigger.old);
    }
}