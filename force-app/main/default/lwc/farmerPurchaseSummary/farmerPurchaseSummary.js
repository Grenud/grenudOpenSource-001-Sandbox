import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { getListUi } from 'lightning/uiListApi';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Credit Settlement', fieldName: 'Credit_Settlement__c', type: 'text' },
    { label: 'Farmer Code', fieldName: 'Farmer_Code__c', type: 'text' },
    { label: 'Paddy Limit (Qtl)', fieldName: 'Paddy_Limit_Qtl__c', type: 'number' },
    { label: 'Pending on Platform (Qtl)', fieldName: 'Pending_On_Platform_Qtl__c', type: 'number' },
    { label: 'Received Paddy (Qtl)', fieldName: 'Received_Paddy_Qtl__c', type: 'number' },
    { label: 'Total Cash Credit', fieldName: 'Total_Cash_Credit__c', type: 'currency' },
    { label: 'Total Farmer Credit', fieldName: 'Total_Farmer_Credit__c', type: 'currency' },
    { label: 'Total Invoice Value', fieldName: 'Total_Invoice_Value__c', type: 'currency' },
    { label: 'Total Kit Area', fieldName: 'Total_Kit_Area__c', type: 'number' },
    { label: 'Total Other Credit', fieldName: 'Total_Other_Credit__c', type: 'currency' },
    { label: 'Total Remaining Balance', fieldName: 'Total_Remaining_Balance__c', type: 'currency' },
    { label: 'Total Seeds Credit', fieldName: 'Total_Seeds_Credit__c', type: 'currency' },
];

export default class AccountPaddyPurchaseList extends LightningElement {
    @api recordId;
    accountName;
    paddyPurchases;
    columns = COLUMNS;

    @wire(getRecord, { recordId: '$recordId', fields: ['Account.Name'] })
    wiredAccount({ data, error }) {
        if (data) {
            this.accountName = getFieldValue(data, 'Account.Name');
        } else if (error) {
            console.error('Error fetching Account Name:', error);
        }
    }

    @wire(getListUi, {
        objectApiName: 'Paddy_Purchase__c',
        listViewApiName: 'All',
        parentRecordId: '$recordId'
    })
    wiredPaddyPurchaseList({ data, error }) {
        if (data) {
            this.paddyPurchases = data.records.records;
        } else if (error) {
            console.error('Error fetching Paddy Purchases:', error);
        }
    }
}