public class SaleInvoiceTriggerHandler
{
    Public static void updateTotalInvRollupsum(List<Sale_Invoice__c>FCList){
        Set<string>ClientFarmerId=new Set<String>();
        
        map<Id, String>CfIdFatherMap=new map<Id, String>();
        map<Id, String>CfIdAadharMap=new map<Id, String>();
        map<Id, String>CfIdPhoneMap=new map<Id, String>();
        map<Id, String>CfIdVillageMap=new map<Id, String>();
        map<Id, String>CfIdDistrictMap=new map<Id, String>();
        map<Id, String>CfIdBlockMap=new map<Id, String>();
        for(Sale_Invoice__c SI:FCList){
                if(SI.Client_farmer__c!=null){
              ClientFarmerId.add(SI.Client_farmer__c);  
                if(SI.Father_Name__c!=null){
                    CfIdFatherMap.put(SI.Client_farmer__c,SI.Father_Name__c);
                }
                if(SI.Adhaar_Card_No__c!=null){
                    CfIdAadharMap.put(SI.Client_farmer__c,SI.Adhaar_Card_No__c);
                }
                if(SI.Village__c!=null){
                    CfIdVillageMap.put(SI.Client_farmer__c,SI.Village__c);
                }
                if(SI.Block__c!=null){
                    CfIdBlockMap.put(SI.Client_farmer__c,SI.Block__c);
                }
                if(SI.District__c!=null){
                    CfIdDistrictMap.put(SI.Client_farmer__c,SI.District__c);
                }
                if(SI.Phone__c!=null){
                    CfIdPhoneMap.put(SI.Client_farmer__c,SI.Phone__c);
                }
            }
               
        }
        map<Id,Integer>AccountTotalKitAreaMap=new map<Id,Integer>();
        map<Id,Integer>AccountTotalKitPlotsMap=new map<Id,Integer>();
        Map<Id, Decimal> accountTotalCreditMap = new Map<Id, Decimal>();
        Map<Id, integer> accountInvoiceCount = new Map<Id, integer>();
      
        List<Account> accountsToUpdate = [SELECT Id,Total_Invoice_Value__c ,Total_Kit_Area__c,Total_Plot__c, Father_Name__c,Aadhar_Card_No__c,Village__c,Block__c,District__c,Phone FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id, (SELECT Total_Invoice_Value__c,Kit_Area__c,Kit_Plots__c FROM Sale_Invoices1__r) from Account where id in:ClientFarmerId];
           
        for (Account acc : accountsToUpdate) {
            accountTotalCreditMap.put(acc.Id, 0);
            accountInvoiceCount.put(acc.Id,0);
            AccountTotalKitAreaMap.put(acc.Id,0);
            AccountTotalKitPlotsMap.put(acc.Id,0);
        }
         system.debug(AccountTotalKitAreaMap.size() + 'AccountTotalKitPlotsMap.size' + AccountTotalKitPlotsMap.size());
        for (Sale_Invoice__c CF : [SELECT Client_farmer__c, Total_Invoice_Value__c,Kit_Area__c,Kit_Plots__c FROM Sale_Invoice__c WHERE Client_farmer__c IN :ClientFarmerId]) {
            accountTotalCreditMap.put(CF.Client_farmer__c, accountTotalCreditMap.get(CF.Client_farmer__c) + CF.Total_Invoice_Value__c);
            accountInvoiceCount.put(CF.Client_farmer__c, accountInvoiceCount.get(CF.Client_farmer__c) + 1);
            
            integer KitArea=0;
            if(CF.Kit_Area__c!=null){
                KitArea=Integer.valueof(CF.Kit_Area__c);
            }
            Integer KitPlot=0;
            if(CF.Kit_Plots__c!=null){
                KitPlot=Integer.valueof(CF.Kit_Plots__c);
            }
            AccountTotalKitAreaMap.put(CF.Client_farmer__c,AccountTotalKitAreaMap.get(CF.Client_farmer__c) + KitArea);
            AccountTotalKitPlotsMap.put(CF.Client_farmer__c,AccountTotalKitPlotsMap.get(CF.Client_farmer__c) + KitPlot);
        }
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        for (Account acc : accountsToUpdate) {
            Decimal totalCreditValue = accountTotalCreditMap.get(acc.Id);
            acc.Total_Invoice_Value__c = totalCreditValue;
            acc.Total_Sale_Invoice_Count__c=accountInvoiceCount.get(acc.Id);
            acc.Total_Kit_Area__c=AccountTotalKitAreaMap.get(acc.Id);
            acc.Total_Plot__c=AccountTotalKitPlotsMap.get(acc.Id);
             if(acc.Aadhar_Card_No__c!=CfIdAadharMap.get(acc.id) && CfIdAadharMap.get(acc.id)!=null){
               acc.Aadhar_Card_No__c= CfIdAadharMap.get(acc.id);
            }
            if(acc.Block__c!=CfIdBlockMap.get(acc.id) && CfIdBlockMap.get(acc.id)!=null){
               acc.Block__c= CfIdBlockMap.get(acc.id);
            }
            if(acc.District__c!=CfIdDistrictMap.get(acc.id) && CfIdDistrictMap.get(acc.id)!=null){
               acc.District__c= CfIdDistrictMap.get(acc.id);
            }
             system.debug(acc.Father_Name__c +'AND'+CfIdFatherMap.get(acc.id));
            if(acc.Father_Name__c!=CfIdFatherMap.get(acc.id)&& CfIdFatherMap.get(acc.id)!=null){
               
               acc.Father_Name__c= CfIdFatherMap.get(acc.id);
            }
            if(acc.Phone!=CfIdPhoneMap.get(acc.id)&& CfIdPhoneMap.get(acc.id)!=null){
               acc.Phone= CfIdPhoneMap.get(acc.id);
            }
            if(acc.Village__c!=CfIdVillageMap.get(acc.id)&& CfIdVillageMap.get(acc.id)!=null){
               acc.Village__c= CfIdVillageMap.get(acc.id);
            }
            accountsToUpdateWithRollup.add(acc);
        }
        
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Public static void UpdateReparentTotalInvRollUpSum(list<Sale_Invoice__c>OldList, List<Sale_Invoice__c>NewList, map<id,Sale_Invoice__c>SIoldmap){
        Set<string>ClientFarmerId=new Set<String>();
        map<Id, String>CfIdFatherMap=new map<Id, String>();
        map<Id, String>CfIdAadharMap=new map<Id, String>();
        map<Id, String>CfIdPhoneMap=new map<Id, String>();
        map<Id, String>CfIdVillageMap=new map<Id, String>();
        map<Id, String>CfIdDistrictMap=new map<Id, String>();
        map<Id, String>CfIdBlockMap=new map<Id, String>();
        for(Sale_Invoice__c SI:NewList){
            if(SI.Client_farmer__c!=null){
              ClientFarmerId.add(SI.Client_farmer__c);  
                if(SI.Father_Name__c!=null){
                    CfIdFatherMap.put(SI.Client_farmer__c,SI.Father_Name__c);
                }
                if(SI.Adhaar_Card_No__c!=null){
                    CfIdAadharMap.put(SI.Client_farmer__c,SI.Adhaar_Card_No__c);
                }
                if(SI.Village__c!=null){
                    CfIdVillageMap.put(SI.Client_farmer__c,SI.Village__c);
                }
                if(SI.Block__c!=null){
                    CfIdBlockMap.put(SI.Client_farmer__c,SI.Block__c);
                }
                if(SI.District__c!=null){
                    CfIdDistrictMap.put(SI.Client_farmer__c,SI.District__c);
                }
                if(SI.Phone__c!=null){
                    CfIdPhoneMap.put(SI.Client_farmer__c,SI.Phone__c);
                }
            }
            
            if(SI.Client_farmer__c!= SIoldmap.get(SI.id).Client_farmer__c){
                //ClientFarmerId.add(SI.Client_farmer__c);
                if(SIoldmap.get(SI.id).Client_farmer__c!=null){
                 ClientFarmerId.add(SIoldmap.get(SI.id).Client_farmer__c);   
                }
                
            }
        }
        if(ClientFarmerId.size()>0){
            //list<String, list<Sale_Invoice__c>>
        map<Id,Integer>AccountTotalKitAreaMap=new map<Id,Integer>();
        map<Id,Integer>AccountTotalPlotMap=new map<Id,Integer>();
        Map<Id, Decimal> accountTotalInvoiceMap = new Map<Id, Decimal>();
        Map<Id, integer> accountInvoiceCount = new Map<Id, integer>();
            
        List<Account> accountsToUpdate = [SELECT Id, Father_Name__c,Aadhar_Card_No__c,Village__c,Block__c,District__c,Phone FROM Account WHERE Id IN :ClientFarmerId];
        list<Account>CFList=[Select Id, (SELECT Total_Invoice_Value__c,Kit_Area__c,Kit_Plots__c FROM Sale_Invoices1__r) from Account where id in:ClientFarmerId];
        Map<Id, Account>CfIdMap= new map<id, Account>();
        if(accountsToUpdate.size()>0){
          for (Account acc : accountsToUpdate) {
              CfIdMap.put(acc.id, acc);
            accountTotalInvoiceMap.put(acc.Id, 0);
            accountInvoiceCount.put(acc.Id,0);
            AccountTotalKitAreaMap.put(acc.Id,0);
            AccountTotalPlotMap.put(acc.Id,0);  
        }  
        }
        
        for (Sale_Invoice__c invoice : [SELECT Client_farmer__c, Total_Invoice_Value__c,Kit_Area__c,Kit_Plots__c FROM Sale_Invoice__c WHERE Client_farmer__c IN :ClientFarmerId]) {
            accountTotalInvoiceMap.put(invoice.Client_farmer__c, accountTotalInvoiceMap.get(invoice.Client_farmer__c) + invoice.Total_Invoice_Value__c);
            accountInvoiceCount.put(invoice.Client_farmer__c, accountInvoiceCount.get(invoice.Client_farmer__c) + 1);
            if(String.isNotEmpty(invoice.Kit_Area__c)){
               AccountTotalKitAreaMap.put(invoice.Client_farmer__c,AccountTotalKitAreaMap.get(invoice.Client_farmer__c) + Integer.valueof(invoice.Kit_Area__c));   
            }
            if(String.isNotEmpty(invoice.Kit_Plots__c)){
            AccountTotalPlotMap.put(invoice.Client_farmer__c,AccountTotalPlotMap.get(invoice.Client_farmer__c) + Integer.valueof(invoice.Kit_Plots__c));    
            }}
        List<Account> accountsToUpdateWithRollup = new List<Account>();
        for (Account acc : accountsToUpdate) {
            Decimal totalInvoiceValue = accountTotalInvoiceMap.get(acc.Id);
            acc.Total_Invoice_Value__c = totalInvoiceValue;
            acc.Total_Sale_Invoice_Count__c=accountInvoiceCount.get(acc.Id);
            acc.Total_Kit_Area__c=AccountTotalKitAreaMap.get(acc.Id);
            acc.Total_Plot__c=AccountTotalPlotMap.get(acc.Id);
             if(acc.Aadhar_Card_No__c!=CfIdAadharMap.get(acc.id) && CfIdAadharMap.get(acc.id)!=null){
               acc.Aadhar_Card_No__c= CfIdAadharMap.get(acc.id);
            }
            if(acc.Block__c!=CfIdBlockMap.get(acc.id) && CfIdBlockMap.get(acc.id)!=null){
               acc.Block__c= CfIdBlockMap.get(acc.id);
            }
            if(acc.District__c!=CfIdDistrictMap.get(acc.id) && CfIdDistrictMap.get(acc.id)!=null){
               acc.District__c= CfIdDistrictMap.get(acc.id);
            }
             system.debug(acc.Father_Name__c +'AND'+CfIdFatherMap.get(acc.id));
            if(acc.Father_Name__c!=CfIdFatherMap.get(acc.id)&& CfIdFatherMap.get(acc.id)!=null){
               
               acc.Father_Name__c= CfIdFatherMap.get(acc.id);
            }
            if(acc.Phone!=CfIdPhoneMap.get(acc.id)&& CfIdPhoneMap.get(acc.id)!=null){
               acc.Phone= CfIdPhoneMap.get(acc.id);
            }
            if(acc.Village__c!=CfIdVillageMap.get(acc.id)&& CfIdVillageMap.get(acc.id)!=null){
               acc.Village__c= CfIdVillageMap.get(acc.id);
            }
            accountsToUpdateWithRollup.add(acc);
        }
        
        if (!accountsToUpdateWithRollup.isEmpty()) {
            update accountsToUpdateWithRollup;
        }   
        }
       
    }
    public static void PopulateFarmerCodes(List<Sale_Invoice__c>FarmerCodeSaleInvoice)
    {
        Set<String> farmerCodes = new Set<String>();
        for(Sale_Invoice__c ObjSaleInv: FarmerCodeSaleInvoice)
        {
            String farmerCode;
            if(ObjSaleInv.Party_name__C!=null ||ObjSaleInv.Party_name__C!='')
            {
                String s1 = ObjSaleInv.Party_name__C;
                String s2 = s1.substringBefore('(');
                farmerCode=s2.remove(' ');
                farmerCodes.add(farmerCode);              
            }            
        }
        
        // Query for existing Client Farmer records with matching Farmer Codes
        Map<String, account> FarmerCodecFarmerMap = new Map<String, account>();
        list<account>ExistingFarmerList=[select id,name,Farmer_Code__c from account where Farmer_Code__c IN:farmerCodes ];
        if(ExistingFarmerList.size()>0)
        {
            for (account clientFarmer : ExistingFarmerList) 
            {
                FarmerCodecFarmerMap.put(clientFarmer.Farmer_Code__c, clientFarmer);
            }
        }   
        
        for (Sale_Invoice__c invoice : FarmerCodeSaleInvoice)
        {
            String farmerCode;
            String FarmerName;
            if(invoice.Party_name__C!=null ||invoice.Party_name__C!=''){
                String s1 = invoice.Party_name__C;
                String s2 = s1.substringBefore('(');
                farmerCode=s2.remove(' ');
                FarmerName=invoice.Party_name__C.substringBetween('(',')');
                invoice.Farmer_code__c=farmerCode;
                //invoice.Party_name__C=FarmerName;
                if (FarmerCodecFarmerMap.containsKey(invoice.Farmer_Code__c)) 
                {
                    invoice.Client_Farmer__c = FarmerCodecFarmerMap.get(invoice.Farmer_Code__c).Id;                    }
            }  
        }  
    }
    
    public static void PopulatePartySaleInvoice(List<Sale_Invoice__c>SaleInvoiceNewList) 
    {
        set<String>Farmercodes=new Set<String>();
        List<Sale_Invoice__c>InvoiceListToUpdate=new List<Sale_Invoice__c>();  
        list<account>ClientFarmerList=new list<account>();
        // Collect all unique Farmer Codes from the SaleInvoices being inserted 
        for (Sale_Invoice__c invoice : SaleInvoiceNewList) {
            farmerCodes.add(invoice.Farmer_Code__c);
        }
        // Query for existing Client Farmer records with matching Farmer Codes
        Map<String, account> clientFarmers = new Map<String, account>();
        Map<String, account> NewclientFarmers = new Map<String, account>();
        list<account>ExistingFarmerList=[select id,name,Farmer_Code__c from account where Farmer_Code__c IN:farmerCodes ];
        if(ExistingFarmerList.size()>0)
        {
            for (account clientFarmer : ExistingFarmerList) 
            {
                clientFarmers.put(clientFarmer.Farmer_Code__c, clientFarmer);
            }
        }   
        // Create a new Client Farmer if it doesn't exist, and populate lookup field in SaleInvoice
        map<String, Account>FarmercodewiseClientMap=new map<String, Account>();
        for (Sale_Invoice__c invoice : SaleInvoiceNewList) {
            if (!clientFarmers.containsKey(invoice.Farmer_Code__c)) 
            {
                // Create a new Client Farmer record
                Account newClientFarmer=new Account();
                newClientFarmer.Farmer_Code__c=invoice.Farmer_Code__c;
                    newClientFarmer.Name = invoice.Party_name__c;
                    newClientFarmer.Father_Name__c=invoice.Father_Name__c;
                    newClientFarmer.Aadhar_Card_No__c=invoice.Adhaar_Card_No__c;
                    newClientFarmer.Village__c=invoice.Village__c;
                    newClientFarmer.Block__c=invoice.Block__c;
                    newClientFarmer.District__c=invoice.District__c;
                    newClientFarmer.Phone = invoice.Phone__c;    
                //ClientFarmerList.add(newClientFarmer);
                FarmercodewiseClientMap.put(invoice.Farmer_Code__c,newClientFarmer);
                // Update the lookup field on the SaleInvoice to the newly created Client Farmer record
                //invoice.Client_Farmer__c = newClientFarmer.Id;
            } 
        }  
        ClientFarmerList.addAll(FarmercodewiseClientMap.values());
        if(ClientFarmerList.size()>0){
            insert ClientFarmerList;
            for(Account CF:ClientFarmerList){
                NewclientFarmers.put(CF.Farmer_Code__c, CF);
            }
            for (Sale_Invoice__c invoice : SaleInvoiceNewList) {
                if(NewclientFarmers.containskey(invoice.Farmer_Code__c)){
                    Sale_Invoice__c SI=new Sale_Invoice__c();
                    SI.Id=invoice.id;
                    //SI.Name=invoice.Name;
                    SI.Client_Farmer__c=NewclientFarmers.get(invoice.Farmer_Code__c).Id;
                    InvoiceListToUpdate.add(SI);
                }
                
            }
        }
        if(InvoiceListToUpdate.size()>0){
            update InvoiceListToUpdate;
        }
        Map<String, account> NewPlusExisting = new Map<String, account>();
        NewPlusExisting.putAll(NewclientFarmers);
        NewPlusExisting.putAll(clientFarmers);
        createFarmerCredit(SaleInvoiceNewList,NewPlusExisting );
    }
    
    public static void PreventDuplicateInvoiveNumber(List<Sale_Invoice__c>SaleInvoiceList)
    {
        Set<String>setInvoiceNumber= new Set<String>();
        For(Sale_Invoice__c acc:SaleInvoiceList)
        {
            setInvoiceNumber.add(acc.name);
        }
        
        if(setInvoiceNumber.size() > 0 )
        {
            List<Sale_Invoice__c>ExistingInvList = [select name ,id from Sale_Invoice__c where name IN :setInvoiceNumber ];
            
            Map<String ,Sale_Invoice__c>InvoiceNumMap = new Map<String,Sale_Invoice__c>();
            For(Sale_Invoice__c objInv: ExistingInvList)
            {
                InvoiceNumMap.put(objInv.name ,objInv);
            }
            
            
            For(Sale_Invoice__c objInv :SaleInvoiceList)
            {
                if(InvoiceNumMap.containsKey(objInv.name))
                {
                    objInv.Name.addError('Invoice Number already Exist ');
                }
            }
        }       
    }
    
    // When balance Due Amount do not blank so Farmer Credit should create
    public static void createFarmerCredit(List<Sale_Invoice__c>NewSaleInvList, Map<String, account> NewPlusExisting){
        list<Farmer_credit__c>FCtoInsert=new List<Farmer_Credit__c>();
        for(Sale_Invoice__c SI:NewSaleInvList){
            if(SI.Balance_Due__c!=NULL && SI.Balance_Due__c!=0){
                Farmer_credit__c Fc= new Farmer_credit__c();
                //system.debug('SI.Client_Farmer__c'+SI.Client_Farmer__c);
                Fc.Client_Farmer__c=NewPlusExisting.get(SI.Farmer_Code__c).id;//SI.Client_Farmer__c;
                Fc.Farmer_Code__c=SI.Farmer_Code__c;
                Fc.Father_Name__c=SI.Father_Name__c;
                Fc.Sale_Invoice__c=SI.id;
                Fc.Invoice_Number__c=SI.name;
                Fc.Balance_Due__c=SI.Balance_Due__c;
                Fc.Phone__c=SI.Phone__c;
                Fc.Total_Invoice_Value__c=SI.Balance_Due__c;
                FCtoInsert.add(Fc);
            }
        }
        
        if(FCtoInsert.size()>0){
            insert FCtoInsert; 
        }
    }
   ////////////////////////////////////////////////////////////////////////////////////////////
   //
  // Requirement changed from dependency on Transaction Type to Balance Due
  //(Now Farmer Credits are required to be created on the basis of Balance Due Amount)
    
    public static void createFarmerCreditupdatecashtocheque(List<Sale_Invoice__c>NewSaleInvList,map<id,Sale_Invoice__c>oldmap){
      /*  list<Farmer_credit__c>FCtoInsert=new List<Farmer_Credit__c>();
        for(Sale_Invoice__c SI:NewSaleInvList){
            if(SI.Payment_Type__c=='Cheque'&& oldmap.get(si.id).Payment_Type__c=='Cash'){
                Farmer_credit__c Fc= new Farmer_credit__c();
                system.debug('SI.Client_Farmer__c'+SI.Client_Farmer__c);
                Fc.Client_Farmer__c=SI.Client_Farmer__c;
                Fc.Farmer_Code__c=SI.Farmer_Code__c;
                Fc.Father_Name__c=SI.Father_Name__c;
                Fc.Sale_Invoice__c=SI.id;
                Fc.Invoice_Number__c=SI.name;
                Fc.Balance_Due__c=SI.Total_Invoice_Value__c;
                Fc.Phone__c=SI.Phone__c;
                Fc.Total_Invoice_Value__c=SI.Total_Invoice_Value__c;
                FCtoInsert.add(Fc);
            }
        }
        if(FCtoInsert.size()>0){
            insert FCtoInsert; 
        } */
    }

}