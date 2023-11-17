@isTest
public class GeneralFarmerTriggerHandlerTest {
    @isTest
    static void testHandleBeforeInsert() {
        // Create test data for insert
        List<General_Farmer__c> newFarmers = new List<General_Farmer__c>();
        for (Integer i = 1; i <= 5; i++) {
            General_Farmer__c newFarmer = new General_Farmer__c(
                Name='Sonu3',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father',Aadhar_Card_Number__c='123456789123', Phone__c='9876543892', Village__c='Jhajhr' + i
            );
            newFarmers.add(newFarmer);
        }

        Test.startTest();
        GeneralFarmerTriggerHandler.handleBeforeInsert(newFarmers);
        Test.stopTest();

        // Verify that series numbers and names are set correctly
        for (Integer i = 0; i < newFarmers.size(); i++) {
            System.assertEquals('SONU3', newFarmers[i].Farmer_Name__c);
            System.assertEquals(i + 1, newFarmers[i].Series__c);
            
        }
    }

    @isTest
    static void testHandleBeforeUpdate() {
        // Create test data for update
        General_Farmer__c existingFarmer = new General_Farmer__c(Name='Sonu3',Aadhar_Card_Number__c='123456789123',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father', Phone__c='9876543892', Village__c='Jhajhr',
     Series__c = 10);
        insert existingFarmer;

        General_Farmer__c updatedFarmer = new General_Farmer__c(
            Id = existingFarmer.Id,
            Name='Sonu3',Farmer_Name__c='updatedFarmer', Aadhar_Card_Number__c='123456789123', Father_Name__c='Sonu Father', Phone__c='9876543892', Village__c='Jhajhr',Series__c = 1
        );

        Test.startTest();
        update updatedFarmer; // This will trigger the update event
        Test.stopTest();

        // Verify that the Name field is updated correctly, and Series__c remains unchanged
        General_Farmer__c updatedRecord = [SELECT Farmer_Name__c, Series__c, Name FROM General_Farmer__c WHERE Id = :existingFarmer.Id];
        System.assertEquals('updatedFarmer', updatedRecord.Farmer_Name__c);
        System.assertEquals(1, updatedRecord.Series__c);
        System.assertEquals('GFN-23-updatedFarmer-1', updatedRecord.Name);
    }
}