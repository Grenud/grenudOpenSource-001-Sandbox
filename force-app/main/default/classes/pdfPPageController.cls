public with sharing class pdfPPageController {
    public String pdfText{get;set;}
    public pdfPPageController() {
        pdfText = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfText')
        );
    }
}