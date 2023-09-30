import { LightningElement, api, wire, track } from 'lwc';
import generatePDF from '@salesforce/apex/PaddyDetailLWCController.generateSupplyBillPDF';
import Logo from '@salesforce/resourceUrl/FortuneLogo';
import getSupplyBillingDetails from '@salesforce/apex/SupplyBillLwcController.getSBDetails';
export default class GenerateSupplyPdf extends LightningElement {

    @api recordId
    FortuneLogoUrl = Logo;
    @track SBDetails={};
    @track CurrentPurchases=[];
    @wire(getSupplyBillingDetails, { recordId: "$recordId"})
    wiredRecord({ error, data }) {
      if (data) {
          console.log('data is'+data);
          if (Array.isArray(data) && data.length > 0) {
          this.SBDetails = JSON.parse(JSON.stringify(data[0]));
          if (Array.isArray(data[0].Paddy_Purchases__r) && data[0].Paddy_Purchases__r.length > 0) {
            this.CurrentPurchases=data[0].Paddy_Purchases__r; 
          }
          if (Array.isArray(data[0].Paddy_Purchases1__r) && data[0].Paddy_Purchases1__r.length > 0) {
            this.CurrentPurchases=[...data[0].Paddy_Purchases1__r]; 
          }
          }

      } else if (error) {
          console.log('An error occurred:', error);
      }
  }

    get TodayDate(){
        var today = new Date();
      var year = today.getFullYear();
      var month = ('0' + (today.getMonth() + 1)).slice(-2);
      var day = ('0' + today.getDate()).slice(-2);
     
     return `${day}-${month}-${year}`;
     }
   /* pdfHandler(){
        let content = this.template.querySelector('.container')
        console.log(content.outerHTML)
        generatePDF({ recordId:this.recordId, htmlData:content.outerHTML}).then(result=>{
            console.log("attachment id", result)
            window.open(`https://grenudcompany--grenud001.sandbox.my.salesforce.com/servlet/servlet.FileDownload?file=${result.Id}`)
        }).catch(error=>{
            console.error(error)
        })
    }*/
    pdfHandler() {
       
        let content = this.template.querySelector('.container');
       
    
        generatePDF({ recordId: this.recordId, htmlData:content.outerHTML }).then(result => {
            console.log("attachment id", result);
            window.open(`https://grenudcompany--grenud001.sandbox.my.salesforce.com/servlet/servlet.FileDownload?file=${result.Id}`)
        }).catch(error => {
            console.error(error);
        });
    }
    
}