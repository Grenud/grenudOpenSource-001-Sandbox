import { LightningElement, track, wire, api } from 'lwc';
import Logo from '@salesforce/resourceUrl/FortuneLogo';
import ADDICON from '@salesforce/resourceUrl/AddIcon';
import DELETEICON from '@salesforce/resourceUrl/DeleteIcon';
import SALE_INVOICE_OBJECT from '@salesforce/schema/Sale_Invoice__c';
import Product_Item_OBJECT from '@salesforce/schema/Product_Item__c';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import DISTRICT_FIELD from '@salesforce/schema/Sale_Invoice__c.District__c';
import UoM_FIELD from '@salesforce/schema/Product_Item__c.UoM__c';
import STATE_FIELD from '@salesforce/schema/Sale_Invoice__c.State__c';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import createRecordApex from '@salesforce/apex/CreateINvRecord.createRecord';

import { getRecord } from 'lightning/uiRecordApi';
import  getStateDistrictPicklist from '@salesforce/apex/StateDistrictPicklist.getStateDistrictPicklist';
const FIELDS = ['Sale_Invoice__c.Party__r.Name', 'Product_Item__c.Product2.Name'];


export default class CreateSale extends LightningElement {
  //Test Comment 12
  @api InvData ={Party:"", InvNumber:"", Contact:"", Invdate:"", Phone:"", Email:"", Village:"", Block:"", Taishil:"", State:"", District:""}
  FortuneLogoUrl = Logo;
  addIcon=ADDICON;
  DeleteIcon=DELETEICON;
  UoMValues;
  @track productName;
  @track quantity;
  @track unitPrice;
  @track description;
  @api recordId;
  @track selectedAccount;
  
 @track Totalprice=0;
 @track DiscountPrice=0;
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

  @wire(getStateDistrictPicklist)
  StateDistrictMapping({data, error}) {
      if(data) {
          this.StateOptions = data.map(item => {
              return {label: item.State__c, value: item.State__c};
          });
      } else if(error) {
          console.error('Error retrieving State and District values:', error);
      }
  }

 /* handleStateChange(event) {
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


        handleAccountSelection(event){
            this.InvData.Party = event.target.value;
            
        }
        HandleFocus(){
            if(this.InvData.Party==""){ 
                    alert("Please Select Party First");
            }
        }
        InvChnageHandler(event){
          this.InvData.InvNumber=event.target.value;
        }
        ContacChangetHandler(event){
          this.InvData.Contact=event.target.value;
        }
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