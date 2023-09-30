public without sharing class pdfController {
    @AuraEnabled
    public static Attachment generatePDF(Id recordId, String htmlData){
        Pagereference page = Page.renderAsPDF;
        page.getParameters().put('pdfText', htmlData);
        
        Paddy_Purchase__c con = new Paddy_Purchase__c(Id=recordId);
        Attachment objAttachment = new Attachment();
        objAttachment.Name='invoice.pdf';
        objAttachment.ParentId = con.Id;
        objAttachment.Body = page.getContentaspdf();
        objAttachment.IsPrivate = false;
        insert objAttachment;
        return objAttachment;
    }
}