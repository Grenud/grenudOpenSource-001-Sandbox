@isTest
public class PaddyPurchasePdfPageControllerTest {

    static testMethod void testPdfTextInitialization() {
        // Set up a test PageReference
        PageReference pageRef = Page.renderAsPDF; // Replace with the actual page name
        Test.setCurrentPage(pageRef);

        // Set the 'pdfText' parameter in the page reference
        ApexPages.currentPage().getParameters().put('pdfText', 'Test PDF Text');

        // Instantiate the controller
        PaddyPurchasePdfPageController controller = new PaddyPurchasePdfPageController();

        // Verify that the pdfText property is correctly initialized
        System.assertEquals('Test PDF Text', controller.pdfText);
    }
}