public class createSale {
public static void createSaleRecord(string party, string contact , string village, string tehsil , string block , string district , string state , date invDate , string invoiceNumber )
    {
        Sale_Invoice__c saleInvObj= new Sale_Invoice__c();
        saleInvObj.Block__c= block;
        saleInvObj.State__c= state;
        saleInvObj.Tehsil__c= tehsil;
        saleInvObj.Village__c= village;
     //   saleInvObj.Contact_Person__c= contact;
        saleInvObj.Name= invoiceNumber;
        saleInvObj.Party_Name__c='FRL001 (Ankit)';
        saleInvObj.Total_Invoice_Value__c=0;
        insert saleInvObj;
    }




    // GET CLIENT FARMERS 
    @AuraEnabled(cacheable=true)
    public static List<Account> getClientFarmerList(Id selAccId) {
        List<Account> ClientFarmerList = new List<Account>();
                system.debug('selAccId'+selAccId);
         

        if (selAccId != null && selAccId != '') {
            // Use a subquery to filter Account records based on related Farm__c records
            ClientFarmerList = [
                SELECT Id, Name, Phone, Father_Name__c, Village__c, Farmer_Code__c
                FROM Account
                WHERE Id =: selAccId
            ];
        }
        
        system.debug('ClientFarmerList'+ClientFarmerList.Size());
         
        return ClientFarmerList;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
/*@AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id selAccId, string searchcont) {
        system.debug(selAccId);
        system.debug(searchcont);
          List<Contact> ContactList = new List<Contact>();
                ContactList =  [SELECT Id, Name, AccountId
                FROM Contact 
                Where AccountId =: selAccId
                AND Name LIKE :searchcont + '%'];
        system.debug(ContactList);
        return ContactList;
    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getRelatedContacts(String searchcont, string myObject ) {
        system.debug('searchcont'+searchcont);
        system.debug('myObject'+myObject);

        String myQuery = null;
    
            if(searchcont == null || searchcont == ''){
                myQuery = 'Select Id, Name from '+myObject+' Where LastViewedDate != NULL ORDER BY LastViewedDate DESC LIMIT  5';
            }
            else {
                myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchcont + '%\' LIMIT  5';
            }
        
        List<contact> lookUpList = database.query(myQuery);
        return lookUpList;
    }*/


 @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(String actName, String accountId){
        system.debug('Method executed1');
        system.debug(actName);
        system.debug(accountId);
        List<Contact> accountList = new List<Contact>();
        if(actName != ''){
            String accountName = '%' + actName + '%';
            accountList = [SELECT Id, Name, AccountId, Phone, Email, Village__c, Village_Name__c, Block__c, Tehsil__c, District__c, State__c FROM Contact WHERE Name LIKE :accountName AND AccountId =: accountId];
        }
        system.debug(accountList);
        return accountList;
    }

    /*
     //Fields attributes
    contactEmail = '';
    contactPhone = '';
    contactVillage = '';
    contactBlock = '';
    contactTehsil = '';
    contactDistrict = '';
    contactState = '';

    
    const selectedContact = this.contacts.find(contact => contact.fields.Id.value === event.target.dataset.value);

    if (selectedContact) {
      //Lookup Search fields
        this.selectedContactId = selectedContact.fields.Id.value;
        this.searchContacts = selectedContact.fields.Name.value;
        this.contactVillageId = selectedContact.fields.Village__c.value;
      
      //Assigning Contacts Field on UI
        this.contactEmail = selectedContact.fields.Email.value;
        this.contactVillage = selectedContact.fields.Village_Name__c.value;
        this.contactBlock = selectedContact.fields.Block__c.value;
        this.contactTehsil = selectedContact.fields.Tehsil__c.value;
        this.contactDistrict = selectedContact.fields.District__c.value;
        this.contactState = selectedContact.fields.State__c.value;
        this.contactPhone = selectedContact.fields.Phone.value;

        this.showContactResults = false; // Hide search result list
        this.isNewContactButtonDisabled = true; // Disable new contact button
    } */

}