trigger PaymentTrgger on Payment__c (after insert, after update, after delete, after undelete) {
     if (Trigger.isAfter && Trigger.isInsert) {
            PaymentTriggerHandler.updateCashCreditAmountRollup(trigger.new);
            
        }
        
        if (Trigger.isAfter && Trigger.isUpdate) {
            PaymentTriggerHandler.updateReparentCashCreditAmountRollup(trigger.old, trigger.new, trigger.oldmap);
           
        }
        
        if (Trigger.isAfter && Trigger.isDelete) {
            PaymentTriggerHandler.updateCashCreditAmountRollup(trigger.new);
        }
        
        if (Trigger.isAfter && Trigger.isUndelete) {
            PaymentTriggerHandler.updateCashCreditAmountRollup(trigger.new);
        }
}