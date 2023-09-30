import { LightningElement, api, wire, track } from 'lwc';
import Logo from '@salesforce/resourceUrl/FortuneLogo';
import generatePDF from '@salesforce/apex/PaddyPurchasePdfController.generatePDF'
import getFarmerRecord from '@salesforce/apex/PaddyDetailLWCController.getFarmerPurchaseDetails';
export default class GenerateFarmerPurchasePdf extends LightningElement {

    @api recordId
    ClientFarmerId;
    @track PurchaseDetails={};
    IsFarmer=false;
    settelmentRecords=[];
    invoiceData=[];
    isLoad=true;
    CurrentPurchase={};
    CurrentPurchase1=[];
    CreditCount=0;
    record='a0B0T000003fqLDUAY';
    todayDate='';
    FortuneLogoUrl = Logo;
     @wire(getFarmerRecord, { recordId: "$recordId"})
      wiredRecord({ error, data }) {
        if (data) {
            console.log('data is'+data);
            if (Array.isArray(data) && data.length > 0) {
            this.PurchaseDetails = JSON.parse(JSON.stringify(data[0]));
            this.CurrentPurchase1=data[0].Paddy_Purchases__r;
            if (Array.isArray(this.CurrentPurchase1) && this.CurrentPurchase1.length > 0) {
                this.CurrentPurchase = JSON.parse(JSON.stringify(this.CurrentPurchase1[0]));
                console.log(this.PurchaseDetails);
                console.log(this.CurrentPurchase);
            }
            }

        } else if (error) {
            console.log('An error occurred:', error);
        }
    }
    /*get PurchaseNo() {
        return this.CurrentPurchase[0].Name;
    }*/
    
    get TodayDate(){
        var today = new Date();
      var year = today.getFullYear();
      var month = ('0' + (today.getMonth() + 1)).slice(-2);
      var day = ('0' + today.getDate()).slice(-2);
     
     return `${day}-${month}-${year}`;
     }
     get PurchaseDate() {
        var Pdate = this.CurrentPurchase.Date__c;
    
        if (typeof Pdate === 'string' && Pdate.length > 0) {
            const dateParts = Pdate.split("-");
            if (dateParts.length === 3) {
                const formattedDate = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`;
                return formattedDate;
            }
        }
    
        return '';
    }
    
    
     get amountInWords() {
        const n = this.CurrentPurchase.Grand_Total__c;
        if (n < 0) {
            return false;
        }
    
        if (n === 0) {
            return 'Zero';
        }
    
        return this.convertToWords(n).trim() + ' Rupees Only.';
    }
    
    convertToWords(n) {
        const single_digit = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'];
        const double_digit = ['Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'];
        const below_hundred = ['Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];
    
        let word = "";
    
        if (n < 10) {
            word += single_digit[n] + ' ';
        }
        else if (n < 20) {
            word += double_digit[n - 10] + ' ';
        }
        else if (n < 100) {
            const tensDigit = Math.floor(n / 10) - 2;
            const onesDigit = n % 10;
    
            word += below_hundred[tensDigit] + ' ';
    
            if (onesDigit > 0) {
                word += single_digit[onesDigit] + ' ';
            }
        }
        else if (n < 1000) {
            word += single_digit[Math.floor(n / 100)] + ' Hundred ';
    
            const remainingDigits = n % 100;
    
            if (remainingDigits > 0) {
                word += 'and ' + this.convertToWords(remainingDigits);
            }
        }
        else if (n < 100000) { // Handle values up to one lakh
            const thousands = Math.floor(n / 1000);
            const remaining = n % 1000;
    
            if (thousands === 1) {
                word += 'One Thousand ';
            } else if (thousands > 1) {
                word += this.convertToWords(thousands) + ' Thousand ';
            }
    
            if (remaining > 0) {
                word += this.convertToWords(remaining);
            }
        }
        else if (n < 1000000) { // Handle values up to 9 lakh
            const lakhs = Math.floor(n / 100000);
            const remaining = n % 100000;
    
            if (lakhs === 1) {
                word += 'One Lakh ';
            } else if (lakhs > 1) {
                word += this.convertToWords(lakhs) + ' Lakhs ';
            }
    
            if (remaining > 0) {
                word += this.convertToWords(remaining);
            }
        }
    
        return word.trim();
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
        let content = this.template.querySelector('.container1');
        console.log(content.outerHTML)
        
        generatePDF({ recordId:this.recordId, htmlData:content.outerHTML}).then(result=>{
            console.log("attachment id", result)
            window.open(`https://grenudcompany--grenud001.sandbox.my.salesforce.com/servlet/servlet.FileDownload?file=${result.Id}`)
        }).catch(error=>{
            console.error(error)
        })
    }
    
}