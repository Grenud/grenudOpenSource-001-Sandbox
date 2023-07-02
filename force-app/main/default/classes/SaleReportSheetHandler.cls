public class SaleReportSheetHandler 
{ 
 public static void SaleReportSheetMethod(list<Sale_Report_Sheet__c>SaleReportSheetList)
 {
      set<string>SRinvNum=new set<string>();
      map<string,string>InvNumIDMap=new map<string,string>();
      list<Sale_Invoice__c>SaleInvoiceToUpsertList=new list<Sale_Invoice__c>();
      for(Sale_Report_Sheet__c objSR:SaleReportSheetList)
      {
          if(objSR.Invoice_No__c!=null)
          {
              system.debug('objSR.Invoice_No__c@@'+objSR.Invoice_No__c);
              SRinvNum.add(objSR.Invoice_No__c);
          }
      }
      list<Sale_Invoice__c>ExistingInvoice=[SELECT Id, Transaction_Type__c, Date__c, Order_No__c, Name, Phone__c, Party_Name__c, Payment_Type__c, Description__c,
                                            Adhaar_Card_No__c, Father_Name__c, Kit_Area_Plots__c FROM Sale_Invoice__c where name in :SRinvNum];
      for(Sale_Invoice__c objinv:ExistingInvoice) 
      {
          if(objinv.Name!=null)
          {
              InvNumIDMap.put(objinv.Name,objinv.Id);
          }
      }
      for(Sale_Report_Sheet__c objSR:SaleReportSheetList)
      {
          if(InvNumIDMap.get(objSR.Invoice_No__c)!=null)
          {
              system.debug('If Triggered');
              Sale_Invoice__c SI=new Sale_Invoice__c();
              SI.Id=InvNumIDMap.get(objSR.Invoice_No__c);
              SI.Transaction_Type__c=objSR.Transaction_Type__c;
              SI.Date__c=objSR.Date__c;
              SI.Order_No__c=objSR.Order_No__c;
              SI.Phone__c=objSR.Party_Phone_No__c;
              SI.Payment_Type__c=objSR.Payment_Type__c;
              SI.Description__c=objSR.Description__c;
              SI.Adhaar_Card_No__c=objSR.Adhaar_Card_No__c;
              SI.Father_Name__c=objSR.Father_Name__c;
              SI.Kit_Area_Plots__c=objSR.Kit_Area_Plots__c;
              SaleInvoiceToUpsertList.add(SI);
          }
          else 
          {
              system.debug('Else Triggered');
              Sale_Invoice__c SI=new Sale_Invoice__c();
              SI.Transaction_Type__c=objSR.Transaction_Type__c;
              SI.Name=objSR.Invoice_no__c;
              SI.Total_Invoice_Value__c=objSR.Total_Amount__c;
              SI.Date__c=objSR.Date__c;
              SI.Order_No__c=objSR.Order_No__c;
              SI.Phone__c=objSR.Party_Phone_No__c;
              SI.Payment_Type__c=objSR.Payment_Type__c;
              SI.Description__c=objSR.Description__c;
              SI.Adhaar_Card_No__c=objSR.Adhaar_Card_No__c;
              SI.Father_Name__c=objSR.Father_Name__c;
              SI.Kit_Area_Plots__c=objSR.Kit_Area_Plots__c; 
              SI.Party_Name__c=objSR.Party_Name__c;
               SaleInvoiceToUpsertList.add(SI);
          }
      }
      if(SaleInvoiceToUpsertList.size()>0)
      {
          system.debug(SaleInvoiceToUpsertList);
          upsert SaleInvoiceToUpsertList;
      }
 }
}  


/*public class SaleReportSheetHandler 
{
 public static void SaleReportSheetMethod(list<Sale_Report_Sheet__c>SaleReportSheetList)
 {
     List<Account>ClientFarmerList=new List<Account>();
      set<string>SRinvNum=new set<string>();
     Set<String> farmerCodes = new Set<String>();
      map<string,string>InvNumIDMap=new map<string,string>();
      list<Sale_Invoice__c>SaleInvoiceToUpsertList=new list<Sale_Invoice__c>();
      for(Sale_Report_Sheet__c objSR:SaleReportSheetList)
      {
          if(objSR.Invoice_No__c!=null)
          {
              system.debug('objSR.Invoice_No__c@@'+objSR.Invoice_No__c);
              SRinvNum.add(objSR.Invoice_No__c);
          }
          if(objSR.Party_name__C!=null ||objSR.Party_name__C!=''){
              String s1 = objSR.Party_name__C;
            String s2 = s1.substringBefore('(');
            s2=s2.remove(' ');
              farmerCodes.add(s2);
          }
      }
     Map<String, account> ExistingclientFarmersMap = new Map<String, account>();
    list<account>ExistingFarmerList=[select id,name,Farmer_Code__c from account where Farmer_Code__c IN:farmerCodes ];
    if(ExistingFarmerList.size()>0)
    {
       for (account clientFarmer : ExistingFarmerList) 
       {
        ExistingclientFarmersMap.put(clientFarmer.Farmer_Code__c, clientFarmer);
       }
    }   
      list<Sale_Invoice__c>ExistingInvoice=[SELECT Id, Transaction_Type__c, Date__c, Order_No__c, Name, Phone__c, Party_Name__c, Payment_Type__c, Description__c,
                                            Adhaar_Card_No__c, Father_Name__c, Kit_Area_Plots__c FROM Sale_Invoice__c];
      for(Sale_Invoice__c objinv:ExistingInvoice) 
      {
          if(objinv.Name!=null)
          {
              InvNumIDMap.put(objinv.Name,objinv.Id);
          }
      }
     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           for(Sale_Report_Sheet__c objSR:SaleReportSheetList)
      {
          String farmerCode;
          String FarmerName;
          if(objSR.Party_name__C!=null ||objSR.Party_name__C!=''){
              String s1 = objSR.Party_name__C;
            String s2 = s1.substringBefore('(');
            farmerCode=s2.remove(' ');
              FarmerName=objSR.Party_name__C.substringBetween('(',')');
          }
          System.debug('farmerCode@'+farmerCode+'FarmerName'+FarmerName);
          
              if(ExistingclientFarmersMap.get(farmerCode)==null ){
                Account newClientFarmer=new Account();
                newClientFarmer.Farmer_Code__c=farmerCode;
                newClientFarmer.Name = FarmerName;
                newClientFarmer.Phone = objSR.Party_Phone_No__c; 
                  newClientFarmer.Father_Name__c = objSR.Father_Name__c; 
                  newClientFarmer.Aadhar_Card_No__c = objSR.Adhaar_Card_No__c; 
                ClientFarmerList.add(newClientFarmer);
              }
              
          }
     if(ClientFarmerList.size()>0){
       insert ClientFarmerList;  
     }
     for(Account CF:ClientFarmerList){
         ExistingclientFarmersMap.put(CF.Farmer_Code__c, CF);
     }     
      
     
     ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      for(Sale_Report_Sheet__c objSR:SaleReportSheetList)
      {
          String farmerCode;
          String FarmerName;
          if(objSR.Party_name__C!=null ||objSR.Party_name__C!=''){
              String s1 = objSR.Party_name__C;
            String s2 = s1.substringBefore('(');
            farmerCode=s2.remove(' ');
              FarmerName=objSR.Party_name__C.substringBetween('(',')');
          }
          if(InvNumIDMap.get(objSR.Invoice_No__c)!=null)
          {
              system.debug('If Triggered');
              Sale_Invoice__c SI=new Sale_Invoice__c();
              SI.Id=InvNumIDMap.get(objSR.Invoice_No__c);
              SI.Transaction_Type__c=objSR.Transaction_Type__c;
              SI.Date__c=objSR.Date__c;
              SI.Order_No__c=objSR.Order_No__c;
              SI.Phone__c=objSR.Party_Phone_No__c;
              SI.Payment_Type__c=objSR.Payment_Type__c;
              SI.Description__c=objSR.Description__c;
              SI.Adhaar_Card_No__c=objSR.Adhaar_Card_No__c;
              SI.Father_Name__c=objSR.Father_Name__c;
              SI.Farmer_Code__c=farmerCode;
              
              SI.Kit_Area_Plots__c=objSR.Kit_Area_Plots__c;
              if(ExistingclientFarmersMap.get(farmerCode).Id!=null){
                  //SI.Client_Farmer__C=ExistingclientFarmersMap.get(farmerCode).Id;
              }
              
              SaleInvoiceToUpsertList.add(SI);
          }
          else 
          {
              system.debug('Else Triggered');
              Sale_Invoice__c SI=new Sale_Invoice__c();
              SI.Transaction_Type__c=objSR.Transaction_Type__c;
              SI.Name=objSR.Invoice_no__c;
              SI.Date__c=objSR.Date__c;
              SI.Order_No__c=objSR.Order_No__c;
              SI.Phone__c=objSR.Party_Phone_No__c;
              SI.Payment_Type__c=objSR.Payment_Type__c;
              SI.Description__c=objSR.Description__c;
              SI.Adhaar_Card_No__c=objSR.Adhaar_Card_No__c;
              SI.Father_Name__c=objSR.Father_Name__c;
              SI.Kit_Area_Plots__c=objSR.Kit_Area_Plots__c;
              SI.Farmer_Code__c=farmerCode;
              SI.Client_Farmer__C=ExistingclientFarmersMap.get(farmerCode).Id;
               SaleInvoiceToUpsertList.add(SI);
          }
      }
      if(SaleInvoiceToUpsertList.size()>0)
      {
          upsert SaleInvoiceToUpsertList;
      } */