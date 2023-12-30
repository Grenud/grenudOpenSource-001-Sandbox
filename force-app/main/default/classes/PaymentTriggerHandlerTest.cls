@isTest
public class PaymentTriggerHandlerTest {
    
    @isTest
    static void testUpdateCashCreditAmountRollup() {
    List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' , Credit_Settlement_By_Cash__c = 100,Farmer_Code__c='FRL001'+ i));
        }
        insert testAccounts;

        // Create test data: Paddy Purchases
        List<Payment__c> testPayments = new List<Payment__c>();
        for (Account acc : testAccounts) {
            testPayments.add(new Payment__c(
                Client_farmer__c = acc.Id,
                Total_Amount__c = 50
            ));
        }
        insert testPayments;

        // Call the trigger handler method
        Test.startTest();
        delete testPayments;
        undelete testPayments;
        Test.stopTest();

        // Verify that Account Credit_Settlement__c values are updated correctly after deletion and undeletion
        List<Account> updatedAccounts = [SELECT Id, Credit_Settlement_By_Cash__c FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            Decimal expectedValue = 0;
            for (Payment__c purchase : testPayments) {
                if (purchase.Client_farmer__c == acc.Id && purchase.Total_Amount__c != null) {
                    expectedValue += purchase.Total_Amount__c;
                }
            }
            System.assertEquals(expectedValue, acc.Credit_Settlement_By_Cash__c);
        }
    }
   
    @isTest
    static void testUpdateReparentCreditSettRollUpSum() {
        // Create test data: Accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ',Farmer_Code__c='FRL001' + i));
        }
        insert testAccounts;

        // Create test data: Paddy Purchases
        List<Payment__c> testPayments = new List<Payment__c>();
        for (Account acc : testAccounts) {
            testPayments.add(new Payment__c(
                Client_farmer__c = acc.Id,
                Total_Amount__c = 50
            ));
        }
        insert testPayments;

        // Modify Credit Settlement on some purchases
        testPayments[0].Total_Amount__c = 100;
        update testPayments;

        // Create a map of old Total_Amount__c records
        Map<Id, Payment__c> oldMapPurchases = new Map<Id, Payment__c>([SELECT Id,Client_farmer__c FROM Payment__c WHERE Id IN :testPayments]);

        // Call the trigger handler method
        Test.startTest();
        PaymentTriggerHandler.updateReparentCashCreditAmountRollup(null, testPayments, oldMapPurchases);
        Test.stopTest();

        // Verify that Account Credit_Settlement__c values are updated correctly
        List<Account> updatedAccounts = [SELECT Id, Credit_Settlement_By_Cash__c FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            Decimal expectedValue = 100;
            for (Payment__c purchase : testPayments) {
                if (purchase.Client_farmer__c == acc.Id && purchase.Total_Amount__c != null) {
                    expectedValue += purchase.Total_Amount__c;
                }
            }
         //   System.assertEquals(expectedValue, acc.Credit_Settlement_By_Cash__c);
        }
}
}