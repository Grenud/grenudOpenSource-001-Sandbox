public class ProductItemTriggerHandler 
{
 public static void ProductItemInsert(list<Product_Item__c>PItemList)
 {
     
     set<string>InvNoSet=new set<string>();
    map<string,string>InvNoIdMap = new map<string, string>();
     
     for(Product_Item__c ObjItem:PItemList)
     {
         if(ObjItem.Invoice_No__c!=null)
         {
             system.debug(ObjItem.Invoice_No__c);
             
             InvNoSet.add(ObjItem.Invoice_No__c);
         }
     }
     
     //Collection for (Invoice Number Find from database for extraCTING THE id)
     List<Sale_Invoice__c> saleInvoiceRecord=[select id,name from Sale_Invoice__c where name IN : InvNoSet];
     if(SaleInvoiceRecord.size() > 0 ){
         for(Sale_Invoice__c ObjInvoice : SaleInvoiceRecord){
             system.debug(ObjInvoice.Id);
             system.debug(ObjInvoice.Name);
             InvNoIdMap.put(ObjInvoice.Name , ObjInvoice.Id);
             
         }
     } 
     
     for(Product_Item__c ObjItem:PItemList){
         if(InvNoIdMap.get(ObjItem.Invoice_No__c)!=null){
             ObjItem.Sale_Invoice__c = InvNoIdMap.get(ObjItem.Invoice_No__c);
         }
         else{
         ObjItem.addError('Invoice no: '+ObjItem.Invoice_No__c+' not Exists');
       }
     }
 }
}