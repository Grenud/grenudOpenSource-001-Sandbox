trigger FieldVisitTrigger on Field_Visit__c (before insert)
{
     FieldVisitTriggerHandler.PopulateFieldVisitName(trigger.new);
     FieldVisitTriggerHandler.updateFieldVistFields(trigger.new);
}