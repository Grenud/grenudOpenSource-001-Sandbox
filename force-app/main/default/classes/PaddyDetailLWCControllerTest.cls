@isTest
public class PaddyDetailLWCControllerTest {

   @isTest
    static void testGetFarmerPurchaseDetails() {
        // Create test data
        Account clientFarmer = new Account(Name = 'Test Client Farmer',Farmer_Code__c='FRL001');
        General_Farmer__c generalFarmer = new General_Farmer__c();
        generalFarmer.Name='Test General Farmer';
        generalFarmer.Farmer_Name__c='Test General Farmer';
        generalFarmer.Father_Name__c='Test General Farmer Father';
        generalFarmer.Phone__c='9876543';
        generalFarmer.Village__c='Jhajhr';
        generalFarmer.Block__c='Jewar';
        generalFarmer.District__c='Gb';
        insert clientFarmer;
        insert generalFarmer;

        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(General_Farmer__c = generalFarmer.Id);
        insert paddyPurchase;

        // Call the controller method
        List<SObject> result = PaddyDetailLWCController.getFarmerPurchaseDetails(paddyPurchase.Id);

        // Add your assertions here to verify the result

        // Example assertion (customize as per your actual data)
        System.assertEquals(1, result.size());
    }

    @isTest
    static void testGetFarmerRecord() {
        // Create test data
        Account clientFarmer = new Account(Name = 'Test Client Farmer',Farmer_Code__c='FRL001');
        insert clientFarmer;

        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(Client_Farmer__c = clientFarmer.Id);
        insert paddyPurchase;

        // Call the controller method
        List<SObject> result = PaddyDetailLWCController.getFarmerRecord(paddyPurchase.Id);

        // Add your assertions here to verify the result

        // Example assertion (customize as per your actual data)
        System.assertEquals(1, result.size());
    }
}