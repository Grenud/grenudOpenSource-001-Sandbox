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
}