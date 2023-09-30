trigger SaleInvoiceTrigger on Sale_Invoice__c (before insert, after insert, after update, after undelete, after delete)
{
    if(trigger.isBefore && trigger.isInsert)
    {
        SaleInvoiceTriggerHandler.PopulateFarmerCodes(trigger.new);
        SaleInvoiceTriggerHandler.PreventDuplicateInvoiveNumber(trigger.new);
    }
    
    if(trigger.IsAfter && trigger.isInsert)
    {
        SaleInvoiceTriggerHandler.PopulatePartySaleInvoice(trigger.new);
        SaleInvoiceTriggerHandler.updateTotalInvRollupsum(trigger.new);
       
    }
    if(trigger.isAfter && trigger.IsUpdate){
        SaleInvoiceTriggerHandler.UpdateReparentTotalInvRollUpSum(trigger.old, trigger.new, trigger.oldmap);
      //  SaleInvoiceTriggerHandler.createFarmerCreditupdatecashtocheque( trigger.new, trigger.oldmap);
    }
    if(trigger.isAfter && (Trigger.isUndelete)){
        SaleInvoiceTriggerHandler.updateTotalInvRollupsum(trigger.new);
    }
    if (trigger.isAfter && Trigger.isDelete) {
        SaleInvoiceTriggerHandler.updateTotalInvRollupsum(trigger.old);
    }
}