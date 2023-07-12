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
    
    @IsTest
    public static void testHandleAfterAddressUpdate() {
        // Create test data
        Account oldAccount = new Account(Name='Test Account',Farmer_Code__c='FRL001',Village__c = 'OldVillage', Block__c = 'OldBlock', District__c = 'OldDistrict');
        insert oldAccount;
        
        Account newAccount = new Account(id=oldAccount.id, Name='Test Account',Farmer_Code__c='FRL001',Village__c = 'NewVillage', Block__c = 'NewBlock', District__c = 'NewDistrict');
        update newAccount;
        
        Farm__c farm = new Farm__c(Client_Farmer__c = newAccount.Id);
        insert farm;
        
        Kit_Schedule__c kitSchedule = new Kit_Schedule__c(Client_Farmer__c = newAccount.Id);
        insert kitSchedule;
        
        Field_Visit__c fieldVisit = new Field_Visit__c(Client_Farmer__c = newAccount.Id);
        insert fieldVisit;
        
        // Prepare test data maps
        List<Account> newAccountList = new List<Account>{ newAccount };
        Map<Id, Account> newAccountsMap = new Map<Id, Account>{ newAccount.Id => newAccount };
        Map<Id, Account> oldAccountsMap = new Map<Id, Account>{ oldAccount.Id => oldAccount };
        
        Test.startTest();
        // Call the method to be tested
        AccountTriggerHandler.HandleAfterAdressUpdate(newAccountList, newAccountsMap, oldAccountsMap);
        Test.stopTest();
        
        // Verify the updated fields
        Farm__c updatedFarm = [SELECT Village__c, Block__c, District__c FROM Farm__c WHERE Id = :farm.Id];
        System.assertEquals(newAccount.Village__c, updatedFarm.Village__c);
        System.assertEquals(newAccount.Block__c, updatedFarm.Block__c);
        System.assertEquals(newAccount.District__c, updatedFarm.District__c);
        
        Kit_Schedule__c updatedKitSchedule = [SELECT Village__c, Block__c, District__c FROM Kit_Schedule__c WHERE Id = :kitSchedule.Id];
        System.assertEquals(newAccount.Village__c, updatedKitSchedule.Village__c);
        System.assertEquals(newAccount.Block__c, updatedKitSchedule.Block__c);
        System.assertEquals(newAccount.District__c, updatedKitSchedule.District__c);
        
        Field_Visit__c updatedFieldVisit = [SELECT Village__c, Block__c FROM Field_Visit__c WHERE Id = :fieldVisit.Id];
        System.assertEquals(newAccount.Village__c, updatedFieldVisit.Village__c);
        System.assertEquals(newAccount.Block__c, updatedFieldVisit.Block__c);
    }  
    
}