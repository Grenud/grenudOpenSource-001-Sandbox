public class StateDistrictPicklist {
   @AuraEnabled(cacheable=true)
    public static list<Statewise_District__mdt> getStateDistrictPicklist()
    {
        return [select District__c, State__c from Statewise_District__mdt order by State__c asc];
      
    }  
}