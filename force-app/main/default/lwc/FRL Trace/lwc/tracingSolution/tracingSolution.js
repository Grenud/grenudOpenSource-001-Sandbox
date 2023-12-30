import { LightningElement, wire, track } from 'lwc';
import getSupply from '@salesforce/apex/tracingDTController.getSupply';

const columns = [
    { label: 'Invoice No', fieldName: 'Invoice_No__c', type: 'number' },
    { label: 'Client Farmer Name', fieldName: 'Farmer_Name__c', type: 'text' },
    // { label: 'General Farmer Name', fieldName: 'General_Farmer__c', type: 'text' },
    { label: 'Paddy Type', fieldName: 'Paddy_Type__c', type: 'text' },
    { label: 'Village', fieldName: 'Village__c', type: 'text' },
];

export default class TracingSolution extends LightningElement {
    columns = columns;
    data;
    error;

    @wire(getSupply, { supplyName: '$supplyName' })
    wiredSupply({ error, data }) {
        if (data) {
            // Extracting the nested records and flattening the structure
            const flattenedData = data.reduce((acc, record) => {
                const nestedRecords = record.Paddy_Purchases__r;
                if (nestedRecords && nestedRecords.length > 0) {
                    nestedRecords.forEach(nestedRecord => {
                        acc.push({
                            ...nestedRecord,
                            Invoice_No__c: record.Invoice_No__c, // Include fields from the main record
                        });
                    });
                }
                return acc;
            }, []);

            this.data = flattenedData;
            this.error = undefined;
        } else if (error) {
            this.data = undefined;
            this.error = error;
        }
    }

    // Declaring a property to store the value entered by the user
    @track supplyName = '';

    // Event handler for input change
    handleInputChange(event) {
        // Updating the supplyName property with the entered value
        this.supplyName = event.target.value;
    }

    // Event handler for button click
    getSupply() {
        // Calling the Apex method and passing the supplyName property
        getSupply({ supplyName: this.supplyName })
            .then(result => {
                // Handle the result as needed
                console.log(result);
                // Note: If needed, you can set this.data here to update the datatable immediately.
            })
            .catch(error => {
                // Handle the error
                console.error('Error calling Apex method:', error);
            });
    }
}

