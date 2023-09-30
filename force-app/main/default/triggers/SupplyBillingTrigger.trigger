trigger SupplyBillingTrigger on Supply_Billing__c (before insert,before update) {

    if(trigger.isbefore && trigger.isinsert)
    {
        SupplyBillingTriggerHandler.handleBeforeInsertInvoice(trigger.new);
        SupplyBillingTriggerHandler.handleBeforeInsertShipTo(trigger.new);
        SupplyBillingTriggerHandler.convertToWord( trigger.new);
    }
    if(trigger.isbefore && trigger.isupdate)
    {
        SupplyBillingTriggerHandler.handleBeforeUpdateInvoice(trigger.new,Trigger.oldMap);
        SupplyBillingTriggerHandler.handleBeforeUpdateShipTo(trigger.new,Trigger.oldMap);
        SupplyBillingTriggerHandler.convertToWord( trigger.new);
    }
}