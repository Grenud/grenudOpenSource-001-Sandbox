@IsTest
public class ProductItemTriggerHandlerTest {
    @IsTest
    public static void testProductItemInsert() {
        // Create test data
        List<Sale_Invoice__c> saleInvoiceList = new List<Sale_Invoice__c>();
        saleInvoiceList.add(new Sale_Invoice__c(Name = 'INV001', Party_name__c = 'FRL001 (ABC)', Total_Invoice_Value__c = 100));
        saleInvoiceList.add(new Sale_Invoice__c(Name = 'INV002', Party_name__c = 'FRL002 (ABC)', Total_Invoice_Value__c = 200));
        insert saleInvoiceList;

        List<Product_Item__c> productList = new List<Product_Item__c>();
        productList.add(new Product_Item__c(Invoice_No__c = 'INV001'));
        productList.add(new Product_Item__c(Invoice_No__c = 'INV002'));

        Test.startTest();
        insert productList;
        Test.stopTest();

        // Retrieve the updated Product_Item__c records
        productList = [
            SELECT Id, Sale_Invoice__c,Invoice_No__c
            FROM Product_Item__c
            WHERE Id IN :productList
        ];

        // Verify the results
        for (Product_Item__c product : productList) {
            if (product.Invoice_No__c == 'INV001' || product.Invoice_No__c == 'INV002') {
                Sale_Invoice__c matchingInvoice = null;
                for (Sale_Invoice__c invoice : saleInvoiceList) {
                    if (invoice.Name == product.Invoice_No__c) {
                        matchingInvoice = invoice;
                        break;
                    }
                }
                System.assertEquals(matchingInvoice.Id, product.Sale_Invoice__c);
            } else {
                System.assert(product.HasErrors()); // Verify that error message is added
                System.assert(product.Sale_Invoice__c == null); // Verify that Sale_Invoice__c field is not updated
            }
        }
    }
}