trigger ProductItemTrigger on Product_Item__c (before insert) {
    
 if(trigger.isbefore && trigger.isinsert)
 {
     system.debug('beforeTrigger executed');
     ProductItemTriggerHandler.ProductItemInsert(trigger.new);
     
 }
}