public class createSale {
public static void createSaleRecord(string party, string contact , string village, string tehsil , string block , string district , string state , date invDate , string invoiceNumber )
    {
        Sale_Invoice__c saleInvObj= new Sale_Invoice__c();
        saleInvObj.Block__c= block;
        saleInvObj.State__c= state;
        saleInvObj.Tehsil__c= tehsil;
        saleInvObj.Village__c= village;
     //   saleInvObj.Contact_Person__c= contact;
        saleInvObj.Name= invoiceNumber;
        saleInvObj.Party_Name__c='FRL001 (Ankit)';
        saleInvObj.Total_Invoice_Value__c=0;
        insert saleInvObj;
    }
}