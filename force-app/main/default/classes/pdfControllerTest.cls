@isTest
public class pdfControllerTest {

    static testmethod void testGeneratePDF() {
        
        General_Farmer__c generalFarmer = new General_Farmer__c();
        generalFarmer.Name = 'Test General Farmer';
        generalFarmer.Farmer_Name__c = 'Test General Farmer';
        generalFarmer.Father_Name__c = 'Test General Farmer Father';
        generalFarmer.Phone__c = '9876543584';
        generalFarmer.Village__c = 'Jhajhr';
        generalFarmer.Block__c = 'GONDA';
        generalFarmer.District__c = 'ALIGARH';
        insert generalFarmer;
        
        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(General_Farmer__c=generalFarmer.Id);
        // Add any other required fields
        insert paddyPurchase;

        // Create a mock PageReference using the factory (you might need to adjust the page name)
        PageReference mockPageReference = Page.renderAsPDF; // Replace with your actual page name

        // Set up the PageReference parameters
        mockPageReference.getParameters().put('pdfText', 'Sample HTML Data');

        Test.startTest();
        Attachment result = pdfController.generatePDF(paddyPurchase.Id, 'Sample HTML Data');
        Test.stopTest();

        // Perform assertions on the result and any other necessary verifications
        System.assertNotEquals(null, result);

        // Example: Verify that the Attachment was inserted
        Attachment insertedAttachment = [SELECT Id FROM Attachment WHERE Id = :result.Id LIMIT 1];
        System.assertNotEquals(null, insertedAttachment);
    } 
}