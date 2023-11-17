import { LightningElement, track, wire, api } from 'lwc';

import getClientFarmerList from '@salesforce/apex/FAUP_Sampling_Component.getClientFarmerList';
import getFarmList from '@salesforce/apex/FAUP_Sampling_Component.getFarmList';

import createSampleRecords from '@salesforce/apex/FAUP_Sampling_Component.createSampleRecords';
import updateSelectedFarms from '@salesforce/apex/FAUP_Sampling_Component.updateSelectedFarms';

import createClientFrmSamples from '@salesforce/apex/FAUP_Sampling_Component.createClientFrmSamples';
import updateClientFarmerAllFarms from '@salesforce/apex/FAUP_Sampling_Component.updateClientFarmerAllFarms';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//import getLOT from '@salesforce/apex/FAUP_Sampling_Component.getLOT';
import { CloseActionScreenEvent } from 'lightning/actions';
//import { NavigationMixin } from 'lightning/navigation';




// Columns for Client Farmer
const CLIENTFARMER_COLUMNS = [
    { label: 'Client Farmer', fieldName: 'Name', initialWidth: 220 },
    { label: 'Phone', fieldName: 'Phone', initialWidth: 120 },
    { label: 'Father Name', fieldName: 'Father_Name__c', initialWidth: 150 },
    { label: 'Village', fieldName: 'Village__c', initialWidth: 140 },
    { label: 'Suspect', fieldName: 'Suspect__c', type: 'Boolean', initialWidth: 100 },

    // Add button view farms.
    {
        label: 'View Farms',
        type: 'button-icon',
        initialWidth: 100,
        typeAttributes: { iconName: 'action:preview', label: 'View farm', name: 'view_farms', title: 'View Farms' },
    },
];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Columns for Farms.
const FARM_COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Plot Size', fieldName: 'Plot_Size__c' },
    { label: 'Plot Type', fieldName: 'Plot_Type__c' },
    { label: 'Sample Collect', fieldName: 'UP_Sample_Collect__c' },

];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export default class FAUP_Sampling extends LightningElement {

    //ATTRIBUTES

    @track villageName = '';

    @api recordId; // Lot record Id
    // @track fieldOfficerId;
    
    @track selectedData = [];
     @track clientFarmerId;


    @track showModal = false;
    @track showclientFarmer = true;
   
    @track lastSearchValue = '';

//Spinner
 @track isLoading = false;
 
   //CLIENT FARMER ATTRIBUTES
     clientFarmerData = [];
    @track clientFarmerColumns = CLIENTFARMER_COLUMNS; 

    @track currSelectClientFarmerSampleCreate = [] // Store Ids  of selected client farmer checkbox checked to create sample.
  //  @track currSelectClientFrmerUpdateFarms = []; // Store Ids  of selected client farmer checkbox checked to updated farms.
    @track samplesAllClientFarmers = []; //store  all sample records for updating their client farmers related farmers.

   //FARMS
    @track farmsData = [];
    @track farmsColumns = FARM_COLUMNS; 

    @track selectedClientfarmer = {};
    @track selectedRows = [];
    @track currentSelectedUpdateFarm = [];
    @track currentSelectedFarmSample = [];
    @track sampleId;
   

    //Pagination attributes
    pageSizeOptions = [5, 10, 25, 50, 75, 100]; //Page size options
    totalRecords = 0; //Total no.of records
    pageSize; //No.of records to be displayed per page
    totalPages; //Total no.of pages
    pageNumber = 1; //Page number    
    recordsToDisplay = []; //Records to be displayed on the page

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* refreshDataWithLastSearch() {
    this.villageName = this.lastSearchValue; // Use the last searched value
    this.clientFarmerData = [];
    this.farmsData = [];
    alert('villageName'+this.villageName);
     //   alert('clientFarmerData'+JSON.stringify(this.villageName));

    this.isLoading = true; // Set loading state to true
 //this.handleSearch({ target: { value: this.villageName } });
    // Fetch data from Salesforce
    getClientFarmerList({ searchVillage: this.villageName })
            .then(result => {
                this.clientFarmerData = result;
                this.totalRecords = result.length; // update total records count                 
                this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
                this.paginationHelper(); // call helper menthod to update pagination logic 
            })
            .catch(error => {
                // Handle the error
            })
            .finally(() => {
            this.isLoading = false; // Clear loading state
        });

           alert('clientFarmerData Update: '+JSON.stringify(this.clientFarmerData));


            

    }*/
    //Search Villages method
    handleSearch(event) {
        this.villageName = event.target.value;
        this.lastSearchValue = this.villageName;
        this.isLoading = true;

        getClientFarmerList({ searchVillage: this.villageName })
            .then(result => {
                this.clientFarmerData = result;
                this.totalRecords = result.length; // update total records count                 
                this.pageSize = this.pageSizeOptions[0]; //set pageSize with default value as first option
                this.paginationHelper(); // call helper menthod to update pagination logic 
            })
            .catch(error => {
                // Handle the error
            })
            .finally(() => {
            this.isLoading = false; // Clear loading state
        });


            

    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    /* @wire(getLOT, { LotId: '$recordId' })
        wiredContacts({ data, error }) {
            if (data) {
                this.fieldOfficerId = data[0].UP_Field_Officer__c;
                alert(this.fieldOfficerId);
            } else if (error) {
                // Handle the error, e.g., display an error message
            }
        }
    
    
    
    // Method to get all client farmers of selected village from list.
       @wire(getClientFarmerList, { FieldOfficeId:'$fieldOfficerId'})
        wiredAccounts({ error, data }) {
                alert(this.fieldOfficerId);
    
            if (data) {
                this.clientFarmerData = data;
           } else if (error) {
                console.error(error);
            }
        }*/
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
// Handle client farmer datatable checkbox selection (Select all, select individual,Deselect all, deselect individual)
handleRowSelectionFarmers(event) {
    const selectedRows = event.detail.selectedRows;
                   // window.alert('selectedRows' + JSON.stringify(selectedRows));

    const selectedIds = new Set(selectedRows.map(record => record.Id));
   // window.alert('sample' + JSON.stringify(this.currSelectClientFarmerSampleCreate));

    // Find records to be deselected and remove them from the array
    this.currSelectClientFarmerSampleCreate = this.currSelectClientFarmerSampleCreate.filter(record => selectedIds.has(record.Id));

for (let i = 0; i < selectedRows.length; i++) {
            const selectedRecord = selectedRows[i];

            // Check if the record is already in currSelectClientFarmerSampleCreate and currSelectClientFrmerUpdateFarms.
            const isDuplicateFarms = this.currSelectClientFarmerSampleCreate.some(record => record.Id === selectedRecord.Id);
           // const isDuplicateSample = this.currSelectClientFrmerUpdateFarms.some(record => record.Id === selectedRecord.Id);

            // If it's not a duplicate,  add it to the array
            if (!isDuplicateFarms) {
                this.currSelectClientFarmerSampleCreate.push(selectedRecord);
              //  this.currSelectClientFrmerUpdateFarms.push(selectedRecord);
            }
        }

             //   window.alert('sample1' + JSON.stringify(this.currSelectClientFarmerSampleCreate));

}
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    //Method to create samples for all selected  client Farmers .
    createClientFarmerSample() {
        this.isLoading = true;
          //   window.alert(JSON.stringify(this.currSelectClientFarmerSampleCreate));
        if (this.currSelectClientFarmerSampleCreate.length > 0) {

            // window.alert(this.currSelectClientFarmerSampleCreate.length);

            // Call the server-side Apex method to update the selected records
            createClientFrmSamples({ SelectedFarmersIds: this.currSelectClientFarmerSampleCreate, LotId: this.recordId })
                .then(result => {
              
                this.samplesAllClientFarmers = result;
                  //   window.alert('sampleIds: ' + this.samplesAllClientFarmers);
                    this.updateClientFarmersRealtedFarms();
                })
                .catch(error => { console.error(error); 
                
                
                })
                .finally(() => {
                 this.isLoading = false; // Clear loading state
        });
        }

        this.currSelectClientFarmerSampleCreate = [];
        
       // window.alert(JSON.stringify(this.currSelectClientFarmerSampleCreate));   

    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// UPDATE SELECTED CLIENT FARMER ALL RELATED FARMS
    updateClientFarmersRealtedFarms() {
         //  window.alert('sampleId '+this.samplesAllClientFarmers);
        if (this.samplesAllClientFarmers.length > 0) {

            updateClientFarmerAllFarms({ LotId: this.recordId, SampleRecords: this.samplesAllClientFarmers})
                .then(result => {
                  const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Client farmer sample created and farms updated successfully.',
                    variant: 'success',
                });
                this.dispatchEvent(evt);
                                       this.refreshDataWithLastSearch(); 
 
                 })
                .catch(error => {
                    //  console.error(error);
                   
                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while creating client farmer samples and update farms.',
                    variant: 'error',
                });
                this.dispatchEvent(evt);

                });
        }
     //   this.currSelectClientFrmerUpdateFarms = [];
        this.samplesAllClientFarmers = [];
      //  window.alert(JSON.stringify(this.currSelectClientFrmerUpdateFarms));

    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Handle client farmer row action.
    handleRowAction(event) {

        // Store Id of selected client farmer when view farm button is clecked..
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'view_farms') {
            this.selectedClientfarmer = row;
            this.clientFarmerId = this.selectedClientfarmer.Id;
            this.showModal = true;
            this.showclientFarmer = false;
            
            this.loadFarms(row.Id);
            // Clear any previously selected checkboxes
            this.currSelectClientFarmerSampleCreate = [];
           // this.currSelectClientFrmerUpdateFarms = [];
        }
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  


    // Method to get all farms of selected client farmer Id.
    loadFarms() {
        this.isLoading = true;
        getFarmList({ clientfarmId: this.clientFarmerId })
            .then(result => {
                this.farmsData = result;
            })
            .catch(error => {
                console.error(error);
            })
            .finally(() => {
            this.isLoading = false; // Clear loading state
        });
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Method to select farms and store in array currentSelectedFarmSample, currentSelectedUpdateFarm
    handleRowSelection(event) {
    const selectedRows = event.detail.selectedRows;
    const selectedIds = new Set(selectedRows.map(record => record.Id));
    

    // Find records to be deselected and remove them from the array
    this.currentSelectedFarmSample = this.currentSelectedFarmSample.filter(record => selectedIds.has(record.Id));
    this.currentSelectedUpdateFarm = this.currentSelectedUpdateFarm.filter(record => selectedIds.has(record.Id));
       
        for (let i = 0; i < selectedRows.length; i++) {
            const selectedRecord = selectedRows[i];
            // Check if the record is already in currentSelectedFarmSample
            const isDuplicate = this.currentSelectedFarmSample.some(record => record.Id === selectedRecord.Id);
            // If it's not a duplicate,  add it to the array
            if (!isDuplicate) {

                this.currentSelectedFarmSample.push(selectedRecord);
                this.currentSelectedUpdateFarm.push(selectedRecord);
            }
                   
                  // window.alert(JSON.stringify(this.currentSelectedUpdateFarm));   


        }
       // window.alert('sample'+JSON.stringify(this.currentSelectedFarmSample));   
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //Method to create samples for selected farms.
    createSample() {
         this.isLoading = true;
        //     window.alert(JSON.stringify(this.currentSelectedFarmSample));
        if (this.currentSelectedFarmSample.length > 0) {

            // window.alert(this.currentSelectedFarmSample.length);

            // Call the server-side Apex method to update the selected records
            createSampleRecords({ selectedFarms: this.currentSelectedFarmSample, LotId: this.recordId })
                .then(result => {
                this.sampleId = result;
                    // window.alert('sampleId: ' + this.sampleId);
                    this.updateFarms();

                })
                .catch(error => { console.error(error); })
                .finally(() => {
            this.isLoading = false; // Clear loading state
        });
        }

        this.currentSelectedFarmSample = [];
        //window.alert(JSON.stringify(this.currentSelectedFarmSample));   

    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // Method to update selected farms.
    updateFarms() {
        //   window.alert('sampleId '+this.sampleId );
        //    window.alert(JSON.stringify(this.currentSelectedUpdateFarm));
        if (this.currentSelectedUpdateFarm.length > 0) {

          //  window.alert(this.currentSelectedUpdateFarm.length);
            updateSelectedFarms({ SelectedFarmsData: this.currentSelectedUpdateFarm, LotId: this.recordId, SampleId: this.sampleId })
                .then(result => {
                  const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'Client farmer sample created and farms updated successfully.',
                    variant: 'success',
                });
                this.dispatchEvent(evt);
                this.handleSearch({ target: { value: this.lastSearchValue } }); 
                    // this.farmsData = result;
                })
                .catch(error => {
                    //  console.error(error);
                   
                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while creating client farmer samples and update farms.',
                    variant: 'error',
                });
                this.dispatchEvent(evt);

                });
        }
        this.currentSelectedUpdateFarm = [];
        //window.alert(JSON.stringify(this.currentSelectedUpdateFarm));
        this.showModal = false;
        this.showclientFarmer = true;
    }




    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Close Farms Popup
    closeModal() {
        this.showModal = false;
        this.showclientFarmer = true;
        this.contacts = [];
        this.selectedAadhati = {};
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Close Client farmer popup
    closeComponent() {
        //this.dispatchEvent(new CloseActionScreenEvent());

        const closeAction = new CloseActionScreenEvent();
        this.dispatchEvent(closeAction);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

    // Set data table height
    get setDatatableHeight() {
        if (this.count == 0) {//set the minimum height
            return 'height:2rem;';
        }
        else if (this.count > 5) {//set the max height
            return 'height:2rem;';
        }
        return '';//don't set any height (height will be dynamic)
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Pagination 


    //Disable First Button
    get bDisableFirst() {
        return this.pageNumber == 1;
    }

    //Disable Last Button
    get bDisableLast() {
        return this.pageNumber == this.totalPages;
    }

    handleRecordsPerPage(event) {
        this.pageSize = event.target.value;
        this.paginationHelper();
    }

    previousPage() {
        this.pageNumber = this.pageNumber - 1;
        this.paginationHelper();
    }

    nextPage() {
        this.pageNumber = this.pageNumber + 1;
        this.paginationHelper();
    }

    firstPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }

    lastPage() {
        this.pageNumber = this.totalPages;
        this.paginationHelper();
    }



    // JS function to handel pagination logic 
    paginationHelper() {
                alert('pageclientFarmerData : '+JSON.stringify(this.clientFarmerData));

        this.recordsToDisplay = [];
         alert(' recordsToDisplay: '+JSON.stringify(this.recordsToDisplay));
        // calculate total pages
        this.totalPages = Math.ceil(this.totalRecords / this.pageSize);
        // set page number 
        if (this.pageNumber <= 1) {
            this.pageNumber = 1;
        } else if (this.pageNumber >= this.totalPages) {
            this.pageNumber = this.totalPages;
        }
        // set records to display on current page 
        for (let i = (this.pageNumber - 1) * this.pageSize; i < this.pageNumber * this.pageSize; i++) {
            if (i === this.totalRecords) {
                break;
            }
            this.recordsToDisplay.push(this.clientFarmerData[i]);
        }
                        alert('page recordsToDisplay: '+JSON.stringify(this.recordsToDisplay));

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}