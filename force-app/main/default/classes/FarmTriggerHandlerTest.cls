@IsTest
public class FarmTriggerHandlerTest {
     @isTest
    static void testTrigger() {
        // Create test data
        Account testAccount = new Account(
            Name = 'Test Account',
            Farmer_code__c = '123456'
            
        );
        insert testAccount;

        Farm__c testFarm = new Farm__c(
            client_Farmer__c = testAccount.Id,
            RecordTypeId = System.Label.FarmFieldUserRecordTYpeID
            
        );

        // Insert the test farm record
        Test.startTest();
        insert testFarm;
        Test.stopTest();

        // Query the inserted farm record
        Farm__c insertedFarm = [SELECT Id, Name, Farmer_Code__c, Series__c, client_Farmer__c
                                FROM Farm__c WHERE Id = :testFarm.Id];

        // Perform assertions
        System.assertEquals(testAccount.Farmer_code__c, insertedFarm.Farmer_Code__c, 'Farmer code does not match');
        System.assertEquals('123456F1', insertedFarm.Name, 'Farm name does not match');
        System.assertEquals(1, insertedFarm.Series__c, 'Series number does not match');
        
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