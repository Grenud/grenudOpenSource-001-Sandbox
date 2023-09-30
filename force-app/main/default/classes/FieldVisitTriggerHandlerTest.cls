@isTest
public class FieldVisitTriggerHandlerTest {
    @isTest
    public static void testPopulateFieldVisitName() {
        // Create a mock Farm record
        Account Acc= new account ();
        Acc.Name='Test Account';
        Acc.Farmer_Code__c='FRL001';            
            Insert Acc;
        Farm__c farm = new Farm__c(Name = 'Farm1', Client_Farmer__c=Acc.Id);
        insert farm;

        // Create a Field Visit record
        Field_Visit__c fieldVisit = new Field_Visit__c(Farm_Name__c = farm.Id);
        List<Field_Visit__c> newKitScheduleList = new List<Field_Visit__c>{ fieldVisit };

        // Call the method to test
        FieldVisitTriggerHandler.PopulateFieldVisitName(newKitScheduleList);

        // Perform assertions
        System.assertEquals('Farm1FV1', fieldVisit.Name);
        System.assertEquals(1, fieldVisit.Series__c);
    }

    @isTest
    public static void testUpdateFieldVistFields() {
         Account Acc= new account ();
        Acc.Name='Test Account';
        Acc.Farmer_Code__c='FRL001';
        Acc.Village__c='Manchad';
        Acc.Block__c = 'Khurja';
        Acc.Total_Plot__c=1;
            Insert Acc;
        Farm__c F= [select id, name from Farm__c where Client_Farmer__c =:Acc.Id];
        // Create a mock Farm record
        //Farm__c farm = new Farm__c(Name = 'Farm1', Client_Farmer__c = Acc.Id, Village__c = 'Manchad', Block__c = 'Khurja');
        //insert farm;

        // Create a Field Visit record
        Field_Visit__c fieldVisit = new Field_Visit__c(Farm_Name__c = F.Id, name='1');
        insert fieldVisit;
        Field_Visit__c fieldVisitAfter= [select id, name , Village__c, Block__c,Client_Farmer__c from Field_Visit__c where Farm_Name__c =: F.Id limit 1];
        system.debug(fieldVisitAfter);
        List<Field_Visit__c> fieldVisitList = new List<Field_Visit__c>{ fieldVisit };

        // Call the method to test
        FieldVisitTriggerHandler.updateFieldVistFields(fieldVisitList);

        // Perform assertions
       //System.assertEquals('Test Account', fieldVisitAfter.Client_Farmer__c);
        System.assertEquals('Manchad', fieldVisitAfter.Village__c);
        System.assertEquals('Khurja', fieldVisitAfter.Block__c);
    }
    
    
}