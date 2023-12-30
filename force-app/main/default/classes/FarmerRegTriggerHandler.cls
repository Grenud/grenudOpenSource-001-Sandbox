public class FarmerRegTriggerHandler {
 public static void createAccount(list<Farmer_Registration__c>FrmRegList)
 {
     List<Account> acclist = new List<Account>();

        // Query existing Account records related to Farmer_Registration__c records
        Map<Id, Account> existingAccounts = new Map<Id, Account>(
            [SELECT Id, Farmer_Registration_No__c FROM Account WHERE Farmer_Registration_No__c IN :FrmRegList]
        );

        for (Farmer_Registration__c FR : FrmRegList) {
            if (FR.Lead_Convert__c == true && !existingAccounts.containsKey(FR.Id)) {
                Account acc = new Account();
                acc.Name = FR.Farmer_Name__c;
                acc.Phone = FR.Phone__c;
                acc.Village1__c = FR.Village__c;
                acc.Father_Name__c = FR.Father_Name__c;
                acc.Farmer_Registration_No__c = FR.Id;
                acclist.add(acc);
            }
        }

        if (!acclist.isEmpty()) {
            insert acclist;
        }
 }
}