public class PaddyPurchaseTriggerHandler 
{    
       
  /*  public static void updateAccountNumber(List<Paddy_Purchase__c> paddyPurchases) {
        Set<Id> accountIds = new Set<Id>();
        Set<Id> generalFarmerIds = new Set<Id>();

        for (Paddy_Purchase__c paddyPurchase : paddyPurchases) {
            if (paddyPurchase.Client_Farmer__C != null) {
                accountIds.add(paddyPurchase.Client_Farmer__C);
            }
            if (paddyPurchase.General_Farmer__c != null) {
                generalFarmerIds.add(paddyPurchase.General_Farmer__c);
            }
        }

        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id,A_C_Holder_Name__c,Bank_Name__c,Branch_Name__c,IFSC_Code__c,RE_Account_Number__c,AccountNumber,
           A_C_Holder_Name2__c,Account_Number2__c,Bank_Name2__c,Branch_Name2__c,IFSC_Code2__c,RE_Account_Number2__c,
           A_C_Holder_Name3__c,Account_Number3__c,Bank_Name3__c,Branch_Name3__c,IFSC_Code3__c,RE_Account_Number3__c,
           A_C_Holder_Name4__c,Account_Number4__c,Bank_Name4__c,Branch_Name4__c,IFSC_Code4__c,RE_Account_Number4__c,
           A_C_Holder_Name5__c,Account_Number5__c,Bank_Name5__c,Branch_Name5__c,IFSC_Code5__c,RE_Account_Number5__c,
           A_C_Holder_Name6__c,Account_Number6__c,Bank_Name6__c,Branch_Name6__c,IFSC_Code6__c,RE_Account_Number6__c FROM Account WHERE Id IN :accountIds]);
       
        Map<Id, General_Farmer__c> generalFarmerMap = new Map<Id, General_Farmer__c>([SELECT Id, A_C_Holder_Name__c,Bank_Name__c,Branch_Name__c,IFSC_Code__c,RE_Account_Number__c,Account_Number__c,
           A_C_Holder_Name2__c,Account_Number2__c,Bank_Name2__c,Branch_Name2__c,IFSC_Code2__c,RE_Account_Number2__c,
           A_C_Holder_Name3__c,Account_Number3__c,Bank_Name3__c,Branch_Name3__c,IFSC_Code3__c,RE_Account_Number3__c,
           A_C_Holder_Name4__c,Account_Number4__c,Bank_Name4__c,Branch_Name4__c,IFSC_Code4__c,RE_Account_Number4__c,
           A_C_Holder_Name5__c,Account_Number5__c,Bank_Name5__c,Branch_Name5__c,IFSC_Code5__c,RE_Account_Number5__c,
           A_C_Holder_Name6__c,Account_Number6__c,Bank_Name6__c,Branch_Name6__c,IFSC_Code6__c,RE_Account_Number6__c FROM General_Farmer__c WHERE Id IN :generalFarmerIds]);

        for (Paddy_Purchase__c paddyPurchase : paddyPurchases) {
            String accountSeriesValue = paddyPurchase.Account_Select__c; // Assuming Account_Select__c is the picklist field on the Paddy Purchase object

            if (paddyPurchase.Client_Farmer__C != null && accountMap.containsKey(paddyPurchase.Client_Farmer__C)) {
                Account account = accountMap.get(paddyPurchase.Client_Farmer__C);
                if (accountSeriesValue == 'Account=>1') {
                    paddyPurchase.Account_Number__c = account.AccountNumber;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code__c;
                }else if (accountSeriesValue == 'Account=>2') {
                    paddyPurchase.Account_Number__c = account.Account_Number2__c;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name2__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name2__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name2__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code2__c;
                }else if (accountSeriesValue == 'Account=>3') {
                    paddyPurchase.Account_Number__c = account.Account_Number3__c;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name3__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name3__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name3__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code3__c;
                }else if (accountSeriesValue == 'Account=>4') {
                    paddyPurchase.Account_Number__c = account.Account_Number4__c;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name4__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name4__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name4__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code4__c;
                }else if (accountSeriesValue == 'Account=>5') {
                    paddyPurchase.Account_Number__c = account.Account_Number5__c;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name5__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name5__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name5__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code5__c;
                }else if (accountSeriesValue == 'Account=>6') {
                    paddyPurchase.Account_Number__c = account.Account_Number6__c;
                    paddyPurchase.A_C_Holder_Name__c=account.A_C_Holder_Name6__c;
                    paddyPurchase.Bank_Name__c=account.Bank_Name6__c;
                    paddyPurchase.Branch_Name__c=account.Branch_Name6__c;
                    paddyPurchase.IFSC_Code__c=account.IFSC_Code6__c;
                }         
                else {
                    paddyPurchase.Account_Number__c = null; // Set to blank if no condition is met
                    paddyPurchase.A_C_Holder_Name__c=null;
                    paddyPurchase.Bank_Name__c=null;
                    paddyPurchase.Branch_Name__c=null;
                    paddyPurchase.IFSC_Code__c=null;
                }
            } else if (paddyPurchase.General_Farmer__c != null && generalFarmerMap.containsKey(paddyPurchase.General_Farmer__c)) {
                General_Farmer__c GF = generalFarmerMap.get(paddyPurchase.General_Farmer__c);
                if (accountSeriesValue == 'Account=>1') {
                    paddyPurchase.Account_Number__c = GF.Account_Number__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name__c;
                    paddyPurchase.IFSC_Code__c=GF.IFSC_Code__c;
                }else if (accountSeriesValue == 'Account=>2') {
                    paddyPurchase.Account_Number__c = GF.Account_Number2__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name2__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name2__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name2__c;
                    paddyPurchase.IFSC_Code__c=GF.IFSC_Code2__c;
                }else if (accountSeriesValue == 'Account=>3') {
                    paddyPurchase.Account_Number__c = GF.Account_Number3__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name3__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name3__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name3__c;
                    paddyPurchase.IFSC_Code__c=GF.IFSC_Code3__c;
                }else if (accountSeriesValue == 'Account=>4') {
                    paddyPurchase.Account_Number__c = GF.Account_Number4__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name4__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name4__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name4__c;
                    paddyPurchase.IFSC_Code__c=GF.IFSC_Code4__c;
                }else if (accountSeriesValue == 'Account=>5') {
                    paddyPurchase.Account_Number__c = GF.Account_Number5__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name5__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name5__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name5__c;
                    paddyPurchase.IFSC_Code__c=GF.IFSC_Code5__c;
                }else if (accountSeriesValue == 'Account=>6') {
                    paddyPurchase.Account_Number__c = GF.Account_Number6__c;
                    paddyPurchase.A_C_Holder_Name__c=GF.A_C_Holder_Name6__c;
                    paddyPurchase.Bank_Name__c=GF.Bank_Name6__c;
                    paddyPurchase.Branch_Name__c=GF.Branch_Name6__c;
                    paddyPurchase.IFSC_Code__c=GF	.IFSC_Code6__c;
                }         
                else {
                    paddyPurchase.Account_Number__c = null; // Set to blank if no condition is met
                    paddyPurchase.A_C_Holder_Name__c=null;
                    paddyPurchase.Bank_Name__c=null;
                    paddyPurchase.Branch_Name__c=null;
                    paddyPurchase.IFSC_Code__c=null;
                }
            }
        }
    } */
    
    public static void soldBag(list<Paddy_Purchase__c>PPlist)
    {
        for(Paddy_Purchase__c purchase : PPlist)
        {
            if(purchase.Sold_Bag_1st_Time__c==true)
            {
                purchase.Sold_Bags_1st_Attempt__c = purchase.Bag__c;                
            }           
        }
    }
    
    
    public static void NegativeValueRestrict(list<Paddy_Purchase__c>PPlist){
    for (Paddy_Purchase__c purchase : PPlist) {
        if (purchase.Bag__c < 0 ||
            purchase.Rate_Per_Qtl__c < 0 ||
            purchase.Credit_Settlement__c < 0 ||
            purchase.Sold_Bags_1st_Attempt__c < 0 ||
            purchase.Loose_Convert_Quantity_1st_Attempt__c < 0 ||
            purchase.Cash_Deduction__c < 0 ||
            purchase.Sold_Bags_2nd_Attempt__c < 0 ||
            purchase.Sold_Quantity_2nd_Attempt__c < 0 ||
            purchase.Loose_Convert_Quantity_2nd_Attempt__c < 0) {
            
            purchase.addError('The fields should not have a negative value');
        }
    }
    }
    
   public static void handleBeforeUpdate(List<Paddy_Purchase__c> newRecords, Map<Id, Paddy_Purchase__c> oldMap) {
        List<Paddy_Purchase__c> recordsToUpdate = new List<Paddy_Purchase__c>();
        
        for (Paddy_Purchase__c newRecord : newRecords) {
            Paddy_Purchase__c oldRecord = oldMap.get(newRecord.Id);

            // Check if the "Rate" field has changed
            if (newRecord.Rate_Per_Qtl__c != oldRecord.Rate_Per_Qtl__c) {
                // Update the time field with the current date and time
                newRecord.Date__c = System.now().date();
                newRecord.Date_Time__c = System.now();
                recordsToUpdate.add(newRecord);
            }
        }
    }
    
    public static void convertToWord(List<Paddy_Purchase__c> NewList) {
    List<Paddy_Purchase__c> RecordstoUpdate = new List<Paddy_Purchase__c>();
    for (Paddy_Purchase__c PaddyObj : NewList) {
        if (PaddyObj.Grand_total__c != null) {
            try {
                Utiity U = new Utiity();
                PaddyObj.Amount_in_Words__c = U.getNumberTOWordConvertion(PaddyObj.Grand_total__c);
                RecordstoUpdate.add(PaddyObj);
            } catch (Exception e) {
                
                System.debug('An error occurred: ' + e.getMessage());
            }
        }
    }
}
       
    
   public static void handleUpdateMasterLooseQuantity(List<Paddy_Purchase__c> childRecords) {
        Set<Id> parentIds = new Set<Id>();
       set<Id> ParentPaddy2=new set<Id>();

        for (Paddy_Purchase__c child : childRecords) {
            if (child.Loose_Master__c != null) {
                parentIds.add(child.Loose_Master__c);
            }
            if(child.Loose_Master_2nd_Attemp__c!=null)
            {
                ParentPaddy2.add(child.Loose_Master_2nd_Attemp__c);
            }
        }

     //   Query Parent Paddy Purchase and relevant Paddy_Purchases__r in one query
       list<Paddy_Purchase__c> ParentPaddyUpdate=new  list<Paddy_Purchase__c>();
      
       List<Paddy_Purchase__c> parentsToUpdate1 =  [SELECT Id, Loose_Master__c, Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c,
                       (SELECT Id, Loose_Convert_Quantity_1st_Attempt__c,Loose_Amount_1st_Attempt__c FROM Paddy_Purchases__r) 
                FROM Paddy_Purchase__c WHERE Id IN :parentIds];
       List<Paddy_Purchase__c> parentsToUpdate2 =  [SELECT Id, Loose_Master_2nd_Attemp__c, Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c,
                       (SELECT Id, Loose_Convert_Quantity_2nd_Attempt__c,Loose_Amount_2nd_Attempt__c FROM Paddy_Purchases1__r) 
                FROM Paddy_Purchase__c WHERE Id IN :ParentPaddy2];
 
       // Combine the results into a single list
       ParentPaddyUpdate.addAll(parentsToUpdate1);
       ParentPaddyUpdate.addAll(parentsToUpdate2);
    
        // Calculate Master Loose Quantity settlement only if Paddy_Purchase__c records have valid Loose Quantity values
    Map<Id, Decimal>ParentPaddyTotalCreditMap = new Map<Id, Decimal>();   
    Map<Id, Decimal>ParentPaddyTotalPaddyQuntityCreditMap = new Map<Id, Decimal>();
    Map<Id, Decimal>ParentPaddyTotalCreditMap2 = new Map<Id, Decimal>();   
    Map<Id, Decimal>ParentPaddyTotalPaddyQuntityCreditMap2 = new Map<Id, Decimal>();        
          
               for (Paddy_Purchase__c PP : parentsToUpdate1){
            ParentPaddyTotalCreditMap.put(PP.ID,0);
            ParentPaddyTotalPaddyQuntityCreditMap.put(PP.ID,0);
            
        }
         for (Paddy_Purchase__c PP : parentsToUpdate2){
            ParentPaddyTotalCreditMap2.put(PP.ID,0);
            ParentPaddyTotalPaddyQuntityCreditMap2.put(PP.ID,0);
        }          
                 
                 for (Paddy_Purchase__c child :[Select Loose_Convert_Quantity_1st_Attempt__c,Loose_Amount_1st_Attempt__c ,Loose_Master__c
                                               FROM Paddy_Purchase__c where Loose_Master__c IN : ParentPaddyUpdate ]) {
                if(child.Loose_Convert_Quantity_1st_Attempt__c!=null)
                {
                    ParentPaddyTotalPaddyQuntityCreditMap.put(child.Loose_Master__c,ParentPaddyTotalPaddyQuntityCreditMap.get(child.Loose_Master__c)+child.Loose_Convert_Quantity_1st_Attempt__c);// need to check which field to be rollup
                }
                if(child.Loose_Amount_1st_Attempt__c!=null)
                {
                    ParentPaddyTotalCreditMap.put(child.Loose_Master__c,ParentPaddyTotalCreditMap.get(child.Loose_Master__c)+child.Loose_Amount_1st_Attempt__c);// need to check which field to be rollup
                }
                }              
   
                for (Paddy_Purchase__c child :[Select Loose_Convert_Quantity_2nd_Attempt__c,Loose_Amount_2nd_Attempt__c ,Loose_Master_2nd_Attemp__c
                                               FROM Paddy_Purchase__c where Loose_Master_2nd_Attemp__c IN : ParentPaddyUpdate ])
                {
                   if(child.Loose_Convert_Quantity_2nd_Attempt__c!=null)
                {
                    ParentPaddyTotalPaddyQuntityCreditMap2.put(child.Loose_Master_2nd_Attemp__c,ParentPaddyTotalPaddyQuntityCreditMap2.get(child.Loose_Master_2nd_Attemp__c)+child.Loose_Convert_Quantity_2nd_Attempt__c);// need to check which field to be rollup
                }
                if(child.Loose_Amount_2nd_Attempt__c!=null)
                {
                    ParentPaddyTotalCreditMap2.put(child.Loose_Master_2nd_Attemp__c,ParentPaddyTotalCreditMap2.get(child.Loose_Master_2nd_Attemp__c)+child.Loose_Amount_2nd_Attempt__c);// need to check which field to be rollup
                } 
                }
         // Step 4: Update Parent Paddy Purchase
            List<Paddy_Purchase__c> ParentPaddyToUpdateWithRollup = new List<Paddy_Purchase__c>();
           for(Paddy_Purchase__c PP :ParentPaddyUpdate)
           { 
              Decimal totalCreditValue=0;
              Decimal totalPaddyQuantity=0;
             if (ParentPaddyTotalCreditMap.containsKey(PP.Id)) {
             totalCreditValue =totalCreditValue+ ParentPaddyTotalCreditMap.get(PP.Id);
            PP.Master_Loose_Amount__c = totalCreditValue;          
             }
            if (ParentPaddyTotalCreditMap2.containsKey(PP.Id))
            {
             totalCreditValue =totalCreditValue+ ParentPaddyTotalCreditMap2.get(PP.Id);
             PP.Master_Loose_Amount__c = totalCreditValue;          
             }
             if(ParentPaddyTotalPaddyQuntityCreditMap.containskey(PP.Id))
             {
               totalPaddyQuantity=totalPaddyQuantity + ParentPaddyTotalPaddyQuntityCreditMap.get(PP.Id);
               PP.Master_Loose_Quantity__c = totalPaddyQuantity;
             }
             if(ParentPaddyTotalPaddyQuntityCreditMap2.containskey(PP.Id))
             {
                 totalPaddyQuantity= totalPaddyQuantity + ParentPaddyTotalPaddyQuntityCreditMap2.get(PP.Id);
                 PP.Master_Loose_Quantity__c=totalPaddyQuantity;
             }
               ParentPaddyToUpdateWithRollup.add(PP);
           }
         if(!ParentPaddyToUpdateWithRollup.isempty())
         {
             update ParentPaddyToUpdateWithRollup;
         }
   }
    
    public static void handleReparentingLooseMaster(List<Paddy_Purchase__c> OldList, List<Paddy_Purchase__c> NewList, Map<Id, Paddy_Purchase__c> PPoldmap) {
        Set<Id> parentIdsToUpdate = new Set<Id>();
        Set<Id> OldIdsToUpdate = new Set<Id>();
        Set<Id> ParentAttempt2ToUpdate = new Set<Id>();
        Set<Id> OldParentAttempt2ToUpdate = new Set<Id>();        
        
        // Collect Parent Paddy Purchase IDs from the new list
        for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.Loose_Master__c != null) {
            parentIdsToUpdate.add(newPurchase.Loose_Master__c);
        }
        if(newPurchase.Loose_Master_2nd_Attemp__c!=null)
        {
            ParentAttempt2ToUpdate.add(newPurchase.Loose_Master_2nd_Attemp__c);
        }
    }
      //Collect Old Paddy Purchase IDs from the oldMap
      for (Paddy_Purchase__c oldPurchase : PPoldmap.values()) {
        if (oldPurchase.Loose_Master__c != null) {
            OldIdsToUpdate.add(oldPurchase.Loose_Master__c);
        }
         if (oldPurchase.Loose_Master_2nd_Attemp__c != null) {
            OldParentAttempt2ToUpdate.add(oldPurchase.Loose_Master_2nd_Attemp__c);
        } 
      }
        
   // Combine Client_farmer__c IDs from both sets
    Set<Id> combinedParentPaddyIds = new Set<Id>();
    set<Id>combinedPPaddy2ndAttemptIds=new set<Id>();
    combinedParentPaddyIds.addAll(parentIdsToUpdate);
    combinedParentPaddyIds.addAll(OldIdsToUpdate);
    combinedParentPaddyIds.addAll(ParentAttempt2ToUpdate);
    combinedParentPaddyIds.addAll(OldParentAttempt2ToUpdate);
    combinedPPaddy2ndAttemptIds.addAll(ParentAttempt2ToUpdate);
    combinedPPaddy2ndAttemptIds.addAll(OldParentAttempt2ToUpdate);
        
    // Update the rollup values
        
        // Query Paddy_Purchase__c and their related Paddy_Purchases__r
        list<Paddy_Purchase__c> ParentPaddyUpdate=new  list<Paddy_Purchase__c>();
      
       List<Paddy_Purchase__c> parentsToUpdate1 =  [SELECT Id, Loose_Master__c, Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c,
                       (SELECT Id, Loose_Convert_Quantity_1st_Attempt__c,Loose_Amount_1st_Attempt__c FROM Paddy_Purchases__r) 
                FROM Paddy_Purchase__c WHERE Id IN :combinedParentPaddyIds];
       List<Paddy_Purchase__c> parentsToUpdate2 =  [SELECT Id, Loose_Master_2nd_Attemp__c, Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c,
                       (SELECT Id, Loose_Convert_Quantity_2nd_Attempt__c,Loose_Amount_2nd_Attempt__c FROM Paddy_Purchases1__r) 
                FROM Paddy_Purchase__c WHERE Id IN :combinedParentPaddyIds];
 
       // Combine the results into a single list
       Map<Id, Paddy_Purchase__c> ParentPaddyMasterLooseMap = new Map<Id, Paddy_Purchase__c>();
       ParentPaddyUpdate.addAll(parentsToUpdate1);
       ParentPaddyUpdate.addAll(parentsToUpdate2);
        
    Map<Id, Decimal>ParentPaddyTotalCreditMap = new Map<Id, Decimal>();   
    Map<Id, Decimal>ParentPaddyTotalPaddyQuntityCreditMap = new Map<Id, Decimal>();
    Map<Id, Decimal>ParentPaddyTotalCreditMap2 = new Map<Id, Decimal>();   
    Map<Id, Decimal>ParentPaddyTotalPaddyQuntityCreditMap2 = new Map<Id, Decimal>();
        
    for (Paddy_Purchase__c PP : parentsToUpdate1){
            ParentPaddyMasterLooseMap.put(PP.ID, PP);
            ParentPaddyTotalCreditMap.put(PP.ID,0);
            ParentPaddyTotalPaddyQuntityCreditMap.put(PP.ID,0);
        }
        
        for (Paddy_Purchase__c PP : parentsToUpdate2){
            ParentPaddyMasterLooseMap.put(PP.ID, PP);
            ParentPaddyTotalCreditMap2.put(PP.ID,0);
            ParentPaddyTotalPaddyQuntityCreditMap2.put(PP.ID,0);
        }    
           // Calculate Loose Qyantity and update Parent Paddy
       for (Paddy_Purchase__c child :[Select Loose_Convert_Quantity_1st_Attempt__c,Loose_Amount_1st_Attempt__c ,Loose_Master__c
                                               FROM Paddy_Purchase__c where Loose_Master__c IN:combinedParentPaddyIds]) {
                if(child.Loose_Convert_Quantity_1st_Attempt__c!=null)
                {
                    ParentPaddyTotalPaddyQuntityCreditMap.put(child.Loose_Master__c,ParentPaddyTotalPaddyQuntityCreditMap.get(child.Loose_Master__c)+child.Loose_Convert_Quantity_1st_Attempt__c);// need to check which field to be rollup
                }
                if(child.Loose_Amount_1st_Attempt__c!=null)
                {
                    ParentPaddyTotalCreditMap.put(child.Loose_Master__c,ParentPaddyTotalCreditMap.get(child.Loose_Master__c)+child.Loose_Amount_1st_Attempt__c);// need to check which field to be rollup
                }
                }              
   
                for (Paddy_Purchase__c child :[Select Loose_Convert_Quantity_2nd_Attempt__c,Loose_Amount_2nd_Attempt__c ,Loose_Master_2nd_Attemp__c
                                               FROM Paddy_Purchase__c where Loose_Master_2nd_Attemp__c IN:combinedParentPaddyIds ])
                {
                   if(child.Loose_Convert_Quantity_2nd_Attempt__c!=null)
                {
                    ParentPaddyTotalPaddyQuntityCreditMap2.put(child.Loose_Master_2nd_Attemp__c,ParentPaddyTotalPaddyQuntityCreditMap2.get(child.Loose_Master_2nd_Attemp__c)+child.Loose_Convert_Quantity_2nd_Attempt__c);// need to check which field to be rollup
                }
                if(child.Loose_Amount_2nd_Attempt__c!=null)
                {
                    ParentPaddyTotalCreditMap2.put(child.Loose_Master_2nd_Attemp__c,ParentPaddyTotalCreditMap2.get(child.Loose_Master_2nd_Attemp__c)+child.Loose_Amount_2nd_Attempt__c);// need to check which field to be rollup
                } 
                }
        Map<Id, Paddy_Purchase__c>AllPurcaseRecordMap=new map<Id, Paddy_Purchase__c>();
           List<Paddy_Purchase__c> ParentPaddyToUpdateWithRollup = new List<Paddy_Purchase__c>();
           for(Paddy_Purchase__c PP :ParentPaddyUpdate)
           { 
              Decimal totalCreditValue=0;
              Decimal totalPaddyQuantity=0;
             if (ParentPaddyTotalCreditMap.containsKey(PP.Id)) {
             totalCreditValue =totalCreditValue+ ParentPaddyTotalCreditMap.get(PP.Id);
                      
             }
            if (ParentPaddyTotalCreditMap2.containsKey(PP.Id))
            {
             totalCreditValue =totalCreditValue+ ParentPaddyTotalCreditMap2.get(PP.Id);
                      
             }
             if(ParentPaddyTotalPaddyQuntityCreditMap.containskey(PP.Id))
             {
               totalPaddyQuantity=totalPaddyQuantity + ParentPaddyTotalPaddyQuntityCreditMap.get(PP.Id);
               
             }
             if(ParentPaddyTotalPaddyQuntityCreditMap2.containskey(PP.Id))
             {
                 totalPaddyQuantity= totalPaddyQuantity + ParentPaddyTotalPaddyQuntityCreditMap2.get(PP.Id);
                 
             }
              
             PP.Master_Loose_Quantity__c=totalPaddyQuantity;
            PP.Master_Loose_Amount__c = totalCreditValue;
            AllPurcaseRecordMap.put(PP.Id,PP);  
              
           }
        
            // Update Accounts if needed
        if (!AllPurcaseRecordMap.Values().isEmpty()) {
            update AllPurcaseRecordMap.Values();
        }
      
    } 
          
      
    public static void handleBeforeInsertInvoice(List<Paddy_Purchase__c> newPurchases) {
        // Find the maximum Series__c value among existing records for FORTUNE RICE LIMITED
        List<AggregateResult> maxSeriesFRLResult = [SELECT MAX(Series__c) maxSeries FROM Paddy_Purchase__c WHERE Bill_To__c = 'FORTUNE RICE LIMITED'];

        // Initialize series if no records are found
        Decimal maxSeriesFRL = (maxSeriesFRLResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFRLResult[0].get('maxSeries') : 0;

        // Find the maximum Series1__c value among existing records for FORTUNE AGROMART PVT LTD
        List<AggregateResult> maxSeriesFAGROResult = [SELECT MAX(Series1__c) maxSeries FROM Paddy_Purchase__c WHERE Bill_To__c = 'FORTUNE AGROMART PVT LTD'];

        // Initialize series if no records are found
        Decimal maxSeriesFAGRO = (maxSeriesFAGROResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFAGROResult[0].get('maxSeries') : 0;
          System.debug('maxSeriesFRL before assignment: ' + maxSeriesFRL);
        for (Paddy_Purchase__c purchase : newPurchases) {
            String billTo = purchase.Bill_To__c;

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

    public static void handleBeforeUpdateInvoice(List<Paddy_Purchase__c> updatedPurchases, Map<Id, Paddy_Purchase__c> oldMap) {
        List<Paddy_Purchase__c> purchasesToUpdate = new List<Paddy_Purchase__c>();

    for (Paddy_Purchase__c purchase : updatedPurchases) {
        Paddy_Purchase__c oldPurchase = oldMap.get(purchase.Id);
        String billTo = purchase.Bill_To__c;
        String oldBillTo = oldPurchase.Bill_To__c;

        // Check if the "Bill To" value has changed
        if (billTo != oldBillTo || String.isBlank(billTo)) {
            purchasesToUpdate.add(purchase);
        }
    }

    if (!purchasesToUpdate.isEmpty()) {
        // Find the maximum Series__c value among existing records for FORTUNE RICE LIMITED
        List<AggregateResult> maxSeriesFRLResult = [SELECT MAX(Series__c) maxSeries FROM Paddy_Purchase__c WHERE Bill_To__c = 'FORTUNE RICE LIMITED'];

        // Initialize series if no records are found
        Decimal maxSeriesFRL = (maxSeriesFRLResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFRLResult[0].get('maxSeries') : 0;

        // Find the maximum Series1__c value among existing records for FORTUNE AGROMART PVT LTD
        List<AggregateResult> maxSeriesFAGROResult = [SELECT MAX(Series1__c) maxSeries FROM Paddy_Purchase__c WHERE Bill_To__c = 'FORTUNE AGROMART PVT LTD'];

        // Initialize series if no records are found
        Decimal maxSeriesFAGRO = (maxSeriesFAGROResult[0].get('maxSeries') != null) ? (Decimal)maxSeriesFAGROResult[0].get('maxSeries') : 0;

        for (Paddy_Purchase__c purchaseToUpdate : purchasesToUpdate) {
            String newBillTo = purchaseToUpdate.Bill_To__c;
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
   
  
    public static void updateCreditSettlementRollupSum(List<Paddy_Purchase__c> NewList) {
        
        
         Set<Id> SupplyBillIdsToUpdate = new Set<Id>();
        Set<Id> SupplyBillAttempt2 = new Set<Id>();
    
    // Collect Supply_Bill_No__c IDs from the new list
    for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.Client_Farmer__c != null) {
            system.debug(newPurchase.Client_Farmer__c);
            SupplyBillIdsToUpdate.add(newPurchase.Client_Farmer__c);
        }
        system.debug(newPurchase.Supply_Bill_No_2nd_Attempt__c);
        if(newPurchase.Client_Farmer2__c!=null)
        {
            system.debug(newPurchase.Client_Farmer2__c);
            SupplyBillAttempt2.add(newPurchase.Client_Farmer2__c);
        }
    }
    
    // Combine Supply_Billing__c IDs from both sets
     Set<Id> combinedClientFarmerIds = new Set<Id>();
     Set<Id> SupplyBillAttempt2Ids = new Set<Id>();
    combinedClientFarmerIds.addAll(SupplyBillIdsToUpdate);
    combinedClientFarmerIds.addAll(SupplyBillAttempt2);
          
    // Query for related records from the first child relationship
    List<Account> SupplyBillingToUpdate = new List<Account>();
    // Query for related records from the first child relationship
    List<Account> SupplyBillingToUpdate1 = [SELECT Id, Other_Farmer_Credit_settlement__c,Credit_Settlement__c,Received_Paddy_Qtl__c,Pending_On_Platform_Qtl__c,
                (SELECT Credit_Settlement__c,Parvesh_Paddy_Qtl__c,Paddy_Quantity_Qtl__c,Return_Paddy__c,Total_Paddy_Quantity__c,Paddy_Type__c FROM Paddy_Purchases__r )
            FROM Account WHERE Id IN :combinedClientFarmerIds];
      
    // Query for related records from the second child relationship
   //   system.debug(SupplyBillingToUpdate1);
    List<Account> SupplyBillingToUpdate2 = [SELECT Id,Credit_Settlement__c,Other_Farmer_Credit_settlement__c,
                (SELECT Kit_Farmer_Credit_Settlement__c,Credit_Settlement__c FROM Paddy_Purchases1__r)
            FROM Account WHERE Id IN :combinedClientFarmerIds];
   // system.debug(SupplyBillingToUpdate2);
    
    map<Id, account>SBrecords=New map<Id, account>();
        
    Map<Id, Decimal> accountCreditSettMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountReceivedPaddyMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountPendingPaddyPP = new Map<Id, Decimal>();
    Map<Id, Decimal> accountOtherCRdtSettlMap = new Map<Id, Decimal>();
        // Calculate credit settlement totals and update Supply_Billing__c
        // 
        for (Account SB : SupplyBillingToUpdate1){
            SBrecords.put(SB.ID, SB);
            accountCreditSettMap .put(SB.ID,0);
            accountReceivedPaddyMap .put(SB.ID,0);
            accountPendingPaddyPP .put(SB.ID,0);
           
        }
        
        for (Account SB : SupplyBillingToUpdate2){
            SBrecords.put(SB.ID, SB);
            accountOtherCRdtSettlMap .put(SB.ID,0);
           } 

         for (Paddy_Purchase__c Purchase : [SELECT Client_Farmer__c,Credit_Settlement__c,Parvesh_Paddy_Qtl__c,Paddy_Quantity_Qtl__c,Return_Paddy__c,Total_Paddy_Quantity__c,Paddy_Type__c FROM Paddy_Purchase__c where Client_Farmer__c IN:combinedClientFarmerIds]) 
  
              {                                 
                  if(Purchase.Credit_Settlement__c!=null){
                  accountCreditSettMap.put(Purchase.Client_Farmer__c, accountCreditSettMap.get(Purchase.Client_Farmer__c)+Purchase.Credit_Settlement__c);
                   }
               if((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Total_Paddy_Quantity__c!=null)
               {
                  accountReceivedPaddyMap.put(Purchase.Client_Farmer__c,accountReceivedPaddyMap.get(Purchase.Client_Farmer__c)+Purchase.Total_Paddy_Quantity__c);// 
                }
                  if((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Parvesh_Paddy_Qtl__c!= null && purchase.Return_Paddy__c==false && purchase.Paddy_Quantity_Qtl__c==null){
                      accountPendingPaddyPP.put(Purchase.Client_Farmer__c,accountPendingPaddyPP.get(Purchase.Client_Farmer__c)+Purchase.Parvesh_Paddy_Qtl__c);           
                  }
                 
                //  system.debug(SupplyBillingTotalCreditMap.get(SB.Client_Farmer__c));
                                                
    }
        for(Paddy_Purchase__c SB:[SELECT Client_Farmer2__c, Kit_Farmer_Credit_Settlement__c,Credit_Settlement__c FROM Paddy_Purchase__c where Client_Farmer2__c IN:combinedClientFarmerIds]){
            if(SB.Kit_Farmer_Credit_Settlement__c!=null){
                accountOtherCRdtSettlMap.put(SB.Client_Farmer2__c, accountOtherCRdtSettlMap.get(SB.Client_Farmer2__c)+SB.Kit_Farmer_Credit_Settlement__c);// need to check which field to be rollup
            }
            }     
     
        List<Account> SupplyBillingToUpdateWithRollup = new List<Account>();
    for (Account SB : SBrecords.values()) {
        Decimal totalCreditValue=0;
         Decimal totalOtherFarmerCreditValue=0;
        Decimal totalPaddyQuantity=0;
        Decimal totalPendingPdyQuantity=0;
        if (accountCreditSettMap.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue + accountCreditSettMap.get(SB.Id);             
        }
        if (accountOtherCRdtSettlMap.containsKey(SB.Id)) {
             totalOtherFarmerCreditValue =totalOtherFarmerCreditValue + accountOtherCRdtSettlMap.get(SB.Id);         
        }
        if(accountReceivedPaddyMap.containsKey(SB.Id))
        {
             totalPaddyQuantity = totalPaddyQuantity + accountReceivedPaddyMap.get(SB.Id);         
        }
        if(accountPendingPaddyPP.containsKey(SB.Id))
        {
             totalPendingPdyQuantity = totalPendingPdyQuantity + accountPendingPaddyPP.get(SB.Id);
                   
        }
         
        SB.Credit_Settlement__c = totalCreditValue; 
        SB.Other_Farmer_Credit_settlement__c = totalOtherFarmerCreditValue;
        SB.Received_Paddy_Qtl__c = totalPaddyQuantity;
        SB.Pending_On_Platform_Qtl__c = totalPendingPdyQuantity; 
        SupplyBillingToUpdateWithRollup.add(SB);
    }      
        // Update Accounts if needed
        if (!SupplyBillingToUpdateWithRollup.isEmpty()) {
            update SupplyBillingToUpdateWithRollup;
        }
        
        
   /* Set<Id> clientFarmerIds = new Set<Id>();
    
    // Step 1: Collect unique Client_farmer__c IDs
    for (Paddy_Purchase__c purchase : PaddyPurchases) {
        if (purchase.Client_farmer__c != null) {
            clientFarmerIds.add(purchase.Client_farmer__c);
        }
    }
    // Step 2: Query Accounts and relevant Paddy_Purchases__r in one query
        List<Account> accountsToUpdate1 = [SELECT Id FROM Account WHERE Id IN :ClientFarmerIds];
        List<Account> accountsToUpdate = [SELECT Id, Credit_Settlement__c,Received_Paddy_Qtl__c,Pending_On_Platform_Qtl__c,(SELECT Credit_Settlement__c,Paddy_Quantity_Qtl__c,Parvesh_Paddy_Qtl__c,Return_Paddy__c,Paddy_Type__c,Total_Paddy_Quantity__c FROM Paddy_Purchases__r WHERE Credit_Settlement__c != null) FROM Account WHERE Id IN :clientFarmerIds];
    
    // Step 3: Calculate credit settlement totals and update Accounts
    Map<Id, Decimal> accountTotalCreditMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountReceivedPaddyMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountPendingPaddyPP = new Map<Id, Decimal>();
    for (Account acc : accountsToUpdate) {
        Decimal totalCreditValue = 0;
        Decimal totalReceivedPaddy =0;
        Decimal totalPendingPaddy=0;
        
        // Calculate total credit settlement only if Paddy_Purchase__c records have valid Credit_Settlement__c values
        for (Paddy_Purchase__c purchase : acc.Paddy_Purchases__r) {
            if (purchase.Credit_Settlement__c != null) {
                totalCreditValue += purchase.Credit_Settlement__c;
            }
            if(purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)'  && purchase.Total_Paddy_Quantity__c!=null)
            {
                totalReceivedPaddy+=purchase.Total_Paddy_Quantity__c;
            }
             if ((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Parvesh_Paddy_Qtl__c!= null 
                 && purchase.Return_Paddy__c==false && purchase.Paddy_Quantity_Qtl__c==null) {
                totalPendingPaddy += purchase.Parvesh_Paddy_Qtl__c;
            }
        }
        
        accountTotalCreditMap.put(acc.Id, totalCreditValue);
        accountReceivedPaddyMap.put(acc.Id,totalReceivedPaddy);
        accountPendingPaddyPP.put(acc.id,totalPendingPaddy);
    }
    
    // Step 4: Update Accounts
    List<Account> accountsToUpdateWithRollup = new List<Account>();
    for (Account acc : accountsToUpdate) {
        if (accountTotalCreditMap.containsKey(acc.Id)) {
            Decimal totalCreditValue = accountTotalCreditMap.get(acc.Id);
            acc.Credit_Settlement__c = totalCreditValue;
            
        }
        if(accountReceivedPaddyMap.containskey(acc.Id))
        {
            Decimal totalReceivedPaddy=accountReceivedPaddyMap.get(acc.Id);
           acc.Received_Paddy_Qtl__c =totalReceivedPaddy;
        }
        if(accountPendingPaddyPP.containskey(acc.Id))
        {
           Decimal totalPendingPaddy=accountPendingPaddyPP.get(acc.Id);
           acc.Pending_On_Platform_Qtl__c =totalPendingPaddy; 
        }
        accountsToUpdateWithRollup.add(acc);
    }
    
    // Step 5: Update Accounts if needed
    if (!accountsToUpdateWithRollup.isEmpty()) {
        update accountsToUpdateWithRollup;
    } */
}
  public static void updateReparentCreditSettRollUpSum(List<Paddy_Purchase__c> OldList, List<Paddy_Purchase__c> NewList, Map<Id, Paddy_Purchase__c> PPoldmap)
    {
    Set<Id> SupplyBillIdsToUpdate = new Set<Id>();
    Set<Id> oldSupplyBillIds = new Set<Id>();
    Set<Id> SupplyBillAttempt2 = new Set<Id>();
    Set<Id> oldSupplyBillAttempt2 = new Set<Id>();
    
    // Collect Supply_Bill_No__c IDs from the new list
    for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.Client_Farmer__c != null) {
            system.debug(newPurchase.Client_Farmer__c);
            SupplyBillIdsToUpdate.add(newPurchase.Client_Farmer__c);
        }
        system.debug(newPurchase.Supply_Bill_No_2nd_Attempt__c);
        if(newPurchase.Client_Farmer2__c!=null)
        {
            system.debug(newPurchase.Client_Farmer2__c);
            SupplyBillAttempt2.add(newPurchase.Client_Farmer2__c);
        }
    }
    
    // Collect Supply_Bill_No__c IDs from the old map
    for (Paddy_Purchase__c oldPurchase : PPoldmap.values()) {
        if (oldPurchase.Client_Farmer__c != null) {
            oldSupplyBillIds.add(oldPurchase.Client_Farmer__c);
        }
        if (oldPurchase.Client_Farmer2__c != null) {
            oldSupplyBillAttempt2.add(oldPurchase.Client_Farmer2__c);
        }
    }    
    // Combine Supply_Billing__c IDs from both sets
     Set<Id> combinedClientFarmerIds = new Set<Id>();
     Set<Id> SupplyBillAttempt2Ids = new Set<Id>();
    combinedClientFarmerIds.addAll(SupplyBillIdsToUpdate);
    combinedClientFarmerIds.addAll(oldSupplyBillIds);
    combinedClientFarmerIds.addAll(SupplyBillAttempt2);
    combinedClientFarmerIds.addAll(oldSupplyBillAttempt2);  
   // SupplyBillAttempt2Ids.addAll(SupplyBillAttempt2);
   // SupplyBillAttempt2Ids.addAll(oldSupplyBillAttempt2);   
       
    // Query for related records from the first child relationship
    List<Account> SupplyBillingToUpdate = new List<Account>();
    // Query for related records from the first child relationship
    List<Account> SupplyBillingToUpdate1 = [SELECT Id, Other_Farmer_Credit_settlement__c,Credit_Settlement__c,Received_Paddy_Qtl__c,Pending_On_Platform_Qtl__c,
                (SELECT Credit_Settlement__c,Parvesh_Paddy_Qtl__c,Paddy_Quantity_Qtl__c,Return_Paddy__c,Total_Paddy_Quantity__c,Paddy_Type__c FROM Paddy_Purchases__r )
            FROM Account WHERE Id IN :combinedClientFarmerIds];
      
    // Query for related records from the second child relationship
   //   system.debug(SupplyBillingToUpdate1);
    List<Account> SupplyBillingToUpdate2 = [SELECT Id,Credit_Settlement__c,Other_Farmer_Credit_settlement__c,
                (SELECT Kit_Farmer_Credit_Settlement__c,Credit_Settlement__c FROM Paddy_Purchases1__r)
            FROM Account WHERE Id IN :combinedClientFarmerIds];
   // system.debug(SupplyBillingToUpdate2);
    
    map<Id, account>SBrecords=New map<Id, account>();
        
    Map<Id, Decimal> accountCreditSettMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountReceivedPaddyMap = new Map<Id, Decimal>();
    Map<Id, Decimal> accountPendingPaddyPP = new Map<Id, Decimal>();
    Map<Id, Decimal> accountOtherCRdtSettlMap = new Map<Id, Decimal>();
        // Calculate credit settlement totals and update Supply_Billing__c
        // 
        for (Account SB : SupplyBillingToUpdate1){
            SBrecords.put(SB.ID, SB);
            accountCreditSettMap .put(SB.ID,0);
            accountReceivedPaddyMap .put(SB.ID,0);
            accountPendingPaddyPP .put(SB.ID,0);
           
        }
        
        for (Account SB : SupplyBillingToUpdate2){
            SBrecords.put(SB.ID, SB);
            accountOtherCRdtSettlMap .put(SB.ID,0);
           } 

         for (Paddy_Purchase__c Purchase : [SELECT Client_Farmer__c,Credit_Settlement__c,Parvesh_Paddy_Qtl__c,Paddy_Quantity_Qtl__c,Return_Paddy__c,Total_Paddy_Quantity__c,Paddy_Type__c FROM Paddy_Purchase__c where Client_Farmer__c IN:combinedClientFarmerIds]) 
  
              {                                 
                  if(Purchase.Credit_Settlement__c!=null){
                  accountCreditSettMap.put(Purchase.Client_Farmer__c, accountCreditSettMap.get(Purchase.Client_Farmer__c)+Purchase.Credit_Settlement__c);
                   }
               if((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Total_Paddy_Quantity__c!=null)
               {
                  accountReceivedPaddyMap.put(Purchase.Client_Farmer__c,accountReceivedPaddyMap.get(Purchase.Client_Farmer__c)+Purchase.Total_Paddy_Quantity__c);// 
                }
                  if((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Parvesh_Paddy_Qtl__c!= null && purchase.Return_Paddy__c==false && purchase.Paddy_Quantity_Qtl__c==null){
                      accountPendingPaddyPP.put(Purchase.Client_Farmer__c,accountPendingPaddyPP.get(Purchase.Client_Farmer__c)+Purchase.Parvesh_Paddy_Qtl__c);           
                  }
                 
                //  system.debug(SupplyBillingTotalCreditMap.get(SB.Client_Farmer__c));
                                                
    }
        for(Paddy_Purchase__c SB:[SELECT Client_Farmer2__c, Kit_Farmer_Credit_Settlement__c,Credit_Settlement__c FROM Paddy_Purchase__c where Client_Farmer2__c IN:combinedClientFarmerIds]){
            if(SB.Kit_Farmer_Credit_Settlement__c!=null){
                accountOtherCRdtSettlMap.put(SB.Client_Farmer2__c, accountOtherCRdtSettlMap.get(SB.Client_Farmer2__c)+SB.Kit_Farmer_Credit_Settlement__c);// need to check which field to be rollup
            }
            }     
     
        List<Account> SupplyBillingToUpdateWithRollup = new List<Account>();
    for (Account SB : SBrecords.values()) {
        Decimal totalCreditValue=0;
         Decimal totalOtherFarmerCreditValue=0;
        Decimal totalPaddyQuantity=0;
        Decimal totalPendingPdyQuantity=0;
        if (accountCreditSettMap.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue + accountCreditSettMap.get(SB.Id);             
        }
        if (accountOtherCRdtSettlMap.containsKey(SB.Id)) {
             totalOtherFarmerCreditValue =totalOtherFarmerCreditValue + accountOtherCRdtSettlMap.get(SB.Id);         
        }
        if(accountReceivedPaddyMap.containsKey(SB.Id))
        {
             totalPaddyQuantity = totalPaddyQuantity + accountReceivedPaddyMap.get(SB.Id);         
        }
        if(accountPendingPaddyPP.containsKey(SB.Id))
        {
             totalPendingPdyQuantity = totalPendingPdyQuantity + accountPendingPaddyPP.get(SB.Id);
                   
        }
         
        SB.Credit_Settlement__c = totalCreditValue; 
        SB.Other_Farmer_Credit_settlement__c = totalOtherFarmerCreditValue;
        SB.Received_Paddy_Qtl__c = totalPaddyQuantity;
        SB.Pending_On_Platform_Qtl__c = totalPendingPdyQuantity; 
        SupplyBillingToUpdateWithRollup.add(SB);
    }      
        // Update Accounts if needed
        if (!SupplyBillingToUpdateWithRollup.isEmpty()) {
            update SupplyBillingToUpdateWithRollup;
        }
    }
    
    
 /*   public static void updateReparentCreditSettRollUpSum(List<Paddy_Purchase__c> OldList, List<Paddy_Purchase__c> NewList, Map<Id, Paddy_Purchase__c> PPoldmap)
    {
     Set<Id> clientFarmerIdsToUpdate = new Set<Id>();
    Set<Id> oldClientFarmerIds = new Set<Id>();
        
    // Collect Client_farmer__c IDs from the new list
    for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.Client_farmer__c != null) {
            clientFarmerIdsToUpdate.add(newPurchase.Client_farmer__c);
        }
    }
    
    // Collect Client_farmer__c IDs from the old map
    for (Paddy_Purchase__c oldPurchase : PPoldmap.values()) {
        if (oldPurchase.Client_farmer__c != null) {
            oldClientFarmerIds.add(oldPurchase.Client_farmer__c);
        }
    }
       
   
    // Combine Client_farmer__c IDs from both sets
    Set<Id> combinedClientFarmerIds = new Set<Id>();
    combinedClientFarmerIds.addAll(clientFarmerIdsToUpdate);
    combinedClientFarmerIds.addAll(oldClientFarmerIds);   
           
    // Update the rollup values
    if (!combinedClientFarmerIds.isEmpty()) {
        Map<Id, Decimal> accountCreditSettMap = new Map<Id, Decimal>();
         Map<Id, Decimal> accountReceivedPaddyMap = new Map<Id, Decimal>();
         Map<Id, Decimal> accountPendingPaddyPP = new Map<Id, Decimal>();
        // Query Accounts and their related Paddy_Purchases__r
        List<Account> accountsToUpdate = [
            SELECT Id, Credit_Settlement__c,Received_Paddy_Qtl__c,Pending_On_Platform_Qtl__c,
                (SELECT Credit_Settlement__c,Parvesh_Paddy_Qtl__c,Paddy_Quantity_Qtl__c,Return_Paddy__c,Total_Paddy_Quantity__c,Paddy_Type__c FROM Paddy_Purchases__r WHERE Credit_Settlement__c != null)
            FROM Account
            WHERE Id IN :combinedClientFarmerIds
        ];
        
        // Calculate credit settlement totals and update Accounts
        for (Account acc : accountsToUpdate) {
            Decimal totalCreditValue = 0;
            Decimal totalReceivedPaddyValue=0;
            Decimal totalPendingPaddy=0;            
            // Calculate total credit settlement only if Paddy_Purchase__c records have valid Credit_Settlement__c values
            for (Paddy_Purchase__c purchase : acc.Paddy_Purchases__r) {
                if (purchase.Credit_Settlement__c != null) {
                    totalCreditValue += purchase.Credit_Settlement__c;
                }
                if(purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)' && purchase.Total_Paddy_Quantity__c!=null)
                {
                    totalReceivedPaddyValue +=purchase.Total_Paddy_Quantity__c;
                }
                 if ((purchase.Paddy_Type__c=='PADDY- PB1-(KIT)' || purchase.Paddy_Type__c=='PADDY-1718-(KIT)') && purchase.Parvesh_Paddy_Qtl__c!= null && purchase.Return_Paddy__c==false && purchase.Paddy_Quantity_Qtl__c==null) {
                totalPendingPaddy += purchase.Parvesh_Paddy_Qtl__c;
            }
            }
            
            accountCreditSettMap.put(acc.Id, totalCreditValue);
            accountReceivedPaddyMap.put(acc.Id,totalReceivedPaddyValue);
            accountPendingPaddyPP.put(acc.id,totalPendingPaddy);
        }
        
        // Update Accounts
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        for (Account acc : accountsToUpdate) {
            if (accountCreditSettMap.containsKey(acc.Id)) {
                Decimal totalCreditValue = accountCreditSettMap.get(acc.Id);
                acc.Credit_Settlement__c = totalCreditValue;
               
            }
            if(accountReceivedPaddyMap.containskey(acc.Id))
            {
                Decimal totalReceivedPaddyValue = accountReceivedPaddyMap.get(acc.Id);
                acc.Received_Paddy_Qtl__c=totalReceivedPaddyValue;
            }
            if(accountPendingPaddyPP.containskey(acc.Id))
        {
           Decimal totalPendingPaddy=accountPendingPaddyPP.get(acc.Id);
           acc.Pending_On_Platform_Qtl__c =totalPendingPaddy; 
        }
             accountsToUpdateWithRollup.add(acc);
        }
        
        // Update Accounts if needed
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    }
} 
*/
    public static void updateGrandTotalRollupSum(List<Paddy_Purchase__c> PaddyPurchases) {
    Set<Id> GeneralFarmerIds = new Set<Id>();
    
    // Step 1: Collect unique Client_farmer__c IDs
    for (Paddy_Purchase__c purchase : PaddyPurchases) {
        if (purchase.General_farmer__c != null) {
            GeneralFarmerIds.add(purchase.General_farmer__c);
        }
    }
    
    // Step 2: Query Accounts and relevant Paddy_Purchases__r in one query
    List<General_farmer__c> GeneralFarmerToUpdate = [SELECT Id, Total_Paddy_Amount__c,(SELECT Grand_Total__c FROM Paddy_Purchases__r WHERE Grand_Total__c != null) FROM General_farmer__c WHERE Id IN :GeneralFarmerIds];
    
    // Step 3: Calculate credit settlement totals and update Accounts
    Map<Id, Decimal> GenealFarmerTotalCreditMap = new Map<Id, Decimal>();
    for (General_farmer__c GF : GeneralFarmerToUpdate) {
        Decimal totalCreditValue = 0;
        
        // Calculate total credit settlement only if Paddy_Purchase__c records have valid Grand_Total__c values
        for (Paddy_Purchase__c purchase : GF.Paddy_Purchases__r) {
            if (purchase.Grand_Total__c != null) {
                totalCreditValue += purchase.Grand_Total__c;
            }
        }
        
        GenealFarmerTotalCreditMap.put(GF.Id, totalCreditValue);
    }
    
    // Step 4: Update General_farmer__c
    List<General_farmer__c> GeneralFarmerToUpdateWithRollup = new List<General_farmer__c>();
    for (General_farmer__c GF : GeneralFarmerToUpdate) {
        if (GenealFarmerTotalCreditMap.containsKey(GF.Id)) {
            Decimal totalCreditValue = GenealFarmerTotalCreditMap.get(GF.Id);
            GF.Total_Paddy_Amount__c = totalCreditValue;
            GeneralFarmerToUpdateWithRollup.add(GF);
        }
    }
    
    // Step 5: Update Accounts if needed
    if (!GeneralFarmerToUpdateWithRollup.isEmpty()) {
        update GeneralFarmerToUpdateWithRollup;
    }
}
    
    public static void updateReparentGrandTotalRollUpSum(List<Paddy_Purchase__c> OldList, List<Paddy_Purchase__c> NewList, Map<Id, Paddy_Purchase__c> PPoldmap)
    {
    Set<Id> GeneralFarmerIdsToUpdate = new Set<Id>();
    Set<Id> oldGeneralFarmerIds = new Set<Id>();
    
    // Collect General_farmer__c IDs from the new list
    for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.General_farmer__c != null) {
            GeneralFarmerIdsToUpdate.add(newPurchase.General_farmer__c);
        }
    }
    
    // Collect General_farmer__c IDs from the old map
    for (Paddy_Purchase__c oldPurchase : PPoldmap.values()) {
        if (oldPurchase.General_farmer__c != null) {
            oldGeneralFarmerIds.add(oldPurchase.General_farmer__c);
        }
    }
    
    // Combine General_farmer__c IDs from both sets
    Set<Id> combinedClientFarmerIds = new Set<Id>();
    combinedClientFarmerIds.addAll(GeneralFarmerIdsToUpdate);
    combinedClientFarmerIds.addAll(oldGeneralFarmerIds);
    
    // Update the rollup values
    if (!combinedClientFarmerIds.isEmpty()) {
        Map<Id, Decimal> GeneralFarmerGTotalMap = new Map<Id, Decimal>();
        
        // Query General_farmer__c and their related Paddy_Purchases__r
        List<General_farmer__c> GeneralFarmerToUpdate = [
            SELECT Id, Total_Paddy_Amount__c,
                (SELECT Grand_Total__c FROM Paddy_Purchases__r WHERE Grand_Total__c != null)
            FROM General_farmer__c
            WHERE Id IN :combinedClientFarmerIds
        ];
        
        // Calculate credit settlement totals and update General_farmer__c
        for (General_farmer__c GF : GeneralFarmerToUpdate) {
            Decimal totalCreditValue = 0;
            
            // Calculate total Paddy Amount only if Paddy_Purchase__c records have valid Grand Total values
            for (Paddy_Purchase__c purchase : GF.Paddy_Purchases__r) {
                if (purchase.Grand_Total__c != null) {
                    totalCreditValue += purchase.Grand_Total__c;
                }
            }
            
            GeneralFarmerGTotalMap.put(GF.Id, totalCreditValue);
        }
        
        // Update General_farmer__c
        List<General_farmer__c> GeneralFarmerToUpdateWithRollup = new List<General_farmer__c>();
        for (General_farmer__c GF : GeneralFarmerToUpdate) {
            if (GeneralFarmerGTotalMap.containsKey(GF.Id)) {
                Decimal totalCreditValue = GeneralFarmerGTotalMap.get(GF.Id);
                GF.Total_Paddy_Amount__c = totalCreditValue;
                GeneralFarmerToUpdateWithRollup.add(GF);
            }
        }
        
        // Update Accounts if needed
        if (!GeneralFarmerToUpdateWithRollup.isEmpty()) {
            update GeneralFarmerToUpdateWithRollup;
        }
    }
} 
    
    public static void updateAmountSupplyBillRollupSum(List<Paddy_Purchase__c> PaddyPurchases) {
    Set<Id> SupplyBillNoIds = new Set<Id>();
    Set<Id> SupplyBillNo2ndAttemptIds = new Set<Id>();
    // Step 1: Collect unique Supply_Bill_No__c IDs
    for (Paddy_Purchase__c purchase : PaddyPurchases) {
        if (purchase.Supply_Bill_No__c != null) {
            SupplyBillNoIds.add(purchase.Supply_Bill_No__c);
        }
         if (purchase.Supply_Bill_No_2nd_Attempt__c != null) {
                supplyBillNo2ndAttemptIds.add(purchase.Supply_Bill_No_2nd_Attempt__c);
            }
    }
     String WithLooseRecordTypeLabel = System.Label.WithLooseRecordTypeId;// RecordType of Supply bill
     String WithOutLooseRecordTypeLabel = System.Label.WithOutLooseRecordTypeId;
    
    List<Supply_Billing__c> SupplyBillingToUpdate = new List<Supply_Billing__c>();
    // Query for related records from the first child relationship
    List<Supply_Billing__c> SupplyBillingToUpdate1 = [
        SELECT Id, Amount__c, Total_Bags__c, Total_Paddy_Quantity__c,RecordTypeID,
            (SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c, Sold_Quantity_1st_Attempt__c,Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c
               FROM Paddy_Purchases__r )
        FROM Supply_Billing__c WHERE Id IN :SupplyBillNoIds];
      
    // Query for related records from the second child relationship
   // system.debug(SupplyBillNo2ndAttemptIds);
    List<Supply_Billing__c> SupplyBillingToUpdate2 = [
        SELECT Id, Amount__c, Total_Bags__c, Total_Paddy_Quantity__c,RecordTypeID,
            (SELECT Sold_Quantity_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Bags_2nd_Attempt__c FROM Paddy_Purchases1__r)
        FROM Supply_Billing__c WHERE Id IN :SupplyBillNo2ndAttemptIds];
  //  system.debug(SupplyBillingToUpdate2);
    // Combine the results into a single list
    SupplyBillingToUpdate.addAll(SupplyBillingToUpdate1);
    SupplyBillingToUpdate.addAll(SupplyBillingToUpdate2);     
    system.debug(SupplyBillingToUpdate);
    // Step 3: Calculate credit settlement totals and update Accounts
    Map<Id, Decimal>SupplyBillingTotalCreditMap = new Map<Id, Decimal>();   
    Map<Id, Decimal>SupplyBillingTotalBagMap = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalPaddyQuntityCreditMap = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalCreditMap2 = new Map<Id, Decimal>();   
    Map<Id, Decimal>SupplyBillingTotalBagMap2 = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalPaddyQuntityCreditMap2 = new Map<Id, Decimal>();
    Map<id, String>SBIdWiseRecordType=new Map<id, String>();
        for (Supply_Billing__c SB : SupplyBillingToUpdate1){
            SupplyBillingTotalCreditMap.put(SB.ID,0);
            SupplyBillingTotalBagMap.put(SB.ID,0);
            SupplyBillingTotalPaddyQuntityCreditMap.put(SB.ID,0);
            SBIdWiseRecordType.put(SB.Id,SB.RecordTypeId);
        }
         for (Supply_Billing__c SB : SupplyBillingToUpdate2){
            SupplyBillingTotalCreditMap2.put(SB.ID,0);
            SupplyBillingTotalBagMap2.put(SB.ID,0);
            SupplyBillingTotalPaddyQuntityCreditMap2.put(SB.ID,0);
        }
  for (Paddy_Purchase__c SB : [SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c, Sold_Quantity_1st_Attempt__c,Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,
            Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c, Supply_Bill_No__c FROM Paddy_Purchase__c where Supply_Bill_No__c IN:SupplyBillNoIds]) {
                 if(SBIdWiseRecordType.get(SB.Supply_Bill_No__c)==WithLooseRecordTypeLabel){
                      if(SB.Paddy_Amount__c!=null)
                      {
                      SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Paddy_Amount__c);// need to check which field to be rollup
                      }
                     if(SB.Bag__c!=null)
                     {
                      SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Bag__c);// i have done for bag
                      }
                     if(SB.Total_Paddy_Quantity__c!=null){
                      SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Total_Paddy_Quantity__c);// need to check which field to be rollup           
                  }
                  } 
                else{
                    if(SB.Master_Loose_Quantity__c!=null)
                    {
                         SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Master_Loose_Quantity__c);// need to check which field to be rollup
                    }
                    if(SB.Master_Loose_Amount__c!=null)
                 {
                  SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Master_Loose_Amount__c);// need to check which field to be rollup
                 }
                
                 if(SB.Total_Master_Loose_Bags__c!=null)
                 {
                  SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Total_Master_Loose_Bags__c);// i have done for bag
                 }
                    
                 if(SB.Sold_Paddy_Amount_1st_Attempt__c!=null)
                 {
                  SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Sold_Paddy_Amount_1st_Attempt__c);// need to check which field to be rollup
                 }
                
                 if(SB.Sold_Bags_1st_Attempt__c!=null)
                 {
                  SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Sold_Bags_1st_Attempt__c);// i have done for bag
                 }
                 if(SB.Sold_Quantity_1st_Attempt__c!=null)
                 {
                  SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Sold_Quantity_1st_Attempt__c);// need to check which field to be rollup           
                 }
              }
    }
        for(Paddy_Purchase__c SB:[SELECT Sold_Quantity_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Bags_2nd_Attempt__c, Supply_Bill_No_2nd_Attempt__c FROM Paddy_Purchase__c where Supply_Bill_No_2nd_Attempt__c IN:SupplyBillNo2ndAttemptIds]){
            if(SB.Sold_Paddy_Amount_2nd_Attempt__c!=null){
                SupplyBillingTotalCreditMap2.put(SB.Supply_Bill_No_2nd_Attempt__c, SupplyBillingTotalCreditMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Paddy_Amount_2nd_Attempt__c);// need to check which field to be rollup
            }
             if(SB.Sold_Bags_2nd_Attempt__c!=null){
                 SupplyBillingTotalBagMap2.put(SB.Supply_Bill_No_2nd_Attempt__c,SupplyBillingTotalBagMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Bags_2nd_Attempt__c);// i have done for bag
             }
            if(SB.Sold_Quantity_2nd_Attempt__c!=null){
            SupplyBillingTotalPaddyQuntityCreditMap2.put(SB.Supply_Bill_No_2nd_Attempt__c,SupplyBillingTotalPaddyQuntityCreditMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Quantity_2nd_Attempt__c);// need to check which field to be rollup
            }
            }
               
        /*System.debug(SupplyBillingTotalPaddyQuntityCreditMap2.values());
         System.debug(SupplyBillingTotalBagMap2.values());
         System.debug(SupplyBillingTotalCreditMap2.values());
         System.debug(SupplyBillingTotalPaddyQuntityCreditMap.values());
         System.debug(SupplyBillingTotalBagMap.values());
         System.debug(SupplyBillingTotalCreditMap.values());*/
    // Step 4: Update Supply_Billing__c
    List<Supply_Billing__c> SupplyBillingToUpdateWithRollup = new List<Supply_Billing__c>();
    for (Supply_Billing__c SB : SupplyBillingToUpdate) {
        Decimal totalCreditValue=0;
        Decimal totalbag=0;
        Decimal totalPaddyQuantity=0;
        if (SupplyBillingTotalCreditMap.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue+ SupplyBillingTotalCreditMap.get(SB.Id);
            SB.Amount__c = totalCreditValue;          
        }
        if (SupplyBillingTotalCreditMap2.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue+ SupplyBillingTotalCreditMap2.get(SB.Id);
            SB.Amount__c = totalCreditValue;          
        }
        if(SupplyBillingTotalBagMap.containsKey(SB.Id))
        {
             totalbag=totalbag + SupplyBillingTotalBagMap.get(SB.Id);
            SB.Total_Bags__c=  totalbag;         
        }
        if(SupplyBillingTotalBagMap2.containsKey(SB.Id))
        {
             totalbag=totalbag + SupplyBillingTotalBagMap2.get(SB.Id);
            SB.Total_Bags__c= totalbag;         
        }
         if(SupplyBillingTotalPaddyQuntityCreditMap.containskey(SB.Id))
         {
              totalPaddyQuantity= totalPaddyQuantity + SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Id);
                SB.Total_Paddy_Quantity__c= totalPaddyQuantity;         
         }  
        if(SupplyBillingTotalPaddyQuntityCreditMap2.containskey(SB.Id))
         {
              totalPaddyQuantity= totalPaddyQuantity + SupplyBillingTotalPaddyQuntityCreditMap2.get(SB.Id);
                SB.Total_Paddy_Quantity__c= totalPaddyQuantity;         
         }  
        
        SupplyBillingToUpdateWithRollup.add(SB);
    }     
    // Step 5: Update Accounts if needed
    if (!SupplyBillingToUpdateWithRollup.isEmpty()) {
        update SupplyBillingToUpdateWithRollup;
    }
}
    
   public static void updateReparentSupplyBillingAmountRollUpSum(List<Paddy_Purchase__c> OldList, List<Paddy_Purchase__c> NewList, Map<Id, Paddy_Purchase__c> PPoldmap)
    {
    Set<Id> SupplyBillIdsToUpdate = new Set<Id>();
    Set<Id> oldSupplyBillIds = new Set<Id>();
    Set<Id> SupplyBillAttempt2 = new Set<Id>();
    Set<Id> oldSupplyBillAttempt2 = new Set<Id>();
    
    // Collect Supply_Bill_No__c IDs from the new list
    for (Paddy_Purchase__c newPurchase : NewList) {
        if (newPurchase.Supply_Bill_No__c != null) {
            system.debug(newPurchase.Supply_Bill_No__c);
            SupplyBillIdsToUpdate.add(newPurchase.Supply_Bill_No__c);
        }
        system.debug(newPurchase.Supply_Bill_No_2nd_Attempt__c);
        if(newPurchase.Supply_Bill_No_2nd_Attempt__c!=null)
        {
            system.debug(newPurchase.Supply_Bill_No_2nd_Attempt__c);
            SupplyBillAttempt2.add(newPurchase.Supply_Bill_No_2nd_Attempt__c);
        }
    }
    
    // Collect Supply_Bill_No__c IDs from the old map
    for (Paddy_Purchase__c oldPurchase : PPoldmap.values()) {
        if (oldPurchase.Supply_Bill_No__c != null) {
            oldSupplyBillIds.add(oldPurchase.Supply_Bill_No__c);
        }
        if (oldPurchase.Supply_Bill_No_2nd_Attempt__c != null) {
            oldSupplyBillAttempt2.add(oldPurchase.Supply_Bill_No_2nd_Attempt__c);
        }
    }    
    // Combine Supply_Billing__c IDs from both sets
    Set<Id> combinedClientFarmerIds = new Set<Id>();
     Set<Id> SupplyBillAttempt2Ids = new Set<Id>();
    combinedClientFarmerIds.addAll(SupplyBillIdsToUpdate);
    combinedClientFarmerIds.addAll(oldSupplyBillIds);
    combinedClientFarmerIds.addAll(SupplyBillAttempt2);
    combinedClientFarmerIds.addAll(oldSupplyBillAttempt2);  
    SupplyBillAttempt2Ids.addAll(SupplyBillAttempt2);
    SupplyBillAttempt2Ids.addAll(oldSupplyBillAttempt2);  
    
        String WithLooseRecordTypeLabel = System.Label.WithLooseRecordTypeId;
       String myCustomLabe2 = System.Label.WithOutLooseRecordTypeId;  
   
    // Query for related records from the first child relationship
    List<Supply_Billing__c> SupplyBillingToUpdate = new List<Supply_Billing__c>();
    // Query for related records from the first child relationship
    List<Supply_Billing__c> SupplyBillingToUpdate1 = [
        SELECT Id, Amount__c, Total_Bags__c, Total_Paddy_Quantity__c,RecordTypeID,
            (SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c, Sold_Quantity_1st_Attempt__c,Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c
               FROM Paddy_Purchases__r )
        FROM Supply_Billing__c WHERE Id IN :combinedClientFarmerIds];
      
    // Query for related records from the second child relationship
   //   system.debug(SupplyBillingToUpdate1);
    List<Supply_Billing__c> SupplyBillingToUpdate2 = [
        SELECT Id, Amount__c, Total_Bags__c, Total_Paddy_Quantity__c,RecordTypeID,
            (SELECT Sold_Quantity_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Bags_2nd_Attempt__c FROM Paddy_Purchases1__r)
        FROM Supply_Billing__c WHERE Id IN :combinedClientFarmerIds];
   // system.debug(SupplyBillingToUpdate2);
    
    map<Id, Supply_Billing__c>SBrecords=New map<Id, Supply_Billing__c>();
    SupplyBillingToUpdate.addAll(SupplyBillingToUpdate1);
    SupplyBillingToUpdate.addAll(SupplyBillingToUpdate2);     
 //   system.debug(SupplyBillingToUpdate);
        
    Map<Id, Decimal>SupplyBillingTotalCreditMap = new Map<Id, Decimal>();   
    Map<Id, Decimal>SupplyBillingTotalBagMap = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalPaddyQuntityCreditMap = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalCreditMap2 = new Map<Id, Decimal>();   
    Map<Id, Decimal>SupplyBillingTotalBagMap2 = new Map<Id, Decimal>();
    Map<Id, Decimal>SupplyBillingTotalPaddyQuntityCreditMap2 = new Map<Id, Decimal>(); 
    Map<id, String>SBIdWiseRecordType=new Map<id, String>();
        // Calculate credit settlement totals and update Supply_Billing__c
        // 
        for (Supply_Billing__c SB : SupplyBillingToUpdate1){
            SBrecords.put(SB.ID, SB);
            SupplyBillingTotalCreditMap.put(SB.ID,0);
            SupplyBillingTotalBagMap.put(SB.ID,0);
            SupplyBillingTotalPaddyQuntityCreditMap.put(SB.ID,0);
            SBIdWiseRecordType.put(SB.Id,SB.RecordTypeId);
        }
        
        for (Supply_Billing__c SB : SupplyBillingToUpdate2){
            SBrecords.put(SB.ID, SB);
            SupplyBillingTotalCreditMap2.put(SB.ID,0);
            SupplyBillingTotalBagMap2.put(SB.ID,0);
            SupplyBillingTotalPaddyQuntityCreditMap2.put(SB.ID,0);
        }
  for (Paddy_Purchase__c SB : [SELECT Paddy_Amount__c, Bag__c, Total_Paddy_Quantity__c, Sold_Quantity_1st_Attempt__c,Sold_Paddy_Amount_1st_Attempt__c,Sold_Bags_1st_Attempt__c,
                               Master_Loose_Quantity__c,Total_Master_Loose_Bags__c,Master_Loose_Amount__c,
             Supply_Bill_No__c FROM Paddy_Purchase__c where Supply_Bill_No__c IN:SBIdWiseRecordType.keyset()]) 
  
              {
                  
                if(SBIdWiseRecordType.get(SB.Supply_Bill_No__c)==WithLooseRecordTypeLabel){
                      if(SB.Paddy_Amount__c!=null){
                  SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Paddy_Amount__c);// need to check which field to be rollup
             }
               if(SB.Bag__c!=null)
               {
                  SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Bag__c);// i have done for bag
                }
                  if(SB.Total_Paddy_Quantity__c!=null){
                      SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Total_Paddy_Quantity__c);// need to check which field to be rollup           
                  }
                 }
                //  system.debug(SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c));
                  else{  
                      if(SB.Master_Loose_Quantity__c!=null)
                    {
                         SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Master_Loose_Quantity__c);// need to check which field to be rollup
                    }
                    if(SB.Master_Loose_Amount__c!=null)
                 {
                  SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Master_Loose_Amount__c);// need to check which field to be rollup
                 }
                
                 if(SB.Total_Master_Loose_Bags__c!=null)
                 {
                  SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Total_Master_Loose_Bags__c);// i have done for bag
                 }
                      
                 if(SB.Sold_Paddy_Amount_1st_Attempt__c!=null ){
                  SupplyBillingTotalCreditMap.put(SB.Supply_Bill_No__c, SupplyBillingTotalCreditMap.get(SB.Supply_Bill_No__c)+SB.Sold_Paddy_Amount_1st_Attempt__c);// need to check which field to be rollup
        }
           if(SB.Sold_Bags_1st_Attempt__c!=null){
               SupplyBillingTotalBagMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalBagMap.get(SB.Supply_Bill_No__c)+SB.Sold_Bags_1st_Attempt__c);// i have done for bag
           }
                  if(SB.Sold_Quantity_1st_Attempt__c!=null){
                      SupplyBillingTotalPaddyQuntityCreditMap.put(SB.Supply_Bill_No__c,SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Supply_Bill_No__c)+SB.Sold_Quantity_1st_Attempt__c);// need to check which field to be rollup           
                  }
                  }
    }
        for(Paddy_Purchase__c SB:[SELECT Sold_Quantity_2nd_Attempt__c,Sold_Paddy_Amount_2nd_Attempt__c,Sold_Bags_2nd_Attempt__c, Supply_Bill_No_2nd_Attempt__c FROM Paddy_Purchase__c where Supply_Bill_No_2nd_Attempt__c IN:SBIdWiseRecordType.keyset()]){
            if(SB.Sold_Paddy_Amount_2nd_Attempt__c!=null){
                SupplyBillingTotalCreditMap2.put(SB.Supply_Bill_No_2nd_Attempt__c, SupplyBillingTotalCreditMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Paddy_Amount_2nd_Attempt__c);// need to check which field to be rollup
            }
             if(SB.Sold_Bags_2nd_Attempt__c!=null){
                 SupplyBillingTotalBagMap2.put(SB.Supply_Bill_No_2nd_Attempt__c,SupplyBillingTotalBagMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Bags_2nd_Attempt__c);// i have done for bag
             }
            if(SB.Sold_Quantity_2nd_Attempt__c!=null){
            SupplyBillingTotalPaddyQuntityCreditMap2.put(SB.Supply_Bill_No_2nd_Attempt__c,SupplyBillingTotalPaddyQuntityCreditMap2.get(SB.Supply_Bill_No_2nd_Attempt__c)+SB.Sold_Quantity_2nd_Attempt__c);// need to check which field to be rollup
            }
            }     
     /*    System.debug(SupplyBillingTotalPaddyQuntityCreditMap2.values());
         System.debug(SupplyBillingTotalBagMap2.values());
         System.debug(SupplyBillingTotalCreditMap2.values());
         System.debug(SupplyBillingTotalPaddyQuntityCreditMap.values());
         System.debug(SupplyBillingTotalBagMap.values());
         System.debug(SupplyBillingTotalCreditMap.values()); */
        // Update Supply_Billing__c
        List<Supply_Billing__c> SupplyBillingToUpdateWithRollup = new List<Supply_Billing__c>();
    for (Supply_Billing__c SB : SBrecords.values()) {
        Decimal totalCreditValue=0;
        Decimal totalbag=0;
        Decimal totalPaddyQuantity=0;
        if (SupplyBillingTotalCreditMap.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue+ SupplyBillingTotalCreditMap.get(SB.Id);             
        }
        if (SupplyBillingTotalCreditMap2.containsKey(SB.Id)) {
             totalCreditValue =totalCreditValue+ SupplyBillingTotalCreditMap2.get(SB.Id);         
        }
        if(SupplyBillingTotalBagMap.containsKey(SB.Id))
        {
             totalbag=totalbag+SupplyBillingTotalBagMap.get(SB.Id);         
        }
        if(SupplyBillingTotalBagMap2.containsKey(SB.Id))
        {
             totalbag=totalbag+SupplyBillingTotalBagMap2.get(SB.Id);
                   
        }
         if(SupplyBillingTotalPaddyQuntityCreditMap.containskey(SB.Id))
         {
              totalPaddyQuantity=totalPaddyQuantity+SupplyBillingTotalPaddyQuntityCreditMap.get(SB.Id);
                       
         }  
        if(SupplyBillingTotalPaddyQuntityCreditMap2.containskey(SB.Id))
         {
              totalPaddyQuantity=totalPaddyQuantity+SupplyBillingTotalPaddyQuntityCreditMap2.get(SB.Id);
                        
         }  
        SB.Amount__c = totalCreditValue; 
        SB.Total_Bags__c=totalbag;
        SB.Total_Paddy_Quantity__c= totalPaddyQuantity; 
        SupplyBillingToUpdateWithRollup.add(SB);
    }      
        // Update Accounts if needed
        if (!SupplyBillingToUpdateWithRollup.isEmpty()) {
            update SupplyBillingToUpdateWithRollup;
        }
    }      
       
}