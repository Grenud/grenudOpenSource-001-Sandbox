@isTest
public class GeneralFarmerTriggerHandlerTest {
    @isTest
    static void testHandleBeforeInsert() {
        // Create test data for insert
        List<General_Farmer__c> newFarmers = new List<General_Farmer__c>();
        for (Integer i = 1; i <= 5; i++) {
            General_Farmer__c newFarmer = new General_Farmer__c(
                Name='Sonu3',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb' + i
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
        General_Farmer__c existingFarmer = new General_Farmer__c(Name='Sonu3',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb', Series__c = 10);
        insert existingFarmer;

        General_Farmer__c updatedFarmer = new General_Farmer__c(
            Id = existingFarmer.Id,
            Name='Sonu3',Farmer_Name__c='updatedFarmer', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb',
            Series__c = 1
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


/*@isTest
public class GeneralFarmerTriggerHandlerTest {
    @isTest
    static void testGenerateGeneralFarmerNames() {
        // Create test data
        List<General_Farmer__c> newFarmers = new List<General_Farmer__c>();

        // Create existing farmer records
        General_Farmer__c existingFarmer1 = new General_Farmer__c(Name='Sonu3',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb');
        General_Farmer__c existingFarmer2 = new General_Farmer__c(Name='Sonu4',Farmer_Name__c='SONU3', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb');

        insert new List<General_Farmer__c> { existingFarmer1, existingFarmer2 };

        // Create new farmer records
        General_Farmer__c generalFarmer = new General_Farmer__c(Name='Sonu',Farmer_Name__c='SONU', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb');
        General_Farmer__c newFarmer2 = new General_Farmer__c(Name='Sonu1',Farmer_Name__c='SONU1', Father_Name__c='Sonu Father', Phone__c='9876543', Village__c='Jhajhr',
    Block__c='Jewar', District__c='Gb');
        

        // Add new farmer records to the list
        newFarmers.add(generalFarmer);
        newFarmers.add(newFarmer2);

        // Test start
        Test.startTest();

        // Call the method to be tested
        GeneralFarmerTriggerHandler.GenerateGeneralFarmerNames(newFarmers);

        // Test end

        // Verify the results
        System.assertEquals(1, generalFarmer.Series__c);
        System.assertEquals('GFN-23-SONU-1', generalFarmer.Name);

        System.assertEquals(1, newFarmer2.Series__c);
        System.assertEquals('GFN-23-SONU1-1', newFarmer2.Name);
    }
}*/