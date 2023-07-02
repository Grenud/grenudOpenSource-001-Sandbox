@isTest
  public class TestCreateInvRecord {    
    @isTest
    public static void testCreateRecord() {
        // Create an Account record
        Account testAccount = new Account(Name = 'ABC Company',Farmer_Code__c='FRL001');
        insert testAccount;

        // Test data
        String jsonString = '{"PartyName":"FRL001 (Test Party)","Party": "' + testAccount.Id + '", "InvNumber": "INV001", "Phone": "1234567890", "Email": "john.doe@example.com", "Village": "Village A", "Block": "Block B", "Taishil": "Tehsil C", "State": "Uttar Pradesh", "District": "Gautam Buddha Nagar"}';
        String jsonStr = '[{"index": 1, "SrNo": 1, "item": "Item A", "description": "Description A", "quantity": 5, "UoM": "Kg", "rate": 10, "Discount": 2, "DiscountPrice": 8, "Total": 40}, {"index": 2, "SrNo": 2, "item": "Item B", "description": "Description B", "quantity": 3, "UoM": "Kg", "rate": 15, "Discount": 1, "DiscountPrice": 14, "Total": 42}]';

        // Perform the test
        Test.startTest();
        CreateINvRecord.createRecord(jsonString, jsonStr);
        Test.stopTest();

        // Verify the results
        List<Sale_Invoice__c> createdInvoices = [SELECT Id, Name, Client_Farmer__c, Total_Invoice_Value__c FROM Sale_Invoice__c];
        System.assertEquals(1, createdInvoices.size());
        Sale_Invoice__c createdInvoice = createdInvoices[0];
        System.assertEquals(testAccount.Id, createdInvoice.Client_Farmer__c);
        System.assertEquals('INV001', createdInvoice.Name);
        system.assertEquals(0, createdInvoice.Total_Invoice_Value__c);
        

        List<Product_Item__c> createdItems = [SELECT Id, Sale_Invoice__c,Product__c, Product_Item_Description__c, Quantity__c FROM Product_Item__c];
        System.assertEquals(2, createdItems.size());
        Product_Item__c item1 = createdItems[0];
        Product_Item__c item2 = createdItems[1];

        // Assertion for Item 1
        System.assertEquals(createdInvoice.Id, item1.Sale_Invoice__c);
        //System.assertEquals('Item A', item1.Product__c);
        System.assertEquals('Description A', item1.Product_Item_Description__c);
        System.assertEquals(5, item1.Quantity__c);

        // Assertion for Item 2
        System.assertEquals(createdInvoice.Id, item2.Sale_Invoice__c);
        //System.assertEquals('Item B', item2.Product__c);
        System.assertEquals('Description B', item2.Product_Item_Description__c);
        System.assertEquals(3, item2.Quantity__c);
    }
}