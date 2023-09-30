@isTest
public class pdfPageControllerTest {

    @isTest
    static void testPdfPageController() {
        // Create a test PageReference
        PageReference pageRef = Page.renderAsPDF; // Replace with your actual Visualforce page name
        Test.setCurrentPageReference(pageRef);

        // Set a query parameter for 'pdfText'
        pageRef.getParameters().put('pdfText', 'Sample PDF Text');

        // Instantiate the controller
        pdfPageController controller = new pdfPageController();

        // Verify that the 'pdfText' property is set correctly
        System.assertEquals('Sample PDF Text', controller.pdfText);
    }
}