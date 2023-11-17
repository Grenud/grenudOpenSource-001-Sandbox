import { LightningElement, wire, api } from 'lwc';
import getInvoiceCreditData from '@salesforce/apex/InvoiceCreditWrapper.getInvoiceCreditData';
export default class GetFarmerCredsale extends LightningElement {
@api recordId;
    @api type;
    invoiceCreditData;

    @wire(getInvoiceCreditData, { recordId: '$recordId' })
    wiredInvoiceCreditData({ error, data }) {
        if (data) {
            console.log(data);
            this.invoiceCreditData = data;
        } else if (error) {
            // Handle error
        }
    }
    get creditName() {
        return this.invoiceCreditData && this.invoiceCreditData.credit ? this.invoiceCreditData.credit.Name : '';
    }
}