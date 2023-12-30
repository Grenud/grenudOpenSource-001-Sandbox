import { LightningElement, track, wire, api } from 'lwc';
import Logo from '@salesforce/resourceUrl/FortuneLogo';
import ADDICON from '@salesforce/resourceUrl/AddIcon';
import DELETEICON from '@salesforce/resourceUrl/DeleteIcon';
import SALE_INVOICE_OBJECT from '@salesforce/schema/Sale_Invoice__c';
import Product_Item_OBJECT from '@salesforce/schema/Product_Item__c';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo} from 'lightning/uiObjectInfoApi';
import createRecordApex from '@salesforce/apex/CreateINvRecord.createRecord';
  import getRelatedContacts from '@salesforce/apex/createSale.getRelatedContacts';  // Fetch rekated contact
import { getListUi } from 'lightning/uiListApi'; //Account Data without apex
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//const FIELDS = ['Sale_Invoice__c.Party__r.Name', 'Product_Item__c.Product2.Name'];
const ACCOUNT_OBJECT = 'Account';

// Sonu Git Testing

export default class CreateSale extends LightningElement {
  
  @track  showtemp1 = true;
  FortuneLogoUrl = Logo;
  addIcon=ADDICON;
  DeleteIcon=DELETEICON;

  @api InvData ={Account:"", InvNumber:"", Invdate:"", Phone:"", Email:"", Village:"", Block:"", Taishil:"", State:"", District:""}
  UoMValues;

 // PARTY Attributes
   @api iconName = 'standard:account';
   @track searchAccounts = '';
   @track accounts = [];
    @track selectedAccountId;
    @track showAccountResults = false;
     fatherName = '';
     farmerCode = '';
  
  // Wire method to get a list of accounts based on the search term
    @wire(getListUi, { objectApiName: ACCOUNT_OBJECT, listViewApiName: 'AllAccounts' })
    wiredAccounts;
 
 // Handle account search
    handleAccountSearch(event) {
     // alert(this.fatherName);
        this.selectedAccountId = '';    
        this.searchAccounts = '';  
        this.selectedContactId = '';
        this.searchContacts = ''; 
        this.fatherName = '';  
        this.farmerCode = '';  
       // this.selectedAccount = { Id: '', Name: '' }; // Reset selected account
      //  alert(this.fatherName);
       this.contactVillageId = '';
       this.contactVillage = '';
       this.contactEmail = '';
       this.contactBlock = '';
       this.contactTehsil = '';
       this.contactDistrict = '';
       this.contactState = '';
       this.contactPhone = '';
        // Update the button disabled state based on whether an account is selected
        this.isNewContactButtonDisabled = !this.selectedAccountId;

        this.searchAccounts = event.detail.value;
        
        this.showContactResults = false; // Reset contact results when a new account is searched

        if (this.searchAccounts) {


            // Filter accounts based on the search term
            const filteredAccounts = this.wiredAccounts.data.records.records.filter(account =>
                account.fields.Name.value.toLowerCase().includes(this.searchAccounts.toLowerCase())
           );
           // alert(filteredAccounts);
            this.accounts = filteredAccounts;
            //        alert(this.accounts);

            this.showAccountResults = true;
        } else {
            this.accounts = [];
            this.showAccountResults = false;
        }
    }

 // Handle account selection
handleAccountSelection(event) {
    // Extract the selected account details from the event
    const selectedAccount = this.accounts.find(account => account.fields.Id.value === event.target.dataset.value);

    if (selectedAccount) {
        this.selectedAccountId = selectedAccount.fields.Id.value;
        this.searchAccounts = selectedAccount.fields.Name.value;
        this.fatherName = selectedAccount.fields.Father_Name__c.value;
        this.farmerCode = selectedAccount.fields.Farmer_Code__c.value;
        this.showAccountResults = false; // Hide account results after selection
        this.isNewContactButtonDisabled = !this.selectedAccountId;// Enable New contact Button
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //Contacts

      @track contacts = [];
      @track searchContacts = '';
      @track selectedContactId;
      @track messageResult = false;
      @track showContactResults = false;

      @track contactVillageId;

      //Fields attributes
      contactEmail = '';
      contactPhone = '';
      contactVillage = '';
      contactBlock = '';
      contactTehsil = '';
      contactDistrict = '';
      contactState = '';

  handleContactSearch(event) {
          this.selectedContactId = '';
          this.searchContacts = ''; 
          this.isNewContactButtonDisabled = false;

        this.contactVillageId = '';
        this.contactVillage = '';
        this.contactEmail = '';
        this.contactBlock = '';
        this.contactTehsil = '';
        this.contactDistrict = '';
        this.contactState = '';
        this.contactPhone = '';

          this.searchContacts = event.detail.value;
          
          // You can perform additional actions when the contact is selected
        const actId = this.selectedAccountId;
      //  alert(actId);
  if (this.searchContacts && actId) {
          getRelatedContacts({actName: this.searchContacts, accountId: actId})

              .then(result => {
                  this.contacts = result;
                // alert(this.contacts);
                  this.showContactResults = true;
                //  this.messageResult = data.length === 0 && this.accountName !== '';
                //  alert(this.JSON.stringify(contacts));
                  
              })
              .catch(error => {
                      console.error(error);
                      this.contacts = [];
                      this.showContactResults = false; 
                      });

                      } else {
              this.contacts = [];
              this.showContactResults = false;
          }
      }

      handleContactSelection(event) {
          this.searchContacts = event.target.dataset.label;
          this.selectedContactId = event.target.dataset.value;
          this.showContactResults = false;
          this.isNewContactButtonDisabled = true;
        //  this.contactVillage = this.selectedContactId.Village_Name__c;

      // const selectedContact = this.contacts.find(contact => contact.fields.Id.value === event.target.dataset.value);
        const selectedContact = this.contacts.find(contact => contact.Id === this.selectedContactId);


      if (selectedContact) {
        this.contactVillageId = selectedContact.Village__c;
        this.contactVillage = selectedContact.Village_Name__c;
        this.contactEmail = selectedContact.Email;
        this.contactBlock = selectedContact.Block__c;
        this.contactTehsil = selectedContact.Tehsil__c;
        this.contactDistrict = selectedContact.District__c;
        this.contactState = selectedContact.State__c;
        this.contactPhone = selectedContact.Phone;
      }

          
      }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //NEW CONTACT BUTTON
  isNewContactButtonDisabled = true;
  @track modalPopupContact = false;

  //Open modalPopupContact
      handleNewContact(event){
              this.modalPopupContact=true;  
              //  this.dispatchEvent(new CustomEvent('openmodal'));     
    }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //NEW CONTACT FORM METHODS:

  // Populate Selected Account Id from account lookup to New Contact Record edit formLookup
  renderedCallback() {
          const inputFields = this.template.querySelectorAll(
              'lightning-input-field'
          );
          if (inputFields) {
              inputFields.forEach(field => {
                  if(field.fieldName == 'AccountId')
                      field.value = this.selectedAccountId;
                  if(field.fieldName == 'Village__c')
                      field.value = this.contactVillageId;
              });
          }
      }

      handleContactSubmit(event){
         // event.preventDefault();       // stop the form from submitting
          const fields = event.detail.fields;
          this.template.querySelector('lightning-record-edit-form').submit(fields);
         // this.modalPopupContact = false;
      }

    handleContactSuccess(event) {
    // Check if the Contact record is created successfully
    if (event.detail.id) {
        const contactId = event.detail.id;

        // Fetch the newly created Contact record to get the details
        // You may need to update this call based on your actual use case
        getContactDetails({ contactId: contactId })
            .then(result => {
                // Populate the fields in your LWC component
                this.contactVillageId = result.Village__c;
                this.contactVillage = result.Village_Name__c;
                this.contactEmail = result.Email;
                this.contactBlock = result.Block__c;
                this.contactTehsil = result.Tehsil__c;
                this.contactDistrict = result.District__c;
                this.contactState = result.State__c;
                this.contactPhone = result.Phone;
                
                // Close the modal
                this.modalPopupContact = false;
                
                // Show a success message
                const toastEvent = new ShowToastEvent({
                    title: 'Success!',
                    message: 'The Contact record has been successfully saved.',
                    variant: 'success',
                });
                this.dispatchEvent(toastEvent);
            })
            .catch(error => {
                console.error('Error fetching Contact details:', error);
                // Handle error if needed
            });
    }
}

    //Close modalPopupContact  
    closeContactModal(){
      this.modalPopupContact = false;
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




  @track productName;
  @track quantity;
  @track unitPrice;
  @track description;
  @api recordId;
  @track selectedAccount;
  
 @track Totalprice=0;
 @track DiscountPrice=0;
 selectedAccountId;


selectedTransaction = '';
selectedPayment = '';
    
    picklistTransaction = [
        { label: 'Sale', value: 'Sale' },
        { label: 'Purchase', value: 'Purchase' }
    ];

        picklistPayment = [
        { label: 'Cash', value: 'Cash' },
        
        { label: 'Cheque', value: 'Cheque' }
    ];


 handleTransactionChange(event) {
        this.selectedTransaction = event.detail.value;
    }

 handlePaymentChange(event) {
        this.selectedPayment = event.detail.value;
    }





   // Method to store selected clientfarmer ID and display Father Name and Code on UI. 
/*   handleAccountSelection(event) {
        this.InvData.Account = event.detail.value;
        
                this.selectedAccountId = event.detail.value;
                //handleSearchParty();
//alert(this.selectedAccountId);
          getClientFarmerList({ selAccId: this.selectedAccountId })
            .then(result => {
              console.log('Inside .then() block');
              console.log('Result:', result);
              alert('Result aaaya');
                this.clientFarmerData = result;
                alert(this.clientFarmerData);
                this.fatherName = result[0].Father_Name__c;
                this.farmerCode = result[0].Farmer_Code__c;
                alert(this.fatherName);
            })
            .catch(error => {
               console.error('Inside .catch() block');
        console.error('Error:', error);
                // Handle the error
            })

            //     alert('handle serch chala');
              //   alert(this.selectedAccountId);

    }*/

  


    



 get formattedTotal() {
  return this.Totalprice.toFixed(2);
}
get formattedDiscount() {
  return this.DiscountPrice.toFixed(2);
}
 nextId = 1;
  @track rows = [
    {index: 0, id:this.nextId, SrNo:1, item: '', description: '',  quantity: 0, UoM: '',  rate: 0, Discount: 0 ,DiscountPrice: 0, Total: 0   }
];
  selectedState = '';
  selectedDistrict = '';
  StateOptions = [];
  DistrictOptions = [];
  isDistrictDisabled = true;

 /* @wire(getStateDistrictPicklist)
  StateDistrictMapping({data, error}) {
      if(data) {
          this.StateOptions = data.map(item => {
              return {label: item.State__c, value: item.State__c};
          });
      } else if(error) {
          console.error('Error retrieving State and District values:', error);
      }
  }

 handleStateChange(event) {
      this.selectedState = event.detail.value;
      this.selectedDistrict = '';
      this.isDistrictDisabled = true;
      if(this.selectedState) {
        const stateDistrictData = this.StateDistrictMapping.data;
        const districtData = stateDistrictData.find(item => item.State__c === this.selectedState);
        if (districtData) {
         // this.DistrictOptions = districtData.District__c.map(item => {
          //  return { label: item, value: item };
            //this.DistrictOptions = districtData.District__c.split(';').map(item => {
            //  return { label: item, value: item };
            //});
            console.log(districtData);
            this.isDistrictDisabled = false;
        }
          //this.DistrictOptions = this.StateDistrictMapping.data.find(item => item.State__c === this.selectedState).District__c.split(';').map(item => {
          //    return {label: item, value: item};
         // });
        //  this.isDistrictDisabled = false;
      }
  }   */

  ratehandler(event) {
  
            const itemId = event.target.dataset.id;
            console.log(itemId);
            const row = this.rows.find(row => row.id == itemId);
            row.rate = event.target.value;
            if (row.rate === undefined || row.rate === null || row.rate == 0) {
              row.Total = 0;
              row.DiscountPrice=0;
            }
            else{
              row.Total = (row.quantity * row.rate -row.DiscountPrice)//.toFixed(2);
              row.DiscountPrice = (row.quantity * row.rate * row.Discount / 100)//.toFixed(2);
            }
           
            //this.Totalprice=this.Totalprice+row.Total;
            //this.DiscountPrice=this.DiscountPrice+row.DiscountPrice;
  }

  quantityhandler(event) {
  
           const itemId = event.target.dataset.id;
            const row = this.rows.find(row => row.id == itemId);
            row.quantity = event.target.value;
            row.DiscountPrice = (row.quantity * row.rate * row.Discount / 100)//.toFixed(2);
            row.Total = (row.quantity * row.rate-row.DiscountPrice)//.toFixed(2);
           // this.Totalprice=this.Totalprice+row.Total;
           // this.DiscountPrice=this.DiscountPrice+row.DiscountPrice;

}
BlurHandler(){
  this.Totalprice = this.rows.reduce((acc, curr) => acc + curr.Total, 0);
  this.DiscountPrice = this.rows.reduce((acc, curr) => acc + curr.DiscountPrice, 0);
 
}

discounthandler(event)
{
   
    const itemId = event.target.dataset.id;
    const row = this.rows.find(row => row.id == itemId);
    row.Discount = event.target.value;
    console.log(row.Discount);
    row.DiscountPrice = (row.quantity * row.rate * row.Discount / 100)//.toFixed(2);
    console.log(row.DiscountPrice);
    row.Total=(row.quantity * row.rate-row.DiscountPrice)//.toFixed(2);
    
    //this.Totalprice=this.Totalprice+row.Total;
          //  this.DiscountPrice=this.DiscountPrice+row.DiscountPrice;
}


//@wire(getObjectInfo, { objectApiName: CONTACT_OBJECT })
   // contactObjectInfo;


 /*       
        HandleFocus(){
            if(this.InvData.Party==""){ 
                    alert("Please Select Party First");
            }
        }
        InvChnageHandler(event){
          this.InvData.InvNumber=event.target.value;
        }
       // ContacChangetHandler(event){
        //   this.InvData.Contact=event.target.value;
      // }

        InvDateHandler(event){
          this.InvData.Invdate=event.target.value;
        }
        PhoneChangeHandler(event){
          this.InvData.Phone=event.target.value;
        }
        EmailChangeHandler(event){
         this.InvData.Email=event.target.value;
        }
        VillageHandler(event){
          this.InvData.Village=event.target.value;
        }
        BlockHandler(event){
          this.InvData.Block=event.target.value;
        }
        taisilHanlder(event){
          this.InvData.Taishil=event.target.value;
        }
        DistrictHandler(event){
         this.InvData.District=event.target.value;
        }
      
@wire(getObjectInfo, { objectApiName: SALE_INVOICE_OBJECT })
    SaleInvoiceInfo;

    @wire(getPicklistValues,
        {
            recordTypeId: '$SaleInvoiceInfo.data.defaultRecordTypeId',
            fieldApiName: DISTRICT_FIELD
        }
    )
    DistrictValues;
  

    @wire(getPicklistValues,
        {
            recordTypeId: '$SaleInvoiceInfo.data.defaultRecordTypeId',
            fieldApiName: STATE_FIELD
        }
    )
    StateValues;
*/
    @wire(getObjectInfo, { objectApiName: Product_Item_OBJECT })
    ProductItemInfo;

    @wire(getPicklistValues, { recordTypeId: '$ProductItemInfo.data.defaultRecordTypeId', fieldApiName: UoM_FIELD })
uomPicklistValues({ error, data }) {
  if (data) {
    this.UoMValues = data.values.map((option) => {
      return {
        label: option.label,
        value: option.value,
      };
    });
  } else if (error) {
    console.error('Error retrieving UoM picklist values:', error);
  }
}

  handleAddLineItem() {
    let table = this.template.querySelector('table');
    
    this.Quantity=0;
    this.Unitrate=0;
     this.Discount=0;
    
    let rowNumber = table.rows.length;
    this.nextId++;
    this.rows.push({ SrNo:rowNumber, id:this.nextId,item: '', description: '',  quantity: 0, UoM: '',  rate: 0, Discount: 0,DiscountPrice: 0, Total: 0 });
    
  } 

  //State and district picklist using hardcoded values.

/*
  stateVSdistrict = { 
    "Uttar Pradesh" : [{value: 'Aligarh', label: 'Aligarh'}, {value: 'Bulandsahar', label: 'Bulandsahar'} ],
    "Madhya Pradesh" : [{value: 'Raisen', label: 'Raisen'}, {value: 'Bhopal', label: 'Bhopal'}]
}

DistrictValues = [
    { value: 'Aligarh', label: 'Aligarh', description: 'A new item' },
    {
        value: 'Raisen',
        label: 'Raisen'
        
    }
];

value = 'new';


userInput ;
filertoption;
 handleInvoiceBlur = (event)=> {
 
 this.userInput = event.target.value;
 this.InvData.State=event.target.value;
    console.log(this.userInput);

    //this.filertoption = stateVSdistrict["Uttar Pradesh"];
    //this.filertoption = this.stateVSdistrict['"' + this.userInput + '"'];
     this.filertoption = this.stateVSdistrict[this.userInput ];
    console.log(this.filertoption);   
}
*/

DeleteHandler(event){
  const itemId = event.target.dataset.id;
  console.log('itemId@@@'+itemId);
  const elementToRemove = this.rows.find(row => row.id == itemId);
  console.log( 'elementToRemove@@'+elementToRemove);
  var OldRows=[...this.rows]
  console.log(OldRows);
  this.rows = OldRows.filter(item => item !== elementToRemove);
  console.log( this.rows);
}

handleSubmit(){
  const jsonString = JSON.stringify(this.InvData);
  const JsonStr=JSON.stringify(this.rows);
  //const RowData=this.rows;
  console.log("Items@@"+JsonStr);
  console.log(jsonString);
  var parentId;
  createRecordApex({ jsonString , JsonStr})
            .then(result => {
                // Record creation successful
                console.log('Record created with ID'+result);
                parentId=result;
                // Handle success or perform any additional operations
                //return createChildRecord({RowData, parentId })
            })
            
   //const Items = JSON.stringify(this.rows);
  
  //.then(result2 => {
    // Record creation successful
    //console.log('Child created with ID');
    
    // Handle success or perform any additional operations
//})
.catch(error => {
    // Record creation failed
    console.error('Error creating child record:', error);
    // Handle error or display error message
});
}
}