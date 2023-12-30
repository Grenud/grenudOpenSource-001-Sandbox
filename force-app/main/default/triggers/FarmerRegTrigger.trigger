trigger FarmerRegTrigger on Farmer_Registration__c (after insert,after update) {
    if(trigger.isafter && trigger.isinsert)
    {
        FarmerRegTriggerHandler.createAccount(trigger.new);
    }
    
    if(trigger.isafter && trigger.isupdate)
    {
        FarmerRegTriggerHandler.createAccount(trigger.new);
    }
}