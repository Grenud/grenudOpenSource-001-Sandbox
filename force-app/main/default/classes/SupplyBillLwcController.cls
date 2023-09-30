public with sharing class SupplyBillLwcController {
   /* public List<Paddy_Purchase__c> paddyRecordList { get; set; }
    public String recordId { get; set; }

    public SupplyBillLwcController() {
        // Initialize the recordId with the value you want to query
        // For example, you can pass the recordId as a parameter to the constructor
        // recordId = ApexPages.currentPage().getParameters().get('id');

        // Call your method to populate the paddyRecordList
        paddyRecordList = getSBDetails(recordId);
    }

    // Your existing method to retrieve data
   public static List<SObject> getSBDetails(String recordId) {
     
        List<Paddy_Purchase__c>PaddyRecordList=New List<Paddy_Purchase__c>();
List<Supply_Billing__c>SBList= [SELECT Id, Bill_From__c,Billing_Address__c,Seller_GSTIN_UIN__c,Billing_State__c, Ship_To__c,Ship_To_Address__c,Ship_To_Buyer_GSTIN_UIN__c,Ship_To_State__c, Bill_To__c,Shipping_Address__c,Buyer_GSTIN_UIN__c,Shipping_State__c, Invoice_No__c, Date__c, Dispatch_Doc_No__c, Destination__c, Dispatch_through__c, Vehicle_No__c,(SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c,Rate_Per_Qtl__c,Sold_Quantity_1st_Attempt__c,HSN_SAC__c,Packing__c, 
      Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,Sold_Bags_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Quantity_2nd_Attempt__c,
     Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c FROM Paddy_Purchases__r ), (SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c,Rate_Per_Qtl__c,Sold_Quantity_1st_Attempt__c,HSN_SAC__c,Packing__c, 
      Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,Sold_Bags_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Quantity_2nd_Attempt__c
      FROM Paddy_Purchases1__r )       FROM Supply_Billing__c where ID =:recordId];
        for(Supply_Billing__c SB:SBList){
            if(SB.Paddy_Purchases__r.size()>0){
                PaddyRecordList.addAll(SB.Paddy_Purchases__r);
            }
            if(SB.Paddy_Purchases1__r.size()>0){
                PaddyRecordList.addAll(SB.Paddy_Purchases__r);
            }
        }
            return PaddyRecordList;
        } */
}