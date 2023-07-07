@IsTest
public class AccountTriggerHandlerTest {
    @IsTest
    public static void testAccountTriggerHandler() {
        // Create test data
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Farmer_Code__c = 'F' + i;
            acc.Total_Plot__c = 3;
            acc.Village__c = 'Test Village';
            acc.Block__c = 'Test Block';
            acc.District__c = 'Test District';
            accounts.add(acc);
        }
        
        // Insert test accounts
        Test.startTest();
        insert accounts;
        Test.stopTest();
        
        // Verify that farms were created
        List<Farm__c> farms = [SELECT Name, Farmer_Code__c, Client_Farmer__c, Village__c, Block__c, District__c FROM Farm__c];
        System.assertEquals(accounts.size() * 3, farms.size(), 'Incorrect number of farms created');
        
        // Verify farm properties
        for (Farm__c farm : farms) {
            System.assertNotEquals(null, farm.Name);
            System.assertNotEquals(null, farm.Farmer_Code__c);
            System.assertNotEquals(null, farm.Client_Farmer__c);
            System.assertNotEquals(null, farm.Village__c);
            System.assertNotEquals(null, farm.Block__c);
            System.assertNotEquals(null, farm.District__c);
        }
    }
    
    @IsTest
    public static void testAccountTriggerHandler_WithoutTotalPlot() {
        // Create test account without Total_Plot__c value
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Farmer_Code__c = 'F1';
        acc.Village__c = 'Test Village';
        acc.Block__c = 'Test Block';
        acc.District__c = 'Test District';
        
        // Insert test account
        Test.startTest();
        insert acc;
        Test.stopTest();
        
        // Verify that no farms were created
        List<Farm__c> farms = [SELECT Name, Farmer_Code__c, Client_Farmer__c, Village__c, Block__c, District__c FROM Farm__c];
        System.assertEquals(0, farms.size(), 'Farms should not have been created');
    }

    @IsTest
    public static void testAccountTriggerHandler_UpdateTotalPlot() {
        // Create test account with an initial Total_Plot__c value of 2
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Farmer_Code__c = 'F1';
        acc.Total_Plot__c = 2;
        acc.Village__c = 'Test Village';
        acc.Block__c = 'Test Block';
        acc.District__c = 'Test District';
        
        // Insert test account
        insert acc;
        
        // Update the Total_Plot__c value to 5
        acc.Total_Plot__c = 5;
        
        // Update the account
        Test.startTest();
        update acc;
        Test.stopTest();
        
        // Verify that the correct number of farms were created
        List<Farm__c> farms = [SELECT Name, Farmer_Code__c, Client_Farmer__c, Village__c, Block__c, District__c FROM Farm__c];
        System.assertEquals(acc.Total_Plot__c, farms.size(), 'Incorrect number of farms created');
        
        // Verify farm properties
        for (Farm__c farm : farms) {
            System.assertNotEquals(null, farm.Name);
            System.assertNotEquals(null, farm.Farmer_Code__c);
            System.assertNotEquals(null, farm.Client_Farmer__c);
            System.assertNotEquals(null, farm.Village__c);
            System.assertNotEquals(null, farm.Block__c);
            System.assertNotEquals(null, farm.District__c);
        }
    }
}