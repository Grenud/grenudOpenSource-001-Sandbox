public class InvoiceCreditWrapper {
    @AuraEnabled
    public Sale_Invoice__c saleInvoice { get; set; }
    @AuraEnabled
    public Farmer_Credit__c credit { get; set; }

    public InvoiceCreditWrapper(Sale_Invoice__c saleInvoice, Farmer_Credit__c credit) {
        this.saleInvoice = saleInvoice;
        this.credit = credit;
    }
    
    @AuraEnabled
public static List<InvoiceCreditWrapper> getInvoiceCreditData(String recordId) {
    String ClientFarmerId  ;
            List<Paddy_Purchase__c>PaddyRecordList=[Select Id, Client_Farmer__c from Paddy_Purchase__c where ID=:recordId ];
            if(PaddyRecordList.size()>0){
                ClientFarmerId=PaddyRecordList[0].Client_Farmer__c;
            }
    List<InvoiceCreditWrapper> result = new List<InvoiceCreditWrapper>();

    List<Sale_Invoice__c> invoices = [SELECT Id, Name, Total_Invoice_Value__c, Invoice_Date__c FROM Sale_Invoice__c WHERE Client_Farmer__c = :ClientFarmerId];
    List<Farmer_Credit__c> credits = [SELECT Id,Sale_Invoice__c, Name, Balance_Due__c, Invoice_Number__c FROM Farmer_Credit__c WHERE Client_Farmer__c = :ClientFarmerId ];//AND Type__c = :type

    Map<String, Farmer_Credit__c> invoiceNumberToCredit = new Map<String, Farmer_Credit__c>();
    for (Farmer_Credit__c credit : credits) {
        invoiceNumberToCredit.put(credit.Sale_Invoice__c, credit);
    }

    for (Sale_Invoice__c invoice : invoices) {
        Farmer_Credit__c associatedCredit = invoiceNumberToCredit.get(invoice.ID);
        result.add(new InvoiceCreditWrapper(invoice, associatedCredit));
    }

    return result;
}

}