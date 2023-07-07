@IsTest
public class FarmerCreditTriggerHandlerTest {
    @IsTest
    public static void testUpdateReparentCreditRollUpSum() {
        // Create test data
        List<Farmer_Credit__c> oldList = new List<Farmer_Credit__c>();
        List<Farmer_Credit__c> newList = new List<Farmer_Credit__c>();
        Map<Id, Farmer_Credit__c> cFoldMap = new Map<Id, Farmer_Credit__c>();

        // Create and insert Farmer_Credit__c records
        Account testAccount1 = new Account(Name = 'Test Account 1',Farmer_Code__c='121');
        insert testAccount1;
        Farmer_Credit__c farmerCredit1 = new Farmer_Credit__c(Client_farmer__c = testAccount1.Id, Farmer_Code__c = testAccount1.Id, Total_Invoice_Value__c = 200.0);
        insert farmerCredit1;
        // Ensure farmerCredit1 has a valid value before adding it to cFoldMap
        if (farmerCredit1 != null) {
            cFoldMap.put(farmerCredit1.Id, farmerCredit1);
        }

        Account testAccount2 = new Account(Name = 'Test Account 2',Farmer_Code__c='FRL123');
        insert testAccount2;
        Farmer_Credit__c farmerCredit2 = new Farmer_Credit__c(Client_farmer__c = testAccount2.Id,Farmer_Code__c = testAccount2.Id, Total_Invoice_Value__c = 200.0);
        insert farmerCredit2;
        if (farmerCredit2 != null) {
            cFoldMap.put(farmerCredit2.Id, farmerCredit2);
        }

        // Populate oldList, newList, and cFoldMap with test data
        oldList.add(farmerCredit1);
        newList.add(farmerCredit2);
        cFoldMap.put(farmerCredit1.Id, farmerCredit1);

        // Call the method to be tested
        Test.startTest();
        FarmerCreditTriggerHandler.UpdateReparentCreditRollUpSum(oldList, newList, cFoldMap);
        Test.stopTest();

        // Retrieve the updated Account records
        List<Account> updatedAccounts = [SELECT Id, Total_Farmer_Credit__c FROM Account WHERE Id IN :new Set<Id>{testAccount1.Id, testAccount2.Id}];

        // Perform assertions
        for (Account acc : updatedAccounts) {
            // Perform assertions on the Total_Farmer_Credit__c field of the Account records
            // Replace expectedTotalCreditValue with the expected value based on your scenario
            Decimal expectedTotalCreditValue = 200.0;
            System.assertEquals(expectedTotalCreditValue, acc.Total_Farmer_Credit__c);
        }
    }

    @IsTest
    public static void testUpdateReparentCreditRollUpSumTriggerEvent() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account', Farmer_Code__c = '123');
        insert testAccount;

        Farmer_Credit__c farmerCredit1 = new Farmer_Credit__c(Client_farmer__c = testAccount.Id, Farmer_Code__c = testAccount.Id, Total_Invoice_Value__c = 200.0);
        insert farmerCredit1;

        // Modify the farmerCredit1 record to trigger the update event
        farmerCredit1.Total_Invoice_Value__c = 300.0;
        update farmerCredit1;

        // Retrieve the updated Account record
        Account updatedAccount = [SELECT Id, Total_Farmer_Credit__c FROM Account WHERE Id = :testAccount.Id];

        // Perform assertions
        Decimal expectedTotalCreditValue = 300.0;
        System.assertEquals(expectedTotalCreditValue, updatedAccount.Total_Farmer_Credit__c);
    }
}