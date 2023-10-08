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
    FarmerCredits=[];
    Purchases=[];
    PurchaseCount=0;
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
            this.FarmerCredits=data[0].Farmer_Credits__r;
            this.Purchases=data[0].Paddy_Purchases__r;
            this.PurchaseCount=data[0].Paddy_Purchases__r.length;
            
            }

        } else if (error) {
            console.log('An error occurred:', error);
        }
    }

    get formattedCredits() {
        return this.FarmerCredits.map(Credit => ({
            CreditID: Credit.Id,
            Name: Credit.Name,
            BalanceDue : Credit.Balance_Due__c,
            InvoiceNumber : Credit.Invoice_Number__c

        }));
    }
    get formattedSales() {
        return this.SaleInvoices.map(sale => ({
            SaleId: sale.Id,
            Name: sale.Name,
            date: sale.Invoice_Date__c,
            Value:sale.Total_Invoice_Value__c
        }));
    }

    get creditNamesforSale() {
        return (saleId) => {
            const creditNames = this.creditNameMap[saleId];
            return creditNames || ['------'];
        };
    }


   // Modify your JavaScript code
   compareAndProcess() {
    const creditNameMap = new Map(); // Use a Map to associate credits with sales
    const creditBalanceMap = new Map();

    this.formattedSales.forEach(sale => {
        creditNameMap.set(sale.SaleId, []); // Initialize an empty array for each sale
       // creditBalanceMap.set(sale.SaleId, []);
        
    });

    this.formattedSales.forEach(sale => {
        this.formattedCredits.forEach(credit => {
            if (credit.InvoiceNumber === sale.Name) {
                // Execute your further processing logic here
                console.log(`Match found: ${credit.CreditID} is equal to ${sale.SaleId}`);
                const creditNames = creditNameMap.get(sale.SaleId);
               // const creditBalance = creditBalanceMap.get(sale.SaleId);

                console.log('Credit Names:', creditNames);
                if (creditNames) {
                    creditNames.push(credit.Name);
                }
                 console.log('Credit Balance :', creditBalance);
                if(creditBalance){
                     creditBalance.push(credit.BalanceDue);
                 }
            }
        });
    });
       

    console.log('Updated creditNames : ', this.creditNames);
    this.creditNameMap = creditNameMap;

       // Debuggers to inspect data structures
       console.log('Formatted Credits:');
       this.formattedCredits.forEach(credit => console.log(credit));
       
       console.log('Formatted Sales:');
       this.formattedSales.forEach(sale => console.log(sale));
       
       console.log('Credit Name Map:');
       creditNameMap.forEach((value, key) => {
           console.log(`Key: ${key}, Value: ${value}`);
       });

       console.log('Credit Balance Map:');
       creditBalanceMap.forEach((value, key) => {
           console.log(`Key: ${key}, Value: ${value}`);
       });


}

    
   

    get formattedPurchases() {
        return this.Purchases.map(Purchase => ({
            PurchaseID: Purchase.Id,
            Name: Purchase.Name,
            SettelmentAmount: Purchase.Credit_Settlement__c,
            date:new Date(Purchase.CreatedDate).toISOString().split('T')[0],
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
