@isTest
public class SupplyBillingTriggerHandlerTest {    
// Helper method to create Supply_Billing__c records
    public static Supply_Billing__c createSupplyBilling(String billFrom, Decimal series, Decimal series1) {
        Supply_Billing__c supplyBilling = new Supply_Billing__c(
            Bill_From__c = billFrom,
            Series__c = series,
            Series1__c = series1
        );
        insert supplyBilling;
        return supplyBilling;
    }

    @isTest
    public static void testBeforeInsertInvoice() {
        // Create test data
        Supply_Billing__c frlRecord = createSupplyBilling('FORTUNE RICE LIMITED', 1, null);
        Supply_Billing__c agroRecord = createSupplyBilling('FORTUNE AGROMART PVT LTD', null, 1);

        // Create a list of new records to simulate trigger context
        List<Supply_Billing__c> newRecords = new List<Supply_Billing__c>{frlRecord, agroRecord};

        // Call the trigger handler method
        SupplyBillingTriggerHandler.handleBeforeInsertInvoice(newRecords);

        // Assert the results
        for (Supply_Billing__c record : newRecords) {
            if (record.Bill_From__c == 'FORTUNE RICE LIMITED') {
                System.assertEquals(1, record.Series__c);
                System.assertEquals(null, record.Series1__c);
                System.assertEquals(1, record.Invoice_No__c);
            } else if (record.Bill_From__c == 'FORTUNE AGROMART PVT LTD') {
                System.assertEquals(1, record.Series1__c);
                System.assertEquals(null, record.Series__c);
                System.assertEquals(1, record.Invoice_No__c);
            }
        }
    }

    @isTest
    public static void testBeforeUpdateInvoice() {
        // Create test data
        Supply_Billing__c frlRecord = createSupplyBilling('FORTUNE RICE LIMITED', 1, null);
        Supply_Billing__c agroRecord = createSupplyBilling('FORTUNE AGROMART PVT LTD', null, 1);

        // Change the Bill_From__c value to trigger the update logic
        frlRecord.Bill_From__c = 'FORTUNE AGROMART PVT LTD';
        agroRecord.Bill_From__c = 'FORTUNE RICE LIMITED';

        // Create a list of updated records to simulate trigger context
        List<Supply_Billing__c> updatedRecords = new List<Supply_Billing__c>{frlRecord, agroRecord};

        // Create a map of old records to simulate trigger context
        Map<Id, Supply_Billing__c> oldMap = new Map<Id, Supply_Billing__c>{
            frlRecord.Id => new Supply_Billing__c(Bill_From__c = 'FORTUNE RICE LIMITED'),
            agroRecord.Id => new Supply_Billing__c(Bill_From__c = 'FORTUNE AGROMART PVT LTD')
        };
              Test.startTest();
              update updatedRecords;
              Test.stopTest();

        // Call the trigger handler method
        SupplyBillingTriggerHandler.handleBeforeUpdateInvoice(updatedRecords, oldMap);

        // Assert the results
        for (Supply_Billing__c record : updatedRecords) {
            if (record.Bill_From__c == 'FORTUNE RICE LIMITED') {
                System.assertEquals(3, record.Series__c);
                System.assertEquals(null, record.Series1__c);
                System.assertEquals(3, record.Invoice_No__c);
            } else if (record.Bill_From__c == 'FORTUNE AGROMART PVT LTD') {
                System.assertEquals(3, record.Series1__c);
                System.assertEquals(null, record.Series__c);
                System.assertEquals(3, record.Invoice_No__c);
            }
        }
    } 
    
    @isTest
    static void testHandleBeforeInsertShipTo() {
        // Create test data
        List<Supply_Billing__c> newRecords = new List<Supply_Billing__c>();
        List<Supply_Billing__c> newRecords2 = new List<Supply_Billing__c>();
        Supply_Billing__c billing1 = new Supply_Billing__c();
        billing1.Bill_To__c = 'FORTUNE RICE LIMITED';
        
        Supply_Billing__c billing2 = new Supply_Billing__c();
        billing2.Bill_To__c = 'PP AGRO INDIA';
        
        newRecords.add(billing1);
        newRecords2.add(billing2);

        // Insert the records
        Test.startTest();
        insert newRecords;
        insert newRecords2;
        Test.stopTest();

        // Verify that the Ship To fields are populated correctly
        Supply_Billing__c insertedBilling = [SELECT Ship_To__c, Ship_To_Address__c, Ship_To_Buyer_GSTIN_UIN__c, Ship_To_State__c, Ship_To_Country__c FROM Supply_Billing__c WHERE Id = :billing1.Id];
        System.assertEquals('FORTUNE RICE LIMITED', insertedBilling.Ship_To__c);
        System.assertEquals('ADDRESS-KHASRA NO.378 VILLAGE NAGLA CHAMRU G.T.,ROAD DADRI-203207 GAUTAM BUDDHA NAGAR', insertedBilling.Ship_To_Address__c);
        System.assertEquals('09AAACF8740K1ZB', insertedBilling.Ship_To_Buyer_GSTIN_UIN__c);
        System.assertEquals('Uttar Pradesh', insertedBilling.Ship_To_State__c);
        System.assertEquals('India', insertedBilling.Ship_To_Country__c);
        Supply_Billing__c insertedBilling2 = [SELECT Ship_To__c, Ship_To_Address__c, Ship_To_Buyer_GSTIN_UIN__c, Ship_To_State__c, Ship_To_Country__c FROM Supply_Billing__c WHERE Id = :billing2.Id];
         System.assertEquals('PP AGRO INDIA', insertedBilling2.Ship_To__c);
        System.assertEquals('CHANDAUS PISAVA ROAD ELAMPURA THE-GABHANA ALIGARH-202132', insertedBilling2.Ship_To_Address__c);
    }

    @isTest
    static void testHandleBeforeUpdateShipTo() {
        // Create test data
        Supply_Billing__c billing = new Supply_Billing__c();
        Supply_Billing__c billing2 = new Supply_Billing__c();
        
        billing.Bill_To__c = 'FORTUNE RICE LIMITED';
        billing2.Bill_To__c = 'PP AGRO INDIA';
        insert billing;
        insert billing2;
        
        billing.Bill_To__c = 'PP AGRO INDIA';
        billing2.Bill_To__c = 'FORTUNE RICE LIMITED';
        
        // Update the record
        Test.startTest();
        update billing;
        update billing2;
        Test.stopTest();

        // Verify that the Ship To fields are updated correctly
        Supply_Billing__c updatedBilling = [SELECT Ship_To__c, Ship_To_Address__c, Ship_To_Buyer_GSTIN_UIN__c, Ship_To_State__c, Ship_To_Country__c FROM Supply_Billing__c WHERE Id = :billing.Id];
        System.assertEquals('PP AGRO INDIA', updatedBilling.Ship_To__c);
        System.assertEquals('CHANDAUS PISAVA ROAD ELAMPURA THE-GABHANA ALIGARH-202132', updatedBilling.Ship_To_Address__c);
        System.assertEquals('09ABDFP3889N1ZC', updatedBilling.Ship_To_Buyer_GSTIN_UIN__c);
        System.assertEquals('Uttar Pradesh', updatedBilling.Ship_To_State__c);
        System.assertEquals('India', updatedBilling.Ship_To_Country__c);
        Supply_Billing__c updatedBilling2 = [SELECT Ship_To__c, Ship_To_Address__c, Ship_To_Buyer_GSTIN_UIN__c, Ship_To_State__c, Ship_To_Country__c FROM Supply_Billing__c WHERE Id = :billing2.Id];
         System.assertEquals('FORTUNE RICE LIMITED',updatedBilling2.Ship_To__c);
    }
}