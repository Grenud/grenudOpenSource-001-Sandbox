@isTest
public class StateDistrictPicklistTest {
    @isTest
    public static void testGetStateDistrictPicklist() {
        // Test data
        Statewise_District__mdt district1 = new Statewise_District__mdt();
        district1.State__c = 'State 1';
        district1.District__c = 'District 1';
        Statewise_District__mdt district2 = new Statewise_District__mdt();
        district2.State__c = 'State 1';
        district2.District__c = 'District 2';
        Statewise_District__mdt district3 = new Statewise_District__mdt();
        district3.State__c = 'State 2';
        district3.District__c = 'District 1';
        
        // Insert test records
       // insert new List<Statewise_District__mdt>{district1, district2, district3};
        
        // Perform the test
        List<Statewise_District__mdt> results = StateDistrictPicklist.getStateDistrictPicklist();
        
        // Verify the results
        System.assertEquals(3, results.size());
        System.assertEquals('State 1', results[0].State__c);
        System.assertEquals('District 1', results[0].District__c);
        System.assertEquals('State 1', results[1].State__c);
        System.assertEquals('District 2', results[1].District__c);
        System.assertEquals('State 2', results[2].State__c);
        System.assertEquals('District 1', results[2].District__c);
    }
}