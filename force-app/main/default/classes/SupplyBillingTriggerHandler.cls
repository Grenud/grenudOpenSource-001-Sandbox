public class SupplyBillingTriggerHandler {
    
     public static void convertToWord(List<Supply_Billing__c> NewList) {
        
        List<Supply_Billing__c>RecordstoUpdae=new List<Supply_Billing__c>();
        for(Supply_Billing__c SBObj:NewList){
            if(SBObj.Total_Amount__c!=null ){
                 try {
                Utiity U = new Utiity();
                SBObj.Amount_in_Words__c=U.getNumberTOWordConvertion(SBObj.Total_Amount__c);
                RecordstoUpdae.add(SBObj);
            } catch (Exception e) {
                
                System.debug('An error occurred: ' + e.getMessage());
            }
               
                
            }
        }
       
    } 
   public static void handleBeforeInsertInvoice(List<Supply_Billing__c> newPurchases) {
        // Find the maximum Series__c value among existing records for FORTUNE RICE LIMITED
        List<AggregateResult> maxSeriesFRLResult = [SELECT MAX(Series__c) maxSeries FROM Supply_Billing__c WHERE Bill_From__c = 'FORTUNE RICE LIMITED'];

        // Initialize series if no records are found
        Decimal maxSeriesFRL = (maxSeriesFRLResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFRLResult[0].get('maxSeries') : 0;

        // Find the maximum Series1__c value among existing records for FORTUNE AGROMART PVT LTD
        List<AggregateResult> maxSeriesFAGROResult = [SELECT MAX(Series1__c) maxSeries FROM Supply_Billing__c WHERE Bill_From__c = 'FORTUNE AGROMART PVT LTD'];

        // Initialize series if no records are found
        Decimal maxSeriesFAGRO = (maxSeriesFAGROResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFAGROResult[0].get('maxSeries') : 0;

        for (Supply_Billing__c purchase : newPurchases) {
            String billTo = purchase.Bill_From__c;

            // Check if the record is being inserted (no ID)
            if (String.isBlank(purchase.Id)) {
                if (billTo == 'FORTUNE RICE LIMITED') {
                    maxSeriesFRL++;
                    purchase.Series__c = maxSeriesFRL;
                    purchase.Series1__c = null;
                } else if (billTo == 'FORTUNE AGROMART PVT LTD') {
                    maxSeriesFAGRO++;
                    purchase.Series1__c = maxSeriesFAGRO;
                    purchase.Series__c = null;
                }
            }
            
            // Update Invoice number based on the current Series
            if (billTo == 'FORTUNE RICE LIMITED') {
                purchase.Invoice_No__c = maxSeriesFRL;
            } else if (billTo == 'FORTUNE AGROMART PVT LTD') {
                purchase.Invoice_No__c = maxSeriesFAGRO;
            }
        }
    }

    public static void handleBeforeUpdateInvoice(List<Supply_Billing__c> updatedPurchases, Map<Id, Supply_Billing__c> oldMap) {
        List<Supply_Billing__c> purchasesToUpdate = new List<Supply_Billing__c>();

    for (Supply_Billing__c purchase : updatedPurchases) {
        Supply_Billing__c oldPurchase = oldMap.get(purchase.Id);
        String billTo = purchase.Bill_From__c;
        String oldBillTo = oldPurchase.Bill_From__c;

        // Check if the "Bill To" value has changed
        if (billTo != oldBillTo || String.isBlank(billTo)) {
            purchasesToUpdate.add(purchase);
        }
    }

    if (!purchasesToUpdate.isEmpty()) {
        // Find the maximum Series__c value among existing records for FORTUNE RICE LIMITED
        List<AggregateResult> maxSeriesFRLResult = [SELECT MAX(Series__c) maxSeries FROM Supply_Billing__c WHERE Bill_From__c = 'FORTUNE RICE LIMITED'];

        // Initialize series if no records are found
        Decimal maxSeriesFRL = (maxSeriesFRLResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFRLResult[0].get('maxSeries') : 0;

        // Find the maximum Series1__c value among existing records for FORTUNE AGROMART PVT LTD
        List<AggregateResult> maxSeriesFAGROResult = [SELECT MAX(Series1__c) maxSeries FROM Supply_Billing__c WHERE Bill_From__c = 'FORTUNE AGROMART PVT LTD'];

        // Initialize series if no records are found
        Decimal maxSeriesFAGRO = (maxSeriesFAGROResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFAGROResult[0].get('maxSeries') : 0;

        for (Supply_Billing__c purchaseToUpdate : purchasesToUpdate) {
            String newBillTo = purchaseToUpdate.Bill_From__c;
            // Reset series fields based on the new "Bill To" value
            if (newBillTo == 'FORTUNE RICE LIMITED') {
                maxSeriesFRL++;
                purchaseToUpdate.Series__c = maxSeriesFRL;
                purchaseToUpdate.Series1__c = null;
                purchaseToUpdate.Invoice_No__c = maxSeriesFRL;
            } else if (newBillTo == 'FORTUNE AGROMART PVT LTD') {
                maxSeriesFAGRO++;
                purchaseToUpdate.Series1__c = maxSeriesFAGRO;
                purchaseToUpdate.Series__c = null;
                purchaseToUpdate.Invoice_No__c = maxSeriesFAGRO;
            }
        }
    }
    } 
    
   
    public static void handleBeforeInsertShipTo(List<Supply_Billing__c> newRecords) {
        for (Supply_Billing__c billing : newRecords) {
            if (billing.Bill_To__c != null && billing.Bill_To__c == 'FORTUNE RICE LIMITED') {
                billing.Ship_To__c = billing.Bill_To__c;
                billing.Ship_To_Address__c=billing.Shipping_Address__c;
                billing.Ship_To_Buyer_GSTIN_UIN__c=billing.Buyer_GSTIN_UIN__c;
                billing.Ship_To_State__c=billing.Shipping_State__c;
                billing.Ship_To_Country__c=billing.Shipping_Country__c;
            }
            if (billing.Bill_To__c != null && billing.Bill_To__c == 'PP AGRO INDIA') {
                 billing.Ship_To__c = billing.Bill_To__c;
                 billing.Ship_To_Address__c = billing.Shipping_Address__c;
                 billing.Ship_To_Buyer_GSTIN_UIN__c = billing.Buyer_GSTIN_UIN__c;
                 billing.Ship_To_State__c = billing.Shipping_State__c;
                 billing.Ship_To_Country__c = billing.Shipping_Country__c;
               }
        }
    }

    public static void handleBeforeUpdateShipTo(List<Supply_Billing__c> newRecords, Map<Id, Supply_Billing__c> oldMap) {
        for (Supply_Billing__c billing : newRecords) {
            if (billing.Bill_To__c != null && billing.Bill_To__c == 'FORTUNE RICE LIMITED' && billing.Bill_To__c != oldMap.get(billing.Id).Bill_To__c) {
                billing.Ship_To__c = billing.Bill_To__c;
                billing.Ship_To_Address__c=billing.Shipping_Address__c;
                billing.Ship_To_Buyer_GSTIN_UIN__c=billing.Buyer_GSTIN_UIN__c;
                billing.Ship_To_State__c=billing.Shipping_State__c;
                billing.Ship_To_Country__c=billing.Shipping_Country__c;
            }
           if (billing.Bill_To__c != null && billing.Bill_To__c == 'PP AGRO INDIA' && billing.Bill_To__c != oldMap.get(billing.Id).Bill_To__c) {
                 billing.Ship_To__c = billing.Bill_To__c;
                 billing.Ship_To_Address__c = billing.Shipping_Address__c;
                 billing.Ship_To_Buyer_GSTIN_UIN__c = billing.Buyer_GSTIN_UIN__c;
                 billing.Ship_To_State__c = billing.Shipping_State__c;
                 billing.Ship_To_Country__c = billing.Shipping_Country__c;
               }
            /* else {
             billing.Ship_To__c = null;
             billing.Ship_To_Address__c = null;
             billing.Ship_To_Buyer_GSTIN_UIN__c = null;
             billing.Ship_To_State__c = null;
             billing.Ship_To_Country__c = null;
            } */
        }
    } 
}