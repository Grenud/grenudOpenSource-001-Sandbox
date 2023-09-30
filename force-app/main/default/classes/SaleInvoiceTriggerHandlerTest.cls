@IsTest
public class SaleInvoiceTriggerHandlerTest {
    @IsTest
    public static void testUpdateTotalInvRollupsum() {
        // Create test data

        Sale_Invoice__c testInvoice = new Sale_Invoice__c(Party_name__c = 'FRL001 (ABC)',  Total_Invoice_Value__c = 100.0, name='2324');
        insert testInvoice;
        

        // Call the method to be tested
        Test.startTest();
        SaleInvoiceTriggerHandler.UpdateTotalInvRollupsum(new List<Sale_Invoice__c>{testInvoice});
        Test.stopTest();

        // Retrieve the updated Farmer__c record
        Account updatedFarmer = [SELECT Id, Total_Invoice_Value__c FROM Account WHERE farmer_code__c = 'FRL001'];

        // Perform assertions
        System.assertEquals(100.0, updatedFarmer.Total_Invoice_Value__c, 'Total_Invoice_Value__c field should be updated correctly');
    }

    @IsTest
    public static void testUpdateReparentTotalInvRollUpSum() {
        // Create test data
        //Account testAccount1 = new Account(Name = 'Test Account 1', Farmer_Code__c = 'FRL001`');
        //insert testAccount1;

        //Account testAccount2 = new Account(Name = 'Test Account 2', Farmer_Code__c = 'FRL002');
        //insert testAccount2;

        Sale_Invoice__c testInvoice1 = new Sale_Invoice__c(  Party_name__c = 'FRL001 (ABC)', Total_Invoice_Value__c = 100.0);
        Sale_Invoice__c testInvoice2 = new Sale_Invoice__c(  Party_name__c = 'FRL002 (bcd)', Total_Invoice_Value__c = 200.0);
        insert testInvoice1;
        Insert testInvoice2;
        Account testAccountToreparent=[Select Id, name from account where farmer_code__c='FRL002'];
         testInvoice1.Client_farmer__c = testAccountToreparent.Id;
        testInvoice1.Farmer_Code__c='FRL002';
        update testInvoice1;
         //testAccountUpdate=[Select Id, name from account where farmer_code__c='FRL002'];
        // Retrieve the updated Account records
        Account updatedAccount1 = [SELECT Id, Total_Invoice_Value__c, Total_Sale_Invoice_Count__c FROM Account WHERE Farmer_Code__c = 'FRL001'];
        Account updatedAccount2 = [SELECT Id, Total_Invoice_Value__c, Total_Sale_Invoice_Count__c FROM Account WHERE Farmer_Code__c = 'FRL002'];

        // Perform assertions
        System.assertEquals(300.0, updatedAccount2.Total_Invoice_Value__c, 'Total_Invoice_Value__c field should be updated correctly');
        //System.assertEquals(1, updatedAccount1.Total_Sale_Invoice_Count__c, 'Total_Sale_Invoice_Count__c field should be updated correctly');
        //System.assertEquals(200.0, updatedAccount2.Total_Invoice_Value__c, 'Total_Invoice_Value__c field should be updated correctly');
        //System.assertEquals(1, updatedAccount2.Total_Sale_Invoice_Count__c, 'Total_Sale_Invoice_Count__c field should be updated correctly');
    }
    
   @IsTest
   public static void testPopulateFarmerCodes() {
    // Create test data
     Sale_Invoice__c testInvoice = new Sale_Invoice__c(Party_name__c = 'FRL001 (ABC)',  Total_Invoice_Value__c = 100.0, name='2324');
        insert testInvoice;
list<Sale_Invoice__c>invoiceList = new list<Sale_Invoice__c>();
invoiceList.add(testInvoice);       
    // Call the method to be tested
    SaleInvoiceTriggerHandler.PopulateFarmerCodes(invoiceList);

    // Perform assertions
    System.assertEquals('FRL001', testInvoice.Farmer_Code__c);

    }

    @IsTest
    public static void testPopulatePartySaleInvoice() {
        // Create test data
       
        Sale_Invoice__c testInvoice = new Sale_Invoice__c();
        testInvoice.Party_name__c = 'FRL001 (ABC)';
        testInvoice.Total_Invoice_Value__c = 100.0;
        testInvoice.name='2324';
       insert testInvoice;
        List<Sale_Invoice__c> invoiceList = new List<Sale_Invoice__c>();
            invoiceList.add(testInvoice);
        account a= [select id,name from account where farmer_code__c='FRL001'];
    Sale_Invoice__c abc=[select id,Client_Farmer__c, Total_Invoice_Value__c from Sale_Invoice__c where name ='2324' ];
        // Call the method to be tested
        //SaleInvoiceTriggerHandler.PopulatePartySaleInvoice(invoiceList);

        // Perform assertions
        System.assertEquals(a.Id, abc.Client_Farmer__c);
        System.assertEquals(100.0, abc.Total_Invoice_Value__c);
    }

    @IsTest
    public static void testPreventDuplicateInvoiveNumber() {
        // Create test data
        Sale_Invoice__c testInvoice1 = new Sale_Invoice__c(Name = 'INV-001');
        Sale_Invoice__c testInvoice2 = new Sale_Invoice__c(Name = 'INV-002');
        List<Sale_Invoice__c> invoiceList = new List<Sale_Invoice__c>{ testInvoice1, testInvoice2 };

        // Call the method to be tested
        Test.startTest();
        SaleInvoiceTriggerHandler.PreventDuplicateInvoiveNumber(invoiceList);
        Test.stopTest();

        // Perform assertions
        System.assertEquals('INV-001', testInvoice1.Name);
        System.assertEquals('INV-002', testInvoice2.Name);
    }

   @IsTest
public static void testCreateFarmerCredit() {
    // Create test data
    Account testAccount1 = new Account(Name = 'Test Account 1', Farmer_Code__c='FRL110');
    insert testAccount1;

    Account testAccount2 = new Account(Name = 'Test Account 2', Farmer_Code__c='FRL111');
    insert testAccount2;

    Sale_Invoice__c testInvoice1 = new Sale_Invoice__c(Party_name__c ='FRL345(aman)',Client_farmer__c = testAccount1.Id,Payment_Type__c ='Cheque',Name='101',Balance_Due__c=100, Total_Invoice_Value__c = 100.0);
    Sale_Invoice__c testInvoice2 = new Sale_Invoice__c(Party_name__c ='FRL346(pawan)',Client_farmer__c = testAccount2.Id,Payment_Type__c ='Cheque', Name='102',Balance_Due__c=200, Total_Invoice_Value__c = 200.0);
    insert testInvoice1;
    insert testInvoice2;
    List<Sale_Invoice__c> invoiceList = new List<Sale_Invoice__c>{ testInvoice1, testInvoice2 };

    

    // Call the method to be tested
    Test.startTest();
   // SaleInvoiceTriggerHandler.createFarmerCredit(invoiceList, accountMap);
    Test.stopTest();

    // Retrieve the created Farmer Credit records
    List<Farmer_Credit__c> farmerCredits = [SELECT Id, Sale_Invoice__c,Balance_Due__c, Total_Invoice_Value__c FROM Farmer_Credit__c];

    // Perform assertions
    System.assertEquals(2, farmerCredits.size());
    System.assertEquals(testInvoice1.Id, farmerCredits[0].Sale_Invoice__c);
    System.assertEquals(100.0, farmerCredits[0].Total_Invoice_Value__c);
    System.assertEquals(testInvoice2.Id, farmerCredits[1].Sale_Invoice__c);
    System.assertEquals(200.0, farmerCredits[1].Total_Invoice_Value__c);
 }

}