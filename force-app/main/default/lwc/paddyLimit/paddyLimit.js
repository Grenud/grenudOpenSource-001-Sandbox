import { LightningElement, api, wire, track } from 'lwc';
import getFarmerRecord from '@salesforce/apex/PaddyDetailLWCController.getFarmerRecord';

export default class GeneratePdf extends LightningElement {
    @api recordId;
    @track FarmerDetails = {};
    progressBarVariant = 'base';

    @wire(getFarmerRecord, { recordId: "$recordId" })
    wiredRecord({ error, data }) {
        if (data) {
            if (Array.isArray(data) && data.length > 0) {
                this.FarmerDetails = JSON.parse(JSON.stringify(data[0]));
                this.updateProgressBarVariant();
            }
        } else if (error) {
            console.log('An error occurred:', error);
        }
    }

    // Getter for barValue
    get barValue() {
        if (this.FarmerDetails && this.FarmerDetails.Paddy_Limit_Qtl__c !== 0) {
            const calculatedValue = (this.FarmerDetails.Received_Paddy_Qtl__c / this.FarmerDetails.Paddy_Limit_Qtl__c) * 100;
            return calculatedValue;
        }
        return 0;
    }

    updateProgressBarVariant() {
        if (this.barValue > 50) {
            this.progressBarVariant = 'destructive'; // Change to your desired color variant
        } else {
            this.progressBarVariant = 'base'; // Change to your desired color variant
        }
    }
}