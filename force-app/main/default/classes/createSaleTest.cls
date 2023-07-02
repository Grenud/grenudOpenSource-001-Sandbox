@IsTest
public class createSaleTest {
    @IsTest
    static void testCreateSaleRecord() {
        // Test data
        Account acc=new account ();
        Acc.name='TEST NAME';
        Acc.Farmer_Code__c='FRL102';
        Insert Acc;
        Contact Con = new Contact();
        Con.accountID=Acc.Id;
        Con.LastName='AAA';
        String party = Acc.ID;
        String contact = Con.ID;
        String village = 'Test Village';
        String tehsil = 'Test Tehsil';
        String block = 'Test Block';
        String district = 'Test District';
        String state = 'Uttar Pradesh';
        Date invDate = system.today();
        String invoiceNumber = 'INV-001';

        // Create test records
        Test.startTest();
        createSale.createSaleRecord(Acc.id, Con.id,village,tehsil,block,district,state,invDate,invoiceNumber);
        /*Sale_Invoice__c Sobj=new Sale_Invoice__c();
        Sobj.Name='INV-001';
        Sobj.Adhaar_Card_No__c='5515115414';
        Sobj.Party_Name__c='FRL101 (Test Party)';
        Sobj.Block__c='Test Block';
        Sobj.State__c='Uttar Pradesh';
        Sobj.Tehsil__c='Test Tehsil';
        Sobj.Total_Invoice_Value__c=5448;
        Sobj.Village__c='Test Village';
        
        insert Sobj;*/
        
        Test.stopTest();

        // Verify the created record
        List<Sale_Invoice__c> saleInvoices = [SELECT Name, Block__c, State__c, Tehsil__c, Village__c FROM Sale_Invoice__c];
        System.assertEquals(1, saleInvoices.size());
        Sale_Invoice__c createdInvoice = saleInvoices[0];
        System.assertEquals(invoiceNumber, createdInvoice.Name);
        System.assertEquals(block, createdInvoice.Block__c);
        System.assertEquals(state, createdInvoice.State__c);
        System.assertEquals(tehsil, createdInvoice.Tehsil__c);
        System.assertEquals(village, createdInvoice.Village__c);
    }
}