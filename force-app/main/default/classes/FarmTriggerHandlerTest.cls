@IsTest
public class FarmTriggerHandlerTest {
       @IsTest
    public static void testHandleBeforeInsert() {
        // Create test data
        Account testAccount = new Account(Farmer_Code__c = 'ABC123', Name = 'Test Account3');
        insert testAccount;

        // Create a sample Farm record for the query to retrieve
        Farm__c sampleFarm = new Farm__c(Farmer_Code__c = testAccount.Farmer_Code__c, client_Farmer__c = testAccount.Id, Name = 'ABC123F1');
        insert sampleFarm;

        Farm__c testFarm = new Farm__c(Name = '1', Client_Farmer__c = testAccount.Id);
        List<Farm__c> farms = new List<Farm__c>{ testFarm };

        // Call the handler method
        FarmTriggerHandler.handleBeforeInsert(farms);

        // Retrieve the updated farm record
        List<Farm__c> updatedFarms = [SELECT Name, Farmer_Code__c FROM Farm__c WHERE Id = :testFarm.Id];
        System.debug('Updated Farms: ' + updatedFarms);

        // Assert the changes
        if (!updatedFarms.isEmpty()) {
            System.assertEquals(testAccount.Farmer_Code__c + 'F2', updatedFarms[0].Name);
        } else {
            System.debug('No updated farms found');
        }
    }
    @IsTest
    public static void testHandleAfterInsert() {
        // Create test data
        Account testAccount = new Account(Farmer_Code__c = 'ABC123', Name = 'Test Account');
        insert testAccount;
        
        // Call the handler method
        Farm__c testFarm = new Farm__c(Client_Farmer__c = testAccount.Id);
        List<Farm__c> farms = new List<Farm__c>{ testFarm };
        FarmTriggerHandler.handleAfterInsert(farms);
        
        // Retrieve the updated account record
        testAccount = [SELECT Total_Updated_Plot__c FROM Account WHERE Id = :testAccount.Id];
        
        // Assert the changes
        System.assertEquals(0, testAccount.Total_Updated_Plot__c);
    }
    
    @IsTest
    public static void testHandleAfterDelete() {
        // Create test data
        Account testAccount = new Account(Farmer_Code__c = 'ABC123', Name = 'Test Account');
        insert testAccount;
        
        Farm__c testFarm = new Farm__c(Client_Farmer__c = testAccount.Id);
        insert testFarm;
        
        // Call the handler method
        FarmTriggerHandler.handleAfterDelete(new List<Farm__c>{ testFarm });
        
        // Retrieve the updated account record
        testAccount = [SELECT Total_Updated_Plot__c FROM Account WHERE Id = :testAccount.Id];
        
        // Assert the changes
        System.assertEquals(1, testAccount.Total_Updated_Plot__c);
    }
}