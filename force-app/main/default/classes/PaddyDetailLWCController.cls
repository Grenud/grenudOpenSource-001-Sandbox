public without sharing class PaddyDetailLWCController {
    @AuraEnabled(cacheable=true)     //getSupplyBillDetails
        public static List<SObject> getFarmerPurchaseDetails(String recordId) {
           String ClientFarmerId;
            String GeneralFarmerId;
            List<Paddy_Purchase__c>PaddyRecordList=[Select Id, Client_Farmer__c, General_Farmer__c from Paddy_Purchase__c where ID=:recordId ];
     
            if(PaddyRecordList.size()>0){
                ClientFarmerId=PaddyRecordList[0].Client_Farmer__c;
                GeneralFarmerId=PaddyRecordList[0].General_Farmer__c;
           
            }
            String Query1='SELECT Id, Name,Credit_Settlement__c,Total_Remaining_Balance__c, Phone, Total_Farmer_Credit__c, Farmer_Code__c,Village__c, (SELECT Id,Farmer_Name__c,Total_Paddy_Quantity__c,TOTAL_BAG_LABOUR_CHARGE__c, Loose_Quantity_Qtl__c,Loose_Amount__c,Name,Shipping_Address__c, Credit_Settlement__c, Cash_Deduction__c, Phone__c,Father_Name__c, CreatedDate ,Bag__c,Bill_To__c,Bonus_100Rs_Per_Qtl__c,Buyer_GSTIN_UIN__c,HSN_SAC__c,LABOUR_CHARGE_PER_BAG_INR__c,Packing__c,Paddy_Amount__c,Amount__c, Paddy_Quantity_Qtl__c, Rate_Per_Qtl__c,Branch_Name__c,IFSC_Code__c, Bank_Name__c,A_C_Holder_Name__c,RE_Account_Number__c, Paddy_Type__c,Date__c,Invoice_No__c,Shipping_State__c,Go__c,Village__c, Grand_Total__c FROM Paddy_Purchases__r where ID=:recordId) FROM Account WHERE ID = :ClientFarmerId';
            String Query = 'SELECT Id,Name, (SELECT Id, Farmer_Name__c, Name,Phone__c,Father_Name__c,Total_Paddy_Quantity__c, CreatedDate ,Bag__c,Bill_To__c,Shipping_Address__c,Bonus_100Rs_Per_Qtl__c,TOTAL_BAG_LABOUR_CHARGE__c,Buyer_GSTIN_UIN__c,HSN_SAC__c,Loose_Quantity_Qtl__c,Loose_Amount__c,LABOUR_CHARGE_PER_BAG_INR__c,Cash_Deduction__c, Packing__c,Paddy_Amount__c, Amount__c,Paddy_Quantity_Qtl__c,Paddy_Type__c,Rate_Per_Qtl__c,RE_Account_Number__c,Date__c,Invoice_No__c,Shipping_State__c,Go__c,Village__c,Grand_Total__c,A_C_Holder_Name__c,Bank_Name__c,Branch_Name__c,IFSC_Code__c FROM Paddy_Purchases__r where ID=:recordId) FROM General_Farmer__c WHERE ID = :GeneralFarmerId';
            //String query = 'SELECT Id, Name,Credit_Settlement__c,Total_Remaining_Balance__c, Phone, Total_Invoice_Value__c, Total_Farmer_Credit__c,Total_Sale_Invoice_Count__c, Farmer_Code__c,Village__c, (SELECT Id, Name, Credit_Settlement__c, CreatedDate FROM Paddy_Purchases__r), (SELECT Id, Name, Invoice_Date__c,Payment_Type__c,Total_Invoice_Value__c, CreatedDate FROM Sale_Invoices1__r) FROM Account WHERE ID = :ClientFarmerId';
         //   system.debug(Database.query(query));
         //   system.debug(query);
            if(ClientFarmerId!=null){
                system.debug(Database.query(query1));
               return Database.query(query1); 
            }
            else{
              //  system.debug(Database.query(query));
                return Database.query(query);
            }
            
        }
       
        @AuraEnabled(cacheable=true)     
        public static List<SObject> getSupplyBillDetails(String recordId) {
           String ClientFarmerId;
            String GeneralFarmerId;
            List<Paddy_Purchase__c>PaddyRecordList=[Select Id, Client_Farmer__c, General_Farmer__c from Paddy_Purchase__c where ID=:recordId ];
        //   system.debug(PaddyRecordList);
            if(PaddyRecordList.size()>0){
                ClientFarmerId=PaddyRecordList[0].Client_Farmer__c;
                GeneralFarmerId=PaddyRecordList[0].General_Farmer__c;
           //     system.debug(GeneralFarmerId);
            }
            String Query1='SELECT Id, Name,Credit_Settlement__c,Total_Remaining_Balance__c, Phone, Total_Farmer_Credit__c, Farmer_Code__c,Village__c, (SELECT Id,Farmer_Name__c,Total_Paddy_Quantity__c,TOTAL_BAG_LABOUR_CHARGE__c, Loose_Quantity_Qtl__c,Loose_Amount__c,Name,Shipping_Address__c, Credit_Settlement__c, Cash_Deduction__c, Phone__c,Father_Name__c, CreatedDate ,Bag__c,Bill_To__c,Bonus_100Rs_Per_Qtl__c,Buyer_GSTIN_UIN__c,HSN_SAC__c,LABOUR_CHARGE_PER_BAG_INR__c,Packing__c,Paddy_Amount__c,Amount__c, Paddy_Quantity_Qtl__c, Rate_Per_Qtl__c,Branch_Name__c,IFSC_Code__c, Bank_Name__c,A_C_Holder_Name__c,RE_Account_Number__c, Paddy_Type__c,Date__c,Invoice_No__c,Shipping_State__c,Go__c,Village__c, Grand_Total__c FROM Paddy_Purchases__r where ID=:recordId) FROM Account WHERE ID = :ClientFarmerId';
            String Query = 'SELECT Id,Name, (SELECT Id, Farmer_Name__c, Name,Phone__c,Father_Name__c,Total_Paddy_Quantity__c, CreatedDate ,Bag__c,Bill_To__c,Shipping_Address__c,Bonus_100Rs_Per_Qtl__c,TOTAL_BAG_LABOUR_CHARGE__c,Buyer_GSTIN_UIN__c,HSN_SAC__c,Loose_Quantity_Qtl__c,Loose_Amount__c,LABOUR_CHARGE_PER_BAG_INR__c,Cash_Deduction__c, Packing__c,Paddy_Amount__c, Amount__c,Paddy_Quantity_Qtl__c,Paddy_Type__c,Rate_Per_Qtl__c,RE_Account_Number__c,Date__c,Invoice_No__c,Shipping_State__c,Go__c,Village__c,Grand_Total__c,A_C_Holder_Name__c,Bank_Name__c,Branch_Name__c,IFSC_Code__c FROM Paddy_Purchases__r where ID=:recordId) FROM General_Farmer__c WHERE ID = :GeneralFarmerId';
           
            if(ClientFarmerId!=null){
                system.debug(Database.query(query1));
               return Database.query(query1); 
            }
            else{
              //  system.debug(Database.query(query));
                return Database.query(query);
            }
            
        }
        //
         @AuraEnabled
        public static Attachment generateSupplyBillPDF(Id recordId, String htmlData){
            Pagereference page = Page.renderAsPDF;
            page.getParameters().put('pdfText', htmlData); 
            system.debug(recordId);
            Supply_Billing__c con = new Supply_Billing__c(Id=recordId);
            Attachment objAttachment = new Attachment();
            objAttachment.Name='Supplyinvoice.pdf';
            objAttachment.ParentId = con.Id;
            objAttachment.Body = page.getContentaspdf();
            system.debug(page.getContentaspdf());
            objAttachment.IsPrivate = false;
            insert objAttachment;
            return objAttachment;
        }
        @AuraEnabled(cacheable=true)
        public static List<Sobject> getFarmerRecord(String recordId){
            String ClientFarmerId  ;
            List<Paddy_Purchase__c>PaddyRecordList=[Select Id, Client_Farmer__c from Paddy_Purchase__c where ID=:recordId ];
            if(PaddyRecordList.size()>0){
                ClientFarmerId=PaddyRecordList[0].Client_Farmer__c;
            }
            String query = 'SELECT Id, Name,Credit_Settlement__c,Total_Remaining_Balance__c, Phone, Total_Invoice_Value__c, Total_Farmer_Credit__c,Total_Sale_Invoice_Count__c, Farmer_Code__c,Village__c,Total_Cash_Credit__c,Total_Seeds_Credit__c, (SELECT Id, Name, Credit_Settlement__c, CreatedDate FROM Paddy_Purchases__r), (SELECT Id, Name, Invoice_Date__c,Payment_Type__c,Total_Invoice_Value__c, CreatedDate FROM Sale_Invoices1__r), (SELECT Id, Name, Invoice_Number__c,Total_Invoice_Value__c,Balance_Due__c FROM Farmer_Credits__r) FROM Account WHERE ID = :ClientFarmerId';
             return Database.query(query);
        }
    }