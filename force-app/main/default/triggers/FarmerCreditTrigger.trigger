trigger FarmerCreditTrigger on Farmer_Credit__c (after insert, after update, after delete, after undelete) {
    if(trigger.isAfter && trigger.IsUpdate){
       FarmerCreditTriggerHandler.UpdateReparentCreditRollUpSum(trigger.old, trigger.new, trigger.oldmap);
    }
    if(trigger.isAfter && (trigger.IsInsert ||Trigger.isUndelete)){
        FarmerCreditTriggerHandler.updateCreditRollupsum(trigger.new);
    }
    if (trigger.isAfter && Trigger.isDelete) {
        FarmerCreditTriggerHandler.updateCreditRollupsum(trigger.old);
    }
}