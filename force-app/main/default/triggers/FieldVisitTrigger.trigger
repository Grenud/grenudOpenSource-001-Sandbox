trigger FieldVisitTrigger on Field_Visit__c (before insert)
{
     FieldVisitTriggerHandler.PopulateFieldVisitName(trigger.new);
    FieldVisitTriggerHandler.preventDuplicateFieldVisit(Trigger.new);
    FieldVisitTriggerHandler.updateFieldVistFields(trigger.new);
    
}