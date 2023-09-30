@isTest
public class PaddyPurchasePdfControllerTest {

    static testMethod void testGeneratePDF() {
        
 // Create a test General Farmer record
    General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876543';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';
    
    insert generalFarmer;
        // Create a test Paddy_Purchase__c record
        Paddy_Purchase__c testPurchase = new Paddy_Purchase__c(General_Farmer__c=generalFarmer.Id);
      
        insert testPurchase;

        // Call the generatePDF method
        Attachment attachment = PaddyPurchasePdfController.generatePDF(testPurchase.Id, '<html><body>Test HTML</body></html>');

        // Verify that the attachment was inserted
        System.assertNotEquals(null, attachment);
        System.assertEquals('Purchase.pdf', attachment.Name);
        System.assertEquals(false, attachment.IsPrivate);

        // Uncomment the following line if you want to test the Blob content of the attachment
        // System.assertEquals('ExpectedBlobContent', attachment.Body.toString());
    }
}