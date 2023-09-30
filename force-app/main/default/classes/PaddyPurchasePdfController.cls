public without sharing class PaddyPurchasePdfController {
    @AuraEnabled
    public static Attachment generatePDF(Id recordId, String htmlData){
        Pagereference page = Page.renderAsPurchasePdf;
        page.getParameters().put('pdfText', htmlData);

        Paddy_Purchase__c con = new Paddy_Purchase__c(Id=recordId);
        Attachment objAttachment = new Attachment();
        objAttachment.Name='Purchase.pdf';
        objAttachment.ParentId = con.Id;
        objAttachment.Body = page.getContentaspdf();
        objAttachment.IsPrivate = false;
        insert objAttachment;
        return objAttachment;
    }


   
    /* 
@AuraEnabled
public static Attachment generatePDF(Id recordId, String htmlData) {

Blob pdfBlob;

try {
PageReference pageRef = Page.PaddyPurchaseInvoice;
pageRef.getParameters().put('pdfText',htmlData );
pdfBlob = pageRef.getContentAsPDF();
} catch (Exception e) {
System.debug('PDF Generation Error: ' + e.getMessage());

}
Attachment objAttachment = new Attachment();
objAttachment.Name = 'Purchase.pdf';
objAttachment.ParentId = recordId;
objAttachment.Body = pdfBlob;
objAttachment.IsPrivate = false;
insert objAttachment;
return objAttachment;
} */
}