@IsTest
public class KitScheduleHandlerTest {
   @IsTest
    static void testUpdateFieldActivityFields() {
        // Create test Client Farmer record
        Account testClientFarmer = new Account();
        testClientFarmer.Name = 'Test Client Farmer';
        testClientFarmer.Farmer_Code__c = 'FC001'; // Assign a value to the mandatory field
        // Set other required fields on Client Farmer record
        // ...

        insert testClientFarmer;

        // Create test Farm record
        Farm__c testFarm = new Farm__c();
        testFarm.Name = 'Test Farm';
        testFarm.Client_Farmer__c = testClientFarmer.Id;
        // Set other required fields on Farm record
        // ...

        insert testFarm;

        // Create test Field Activity records
        List<Kit_Schedule__c> testFieldActivities = new List<Kit_Schedule__c>();
        for (Integer i = 0; i < 5; i++) {
            Kit_Schedule__c fieldActivity = new Kit_Schedule__c();
            fieldActivity.Farm_Name__c = testFarm.Id;
            // Set other required fields on Field Activity record
            // ...
            testFieldActivities.add(fieldActivity);
        }

        insert testFieldActivities;

        // Verify that the Client Farmer, Village, and Block fields are populated correctly
        List<Kit_Schedule__c> updatedFieldActivities = [SELECT Id, Client_Farmer__c, Village__c, Block__c, Name
                                                          FROM Kit_Schedule__c
                                                          WHERE Id IN :testFieldActivities];

        for (Kit_Schedule__c fieldActivity : updatedFieldActivities) {
            System.assertEquals(testClientFarmer.Id, fieldActivity.Client_Farmer__c);
            System.assertEquals(testFarm.Village__c, fieldActivity.Village__c);
            System.assertEquals(testFarm.Block__c, fieldActivity.Block__c);

            // Verify that the Name field is not null or empty
            System.assertNotEquals(null, fieldActivity.Name);
            System.assertNotEquals('', fieldActivity.Name);
        }
    }  
    
    @IsTest
    public static void testPreventDuplicateKitSchedule() {
         Account Acc= new account ();
        Acc.Name='Test Account';
        Acc.Farmer_Code__c='FRL001';            
            Insert Acc;
        // Create test data
        Farm__c farm = new Farm__c(Name = 'Farm1',Client_Farmer__c=Acc.Id);
        insert farm;

        Kit_Schedule__c existingKitSchedule = new Kit_Schedule__c(Farm_Name__c = farm.Id);
        insert existingKitSchedule;

        Kit_Schedule__c newKitSchedule = new Kit_Schedule__c(Farm_Name__c = farm.Id);

        // Call the method to be tested
        Test.startTest();
        KitScheduleHandler.PreventDuplicateKitSchedule(new List<Kit_Schedule__c>{ newKitSchedule });
        Test.stopTest();

        // Verify error message
        List<ApexPages.Message> messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size(), 'An error should have occurred');
        System.assertEquals('Cannot create duplicate Kit Schedule for the Farm', messages[0].getDetail());
    }
}