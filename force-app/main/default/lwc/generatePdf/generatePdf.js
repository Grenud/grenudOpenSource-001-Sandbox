import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Logo from '@salesforce/resourceUrl/FortuneLogo';
import generatePDF from '@salesforce/apex/pdfController.generatePDF'
import getFarmerRecord from '@salesforce/apex/PaddyDetailLWCController.getFarmerRecord';
import PaddyRecordID from "@salesforce/schema/Paddy_Purchase__c.Id";
import CLIENTFARMERID from "@salesforce/schema/Paddy_Purchase__c.Client_Farmer__c";
export default class GeneratePdf extends LightningElement {
    @api recordId
    ClientFarmerId;
    @track FarmerDetails={};
    IsFarmer=false;
    settelmentRecords=[];
    invoiceData=[];
    SaleInvoices=[];
    Credits=[];
    CreditCount=0;
    record='a0B0T000003fqLDUAY';
    todayDate='';
    imageUrl = Logo;
     @wire(getFarmerRecord, { recordId: "$recordId"})
      wiredRecord({ error, data }) {
        if (data) {
            console.log('data is'+data);
            if (Array.isArray(data) && data.length > 0) {
            this.FarmerDetails = JSON.parse(JSON.stringify(data[0]));
            this.SaleInvoices=data[0].Sale_Invoices1__r;
            this.Credits=data[0].Paddy_Purchases__r;
            this.CreditCount=data[0].Paddy_Purchases__r.length;
            
            }

        } else if (error) {
            console.log('An error occurred:', error);
        }
    }
    get formattedCredits() {
        return this.Credits.map(Credit => ({
            CreditID: Credit.Id,
            Name: Credit.Name,
            SettelmentAmount: Credit.Credit_Settlement__c,
            date:new Date(Credit.CreatedDate).toISOString().split('T')[0],
        }));
    }
    get formattedSales() {
        return this.SaleInvoices.map(purchase => ({
            SaleId: purchase.Id,
            Name: purchase.Name,
            date: purchase.Invoice_Date__c,
            Value:purchase.Total_Invoice_Value__c
        }));
    }
    get TodayDate(){
       var today = new Date();
     var year = today.getFullYear();
     var month = ('0' + (today.getMonth() + 1)).slice(-2);
     var day = ('0' + today.getDate()).slice(-2);
    
    return `${year}-${month}-${day}`;
    }
  /*  loadMatchingRecords() {
        getRecordsByFieldValue({ ClientFarmerId: this.ClientFarmerId })
            .then(result => {
                this.settelmentRecords = result;
                console.log(this.settelmentRecords);
            })
            .catch(error => {
                 console.log('THis is another error'+error)
            });
    }
    LoadFarmerRecord(){
        getFarmerRecord({ClientFarmerId: this.ClientFarmerId})
        .then(result => {
                this.FarmerDetails = result;
                this.IsFarmer=true;
                console.log(this.FarmerDetails);
            })
            .catch(error => {
                 console.log('THis is error during farmerload'+error)
            });
    }
    get Name() {
        if (this.FarmerDetails && this.FarmerDetails.length > 0) {
            return this.FarmerDetails[0].Name;
        }
    }

    get Phone() {
        if (this.FarmerDetails && this.FarmerDetails.length > 0) {
        return this.FarmerDetails[0].Phone;
        }
    }*/
    
    
    
    
    
    get totalAmount(){
       // return this.services.reduce((total, service)=>{
      //      return total = total+service.amount
      //  }, 0)
      return 0;
    }

    pdfHandler(){
        let content = this.template.querySelector('.container')
        console.log(content.outerHTML)
        generatePDF({ recordId:this.recordId, htmlData:content.outerHTML}).then(result=>{
            console.log("attachment id", result)
            window.open(`https://grenudcompany--grenud001.sandbox.my.salesforce.com/servlet/servlet.FileDownload?file=${result.Id}`)
        }).catch(error=>{
            console.error(error)
        })
    }
    
}