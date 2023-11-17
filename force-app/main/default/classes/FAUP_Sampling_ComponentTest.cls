@isTest
public class FAUP_Sampling_ComponentTest {

    @isTest
    static void testGetClientFarmerList() {
        // Create test data
        Account testClientFarmer1 = new Account(Name = 'Test Farmer 1', Village__c = 'TestVillage1');
        Account testClientFarmer2 = new Account(Name = 'Test Farmer 2', Village__c = 'TestVillage2');
        Account testClientFarmer3 = new Account(Name = 'Test Farmer 3', Village__c = 'TestVillage1');
        insert new List<Account>{testClientFarmer1, testClientFarmer2, testClientFarmer3};

        Farm__c testFarm1 = new Farm__c(Client_Farmer__c = testClientFarmer1.Id, UP_Sample_Collect__c = false);
        Farm__c testFarm2 = new Farm__c(Client_Farmer__c = testClientFarmer2.Id, UP_Sample_Collect__c = true);
        insert new List<Farm__c>{testFarm1, testFarm2}; 

        // Call the method to be tested
        List<Account> result = FAUP_Sampling_Component.getClientFarmerList('TestVillage1');

        // Perform assertions to validate the results
      //  System.assertEquals(2, result.size(), 'Expected 2 client farmers in TestVillage1');
//        for (Account clientFarmer : result) {
         //   System.assertNotEquals(true, clientFarmer.Suspect__c, 'Client farmer should not be a suspect');
        //}
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////

   @isTest
    static void testGetFarmList() {
        // Create test data
       
        Account testClientFarmer = new Account(Name = 'Test Client Farmer');
        insert testClientFarmer;

        Farm__c testFarm1 = new Farm__c(Name = 'Farm 1', Client_Farmer__c = testClientFarmer.Id, UP_Sample_Collect__c = false);
        Farm__c testFarm2 = new Farm__c(Name = 'Farm 2', Client_Farmer__c = testClientFarmer.Id, UP_Sample_Collect__c = true);
        Farm__c testFarm3 = new Farm__c(Name = 'Farm 3', Client_Farmer__c = testClientFarmer.Id, UP_Sample_Collect__c = false);
        insert new List<Farm__c>{testFarm1, testFarm2, testFarm3};

        // Call the method to be tested
        List<Farm__c> result = FAUP_Sampling_Component.getFarmList(testClientFarmer.Id);

        // Perform assertions to validate the results
        System.assertEquals(2, result.size(), 'Expected 2 farms for the client farmer');
        for (Farm__c farm : result) {
            System.assertNotEquals(true, farm.UP_Sample_Collect__c, 'Farm should not have UP Sample Collect as true');
            System.assertEquals(testClientFarmer.Id, farm.Client_Farmer__c, 'Farm should belong to the client farmer');
        }
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @isTest
    public static void testCreateClientFrmSamples() {
        // Test data setup
        FAUP_LOT__c testLot = new FAUP_LOT__c(UP_Status__c = null);
        insert testLot;
        
        Account testClientFarmer = new Account(Name = 'Test Client Farmer');
        insert testClientFarmer;

        Farm__c testFarm = new Farm__c(Name = 'Test Farm', UP_Sample_Collect__c = false, Client_Farmer__c = testClientFarmer.Id);
        insert testFarm;


        // Call the method to be tested
        List<FAUP_Sample__c> result = FAUP_Sampling_Component.createClientFrmSamples(new List<Account>{testClientFarmer}, testLot.Id);

        // Assert the results
        System.assertEquals(1, result.size(), 'Expected one FAUP_Sample__c record to be created');
        FAUP_Sample__c createdSample = result[0];
        System.assertEquals(testLot.Id, createdSample.UP_LOT__c, 'UP_LOT__c should match the test Lot Id');
        System.assertEquals(testClientFarmer.Id, createdSample.Client_Farmer__c, 'Client_Farmer__c should match the test Client Farmer Id');
        System.assertEquals(1, createdSample.No_Of_Farms__c, 'No_Of_Farms__c should be 1');
        System.assertEquals(testFarm.Name, createdSample.Farms__c, 'Farms__c should match the test Farm name');
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@isTest
    static void testUpdateClientFarmerAllFarms() {
        // Create test data
        Account testClientFarmer = new Account(Name = 'Test Client Farmer');
        insert testClientFarmer;

        FAUP_LOT__c testLot = new FAUP_LOT__c(UP_Status__c = null);
        insert testLot;

        FAUP_Sample__c testSample = new FAUP_Sample__c(Client_Farmer__c = testClientFarmer.Id);
        insert testSample;

        Farm__c testFarm1 = new Farm__c(Client_Farmer__c = testClientFarmer.Id, UP_Sample_Collect__c = false);
        Farm__c testFarm2 = new Farm__c(Client_Farmer__c = testClientFarmer.Id, UP_Sample_Collect__c = false);
        insert new List<Farm__c>{testFarm1, testFarm2};

        List<Account> selectedClientFarmers = new List<Account>{testClientFarmer};
        List<FAUP_Sample__c> sampleRecords = new List<FAUP_Sample__c>{testSample};
        
// Call the method to be tested
        FAUP_Sampling_Component.updateClientFarmerAllFarms(selectedClientFarmers, testLot.Id, sampleRecords);

        // Query the farms to validate the updates
        List<Farm__c> updatedFarms = [SELECT Id, UP_Sample__c, UP_Sample_Collected_Date__c, UP_Sample_Collect__c, FAUP_LOT_Name__c
                                     FROM Farm__c WHERE Id IN :new Set<Id>{testFarm1.Id, testFarm2.Id}];

        System.assertEquals(2, updatedFarms.size(), 'Expected 2 farms to be updated');
        for (Farm__c farm : updatedFarms) {
            System.assertEquals(testSample.Id, farm.UP_Sample__c, 'Farm should have the updated sample ID');
            System.assertEquals(true, farm.UP_Sample_Collect__c, 'Farm should have UP Sample Collect as true');
            System.assertNotEquals(null, farm.FAUP_LOT_Name__c, 'Farm should have a non-null Lot Name');
        }
    }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
    @isTest
    static void testCreateSampleRecords() {
        // Create test data for Lot
        FAUP_LOT__c testLot = new FAUP_LOT__c();
        insert testLot;

        // Create test data for Client Farmer
        Account testClientFarmer = new Account(Name = 'Test Client Farmer', Village__c = 'Sample Village');
        insert testClientFarmer;

        // Create test data for Farm
        Farm__c testFarm = new Farm__c(Name = 'Test Farm', UP_Sample_Collect__c = false, Client_Farmer__c = testClientFarmer.Id);
        insert testFarm;

        Test.startTest();

        // Call the createSampleRecords method
        List<Farm__c> selectedFarms = [SELECT Id,Client_Farmer__c,Name FROM Farm__c WHERE Client_Farmer__c = :testClientFarmer.Id AND UP_Sample_Collect__c = false];
        ID sampleId = FAUP_Sampling_Component.createSampleRecords(selectedFarms, testLot.Id);

        Test.stopTest();

        // Verify that a sample record was created
        System.assertEquals(1, [SELECT count() FROM FAUP_Sample__c WHERE Id = :sampleId]);
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

   @isTest
    public static void testUpdateSelectedFarms() {        
        
         // Create test data for Client Farmer
        Account testClientFarmer = new Account(Name = 'Test Client Farmer', Village__c = 'Sample Village');
        insert testClientFarmer;
        
        List<Farm__c> testFarms = new List<Farm__c>();
        for (Integer i = 0; i < 3; i++) {
            testFarms.add(new Farm__c(
                Name = 'Test Farm ' + i,
                UP_Sample_Collect__c = false,
                Client_Farmer__c = testClientFarmer.Id
            ));
        }
        insert testFarms;

        FAUP_LOT__c testLot = new FAUP_LOT__c();
        insert testLot;
        
        FAUP_Sample__c testSample = new FAUP_Sample__c(Client_Farmer__c = testClientFarmer.Id);
        insert testSample;


        // Call the method to be tested
        FAUP_Sampling_Component.updateSelectedFarms(testFarms, testLot.Id, testSample.Id);

        // Verify the updated Farms
        List<Farm__c> updatedFarms = [SELECT UP_Sample__c, UP_Sample_Collected_Date__c, UP_Sample_Collect__c, FAUP_LOT_Name__c FROM Farm__c WHERE Id IN :testFarms];
        
        for (Farm__c farm : updatedFarms) {
            System.assertEquals(testSample.Id, farm.UP_Sample__c, 'UP_Sample__c should be updated');
            System.assertNotEquals(null, farm.UP_Sample_Collected_Date__c, 'UP_Sample_Collected_Date__c should be updated');
            System.assertEquals(true, farm.UP_Sample_Collect__c, 'UP_Sample_Collect__c should be true');
           // System.assertEquals(null, farm.FAUP_LOT_Name__c, 'FAUP_LOT_Name__c should be null');
        }
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}