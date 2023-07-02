public with sharing class CreateINvRecord {
     public class RowData {
           public Integer index;
        // public Integer id;
         public Integer SrNo;
         public String item;
         public String description;
         public Decimal quantity;
          public String UoM;
          public Decimal rate;
           public Decimal Discount;
       
         public Decimal DiscountPrice;
         public Decimal Total;
       
    }
   
    
    @AuraEnabled
    public static void createRecord(String jsonString, string JsonStr) {
        // Parse the JSON string
        system.debug('jsonString@@@'+jsonString);
         system.debug('JsonStr@@@'+JsonStr);
        
        Map<String, Object> jsonData = (Map<String, Object>) JSON.deserializeUntyped(jsonString);

        // Extract the field values from the JSON object
        String party = (String) jsonData.get('Party');
        String InvNumber = (String) jsonData.get('InvNumber');
         String Con = (String) jsonData.get('Contact');
        String PartyName=(String) jsonData.get('PartyName');
       // String InvDate = (Date) jsonData.get('Invdate');
          String Phone = (String) jsonData.get('Phone');
        String Email = (String) jsonData.get('Email');
         String Village = (String) jsonData.get('Village');
        String Block = (String) jsonData.get('Block');
        String Taishil = (String) jsonData.get('Taishil');
         String State = (String) jsonData.get('State');
         String District = (String) jsonData.get('District');
        // Create a new record object
        Sale_Invoice__c newRecord = new Sale_Invoice__c();
        newRecord.Client_Farmer__c = party;
        newRecord.Name = InvNumber;
        newRecord.Contact_Person__c = Con;
        //newRecord.Invoice_Date__c = InvDate;
        newRecord.Phone__c = Phone;
        newRecord.Email__c = Email;
        newRecord.Village__c = Village;
        newRecord.Block__c = Block;
        newRecord.Tehsil__c = Taishil;
        newRecord.State__c = State;
       // newRecord.District__c = District;
        newRecord.Party_Name__c=PartyName;
        newRecord.Total_Invoice_Value__c=0;
        
        //newRecord.Vyapar_INV_No__c='1';
        //newRecord.Party_Name__c='FRL001 (Ankit)';
        
        // Set more field values as needed

        // Insert the record
        insert newRecord;
        ID ParentID=newRecord.Id;
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        List<RowData> Items=(List<RowData>) JSON.deserialize(JsonStr, List<RowData>.class);
        system.debug('ParentID@@'+ParentID);
        system.debug('RowData@@'+Items);
        List<Product_Item__c>ListToInsert=new list<Product_Item__c>();
       for (RowData row : Items) {
            Product_Item__c record = new Product_Item__c();
           record.Sale_Invoice__c=ParentID;
            //record.Product__c = row.item;
            record.Product_Item_Description__c = row.description;
            record.Quantity__c = row.quantity;
           record.UoM__c = row.UoM;
           record.Sale_Price__c = row.rate;
           record.Discount__c = row.Discount;
           // Check once when we live LWC Create Sale
           //record.Vyapar_INV_No__c='1';
           
           
            ListToInsert.add(record);
        }
 
        if(ListToInsert.size()>0){
            insert ListToInsert;
        }
        
    }
        /////////////////////////////////////
          
    }