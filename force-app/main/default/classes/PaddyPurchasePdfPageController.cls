public without sharing class PaddyPurchasePdfPageController {
    public String pdfText{get;set;}
    public PaddyPurchasePdfPageController() {
        pdfText = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfText')
        );
    }
}