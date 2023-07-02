public class InvoiceItemSheetHandler
{ 
  public static void HandlerAfterInsert(list<Invoice_Item_Sheet__c>InvoiceItemSheetList)
  {
      list<Sale_Invoice__c>NewSaleInvToInsert= new list<Sale_Invoice__c>();
      list<Product_Item__c>ItemtoInsertList=new list<Product_Item__c>();
      set<string>InvoiceNoSet=new set<string>();
      map<string, string>InvoiceNameIdMap=new map<string, string>();
      for(Invoice_Item_Sheet__c ObjInv:InvoiceItemSheetList)
      {
         if(ObjInv.Invoice_Number__c!=null)
         {
             InvoiceNoSet.add(ObjInv.Invoice_Number__c);
         }         
      }
      list<Sale_Invoice__c>InvoiceList=[select id,name from Sale_Invoice__c where name IN : InvoiceNoSet];  
      if(InvoiceList.size()>0)
      {
          for(Sale_Invoice__c ObjInv:InvoiceList )
          {
              InvoiceNameIdMap.put(ObjInv.Name,ObjInv.Id);
          }
      }
      for(Invoice_Item_Sheet__c ObjInv:InvoiceItemSheetList)
      {
        if(InvoiceNameIdMap.get(ObjInv.Invoice_Number__c)==null ||InvoiceNameIdMap.get(ObjInv.Invoice_Number__c)=='')
        {
            Sale_Invoice__c NewInvoice= New Sale_Invoice__c();
            NewInvoice.name=ObjInv.Invoice_Number__c;
            NewInvoice.Vyapar_INV_No__c=ObjInv.Invoice_Number__c;
            NewInvoice.Party_Name__c=ObjInv.Party_Name__c;
            NewInvoice.Total_Invoice_Value__c=ObjInv.Amount__c;
            NewSaleInvToInsert.add(NewInvoice);
        }     
      }
      system.debug('NewSaleInvToInsert@@@'+NewSaleInvToInsert.size());
      insert NewSaleInvToInsert;
      if(NewSaleInvToInsert.size()>0){
          for(Sale_Invoice__c ObjInv:NewSaleInvToInsert)
          {
              system.debug('ObjInv.Name'+ObjInv.Name+'ID is '+ObjInv.Id);
              InvoiceNameIdMap.put(ObjInv.Name,ObjInv.Id);
          }
     }
       for(Invoice_Item_Sheet__c ObjInv:InvoiceItemSheetList)
    {
        if(ObjInv.Invoice_Number__c!=null){
       
        Product_Item__c objItem=new Product_Item__c();
        if(InvoiceNameIdMap.get(ObjInv.Invoice_Number__c)!=null){
            system.debug('Enteredinto For ');
           objItem.Sale_Invoice__c=InvoiceNameIdMap.get(ObjInv.Invoice_Number__c);
        	//objItem.Vyapar_INV_No__c=ObjInv.Invoice_Number__c;
        	objItem.Discount__c=ObjInv.Discount_Percent__c;
         //   objItem.Discount_Price__c=ObjInv.Discount__c;
            objItem.Quantity__c=ObjInv.Quantity__c;
            objItem.Sale_Price__c=ObjInv.UnitPrice__c;
          //  objItem.Total_Price__c=ObjInv.Amount__c;
              objItem.Tax_Percent__c= ObjInv.Tax_Percent__c;
              objItem.UoM__c=ObjInv.Unit__c;
              objItem.Date__c=ObjInv.Date__c;
              objItem.Item_Name__c=ObjInv.Item_Name__c;
              objItem.Item_Code__c=ObjInv.Item_Code__c;
              objItem.Category__c=ObjInv.Category__c;
              objItem.Transaction_Type__c=ObjInv.Transaction_Type__c;
            ItemtoInsertList.add(objItem); 
        }}}
      
     insert ItemtoInsertList;
  } 
}