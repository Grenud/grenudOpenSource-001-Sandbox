@isTest
public class PaddyPurchaseTriggerHandlerTest {
 
    @isTest
    static void testHandleBeforeInsertInvoice() {
        // Create a test General Farmer record
    General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876562543';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';    
    insert generalFarmer;

    // Create a test Client Farmer record
    Account clientFarmer = new Account(
        Name = 'Test Client Farmer',Farmer_Code__c='FRL001'
        // Add other required fields for the Client Farmer record here
    );
    insert clientFarmer;

        
        // Create test data
        Paddy_Purchase__c frlPurchase = new Paddy_Purchase__c(Bill_To__c = 'FORTUNE RICE LIMITED',LABOUR_CHARGE_PER_BAG_INR__c=4,
        General_Farmer__c = generalFarmer.Id);
        Paddy_Purchase__c agroPurchase = new Paddy_Purchase__c(Bill_To__c = 'FORTUNE AGROMART PVT LTD',LABOUR_CHARGE_PER_BAG_INR__c=4,
        Client_Farmer__c = clientFarmer.Id );
        insert new List<Paddy_Purchase__c>{frlPurchase, agroPurchase};
        
        // Create new purchases to simulate trigger context
        List<Paddy_Purchase__c> newPurchases = new List<Paddy_Purchase__c>{
            new Paddy_Purchase__c(Bill_To__c = 'FORTUNE RICE LIMITED'),
            new Paddy_Purchase__c(Bill_To__c = 'FORTUNE AGROMART PVT LTD')
        };

        // Call the trigger handler method
        Test.startTest();
        PaddyPurchaseTriggerHandler.handleBeforeInsertInvoice(newPurchases);
        Test.stopTest();

        // Assert the results
        for (Paddy_Purchase__c purchase : newPurchases) {
            if (purchase.Bill_To__c == 'FORTUNE RICE LIMITED') {
                System.assertEquals(2, purchase.Series__c);
                System.assertEquals(null, purchase.Series1__c);
                System.assertEquals(2, purchase.Invoice_No__c);
            } else if (purchase.Bill_To__c == 'FORTUNE AGROMART PVT LTD') {
                System.assertEquals(2, purchase.Series1__c);
                System.assertEquals(null, purchase.Series__c);
                System.assertEquals(2, purchase.Invoice_No__c);
            }
        }
    }

    @isTest
    static void testHandleBeforeUpdateInvoice() {
        
            // Create a test General Farmer record
    General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876452543';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';    
    insert generalFarmer;

    // Create a test Client Farmer record
    Account clientFarmer = new Account(
        Name = 'Test Client Farmer',Farmer_Code__c='FRL001'
        // Add other required fields for the Client Farmer record here
    );
    insert clientFarmer;
        // Create test data
        Paddy_Purchase__c frlPurchase = new Paddy_Purchase__c(Bill_To__c = 'FORTUNE RICE LIMITED',LABOUR_CHARGE_PER_BAG_INR__c=4,
        General_Farmer__c = generalFarmer.Id);
        Paddy_Purchase__c agroPurchase = new Paddy_Purchase__c(Bill_To__c = 'FORTUNE AGROMART PVT LTD',LABOUR_CHARGE_PER_BAG_INR__c=4,
        Client_Farmer__c = clientFarmer.Id);
        insert new List<Paddy_Purchase__c>{frlPurchase, agroPurchase};

        // Change the Bill_To__c value to trigger the update logic
        frlPurchase.Bill_To__c = 'FORTUNE AGROMART PVT LTD';
        agroPurchase.Bill_To__c = 'FORTUNE RICE LIMITED';
        update new List<Paddy_Purchase__c>{frlPurchase, agroPurchase};

        // Create a map of old records to simulate trigger context
        Map<Id, Paddy_Purchase__c> oldMap = new Map<Id, Paddy_Purchase__c>{
            frlPurchase.Id => new Paddy_Purchase__c(Bill_To__c = 'FORTUNE RICE LIMITED'),
            agroPurchase.Id => new Paddy_Purchase__c(Bill_To__c = 'FORTUNE AGROMART PVT LTD')
        };

        // Call the trigger handler method
        Test.startTest();
        PaddyPurchaseTriggerHandler.handleBeforeUpdateInvoice(new List<Paddy_Purchase__c>{frlPurchase, agroPurchase}, oldMap);
        Test.stopTest();

        // Assert the results
        System.assertEquals(null, frlPurchase.Series__c);
        System.assertEquals(3, frlPurchase.Series1__c);
        System.assertEquals(3, frlPurchase.Invoice_No__c);

        System.assertEquals(null, agroPurchase.Series1__c);
        System.assertEquals(3, agroPurchase.Series__c);
        System.assertEquals(3, agroPurchase.Invoice_No__c);
    } 
    
   @isTest
    static void testHandleUpdateMasterLooseQuantity() {
        
    General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876543548';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';
    
    insert generalFarmer;
        // Create test data: Parent Paddy_Purchase__c records
        List<Paddy_Purchase__c> testParents = new List<Paddy_Purchase__c>();
        for (Integer i = 0; i < 5; i++) {
             testParents.add(new Paddy_Purchase__c(
        Loose_Master__c = null,
        General_Farmer__c = generalFarmer.Id));
        }
        insert testParents;
        
        // Create a parent Paddy_Purchase__c record with Loose_Master__c field set
        Paddy_Purchase__c parentPaddy1 = new Paddy_Purchase__c(
            General_Farmer__c = generalFarmer.Id
        );
        insert parentPaddy1;
        Test.startTest();
        System.runAs(new User(Id = UserInfo.getUserId())){
             Paddy_Purchase__c childPaddy1 = new Paddy_Purchase__c();
             childPaddy1.Loose_Master__c = parentPaddy1.Id;
           // if(childPaddy1.Loose_Convert_Quantity_1st_Attempt__c!=null)
           // {
               childPaddy1.Loose_Convert_Quantity_1st_Attempt__c = 0.50; 
          //  }
            childPaddy1.General_Farmer__c = generalFarmer.Id;
             insert childPaddy1;
        
        // Create a child Paddy_Purchase__c record related to the parent
       
       // insert childPaddy1;

        // Create another parent Paddy_Purchase__c record with Loose_Master_2nd_Attemp__c field set
        Paddy_Purchase__c parentPaddy2 = new Paddy_Purchase__c(
          General_Farmer__c = generalFarmer.Id
        );
        insert parentPaddy2;
       
        // Create a child Paddy_Purchase__c record related to the second parent
        Paddy_Purchase__c childPaddy2 = new Paddy_Purchase__c();
           childPaddy2.Loose_Master__c = parentPaddy2.Id;
          //  if(childPaddy2.Loose_Convert_Quantity_1st_Attempt__c!=null)
           // {
               childPaddy2.Loose_Convert_Quantity_1st_Attempt__c = 0.50; 
           // }
            childPaddy2.General_Farmer__c = generalFarmer.Id;
        insert childPaddy2;

        // Create a list of child records to pass to the handler method
        List<Paddy_Purchase__c> childRecords = new List<Paddy_Purchase__c>{childPaddy1, childPaddy2};
            
        // Call the handler method
        PaddyPurchaseTriggerHandler.handleUpdateMasterLooseQuantity(childRecords);

        // Retrieve the updated parent records
        parentPaddy1 = [SELECT Master_Loose_Amount__c, Master_Loose_Quantity__c FROM Paddy_Purchase__c WHERE Id = :parentPaddy1.Id];
        parentPaddy2 = [SELECT Master_Loose_Amount__c, Master_Loose_Quantity__c FROM Paddy_Purchase__c WHERE Id = :parentPaddy2.Id];
        
        // Perform assertions to check if the calculations are correct
        System.assertEquals(0, parentPaddy1.Master_Loose_Amount__c); // Expected value based on childPaddy1 values
        System.assertEquals(0, parentPaddy2.Master_Loose_Amount__c); // Expected value based on childPaddy2 values
        System.assertEquals(0.50, parentPaddy1.Master_Loose_Quantity__c); // Expected value based on childPaddy1 values
        System.assertEquals(0.50, parentPaddy2.Master_Loose_Quantity__c); // Expected value based on childPaddy2 values
        }
    Test.stopTest();
    }
       

    @isTest
    static void testHandleReparentingLooseMaster() {
        
         General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876543532';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';
    
    insert generalFarmer;
        // Create test data: Parent Paddy_Purchase__c records
        List<Paddy_Purchase__c> testParents = new List<Paddy_Purchase__c>();
        for (Integer i = 0; i < 5; i++) {
    testParents.add(new Paddy_Purchase__c(
        Loose_Master__c = null,General_Farmer__c = generalFarmer.Id));
}
        insert testParents;

        // Create test data: Child Paddy_Purchase__c records
        List<Paddy_Purchase__c> testChildren = new List<Paddy_Purchase__c>();
        for (Paddy_Purchase__c parent : testParents) {
            testChildren.add(new Paddy_Purchase__c(
               
                Loose_Master__c = parent.Id,General_Farmer__c = generalFarmer.Id,
                Loose_Quantity_Qtl__c = 10,
                Loose_Convert_Quantity_1st_Attempt__c=0.15
            ));
        }
        insert testChildren;

        // Update Loose_Master__c on some children
        testChildren[0].Loose_Master__c = testParents[1].Id;
        update testChildren;

        // Call the handler method
        Test.startTest();
        PaddyPurchaseTriggerHandler.handleReparentingLooseMaster(null, testChildren, new Map<Id, Paddy_Purchase__c>());
        Test.stopTest();

        // Verify that Parent Paddy_Purchase__c Master_Loose_Quantity__c is updated correctly
        List<Paddy_Purchase__c> updatedParents = [SELECT Id, Master_Loose_Quantity__c FROM Paddy_Purchase__c WHERE Id IN :testParents];
        for (Paddy_Purchase__c parent : updatedParents) {
            Decimal expectedValue = 0;
            for (Paddy_Purchase__c child : testChildren) {
                if (child.Loose_Master__c == parent.Id && child.Loose_Convert_Quantity_1st_Attempt__c != null) {
                    expectedValue += child.Loose_Convert_Quantity_1st_Attempt__c;
                }
            }
            System.assertEquals(expectedValue, parent.Master_Loose_Quantity__c);
        }
    } 

    @isTest
    static void testCreditSettlementRollUp() {
        // Create test data: Accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' , Credit_Settlement__c = 100,Farmer_Code__c='FRL001'+ i));
        }
        insert testAccounts;

        // Create test data: Paddy Purchases
        List<Paddy_Purchase__c> testPurchases = new List<Paddy_Purchase__c>();
        for (Account acc : testAccounts) {
            testPurchases.add(new Paddy_Purchase__c(
                Client_farmer__c = acc.Id,
                Credit_Settlement__c = 50
            ));
        }
        insert testPurchases;

        // Call the trigger handler method
        Test.startTest();
        delete testPurchases;
        undelete testPurchases;
        Test.stopTest();

        // Verify that Account Credit_Settlement__c values are updated correctly after deletion and undeletion
        List<Account> updatedAccounts = [SELECT Id, Credit_Settlement__c FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            Decimal expectedValue = 0;
            for (Paddy_Purchase__c purchase : testPurchases) {
                if (purchase.Client_farmer__c == acc.Id && purchase.Credit_Settlement__c != null) {
                    expectedValue += purchase.Credit_Settlement__c;
                }
            }
            System.assertEquals(expectedValue, acc.Credit_Settlement__c);
        }
    }
    
    @isTest
    static void testUpdateReparentCreditSettRollUpSum() {
        // Create test data: Accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ',Farmer_Code__c='FRL001' + i));
        }
        insert testAccounts;

        // Create test data: Paddy Purchases
        List<Paddy_Purchase__c> testPurchases = new List<Paddy_Purchase__c>();
        for (Account acc : testAccounts) {
            testPurchases.add(new Paddy_Purchase__c(
                Client_farmer__c = acc.Id,
                Credit_Settlement__c = 50
            ));
        }
        insert testPurchases;

        // Modify Credit Settlement on some purchases
        testPurchases[0].Credit_Settlement__c = 100;
        update testPurchases;

        // Create a map of old Paddy_Purchase__c records
        Map<Id, Paddy_Purchase__c> oldMapPurchases = new Map<Id, Paddy_Purchase__c>([SELECT Id, Client_farmer__c FROM Paddy_Purchase__c WHERE Id IN :testPurchases]);

        // Call the trigger handler method
        Test.startTest();
        PaddyPurchaseTriggerHandler.updateReparentCreditSettRollUpSum(null, testPurchases, oldMapPurchases);
        Test.stopTest();

        // Verify that Account Credit_Settlement__c values are updated correctly
        List<Account> updatedAccounts = [SELECT Id, Credit_Settlement__c FROM Account WHERE Id IN :testAccounts];
        for (Account acc : updatedAccounts) {
            Decimal expectedValue = 0;
            for (Paddy_Purchase__c purchase : testPurchases) {
                if (purchase.Client_farmer__c == acc.Id && purchase.Credit_Settlement__c != null) {
                    expectedValue += purchase.Credit_Settlement__c;
                }
            }
            System.assertEquals(expectedValue, acc.Credit_Settlement__c);
        }
    }
    
    @isTest
    static void testPaddyPurchaseTriggerHandler() {
        // Create necessary record types and custom labels if needed

        // Create a custom label variable
        String WithLooseRecordTypeLabel = System.Label.WithLooseRecordTypeId;

        // Create test records for Supply_Billing__c
        Supply_Billing__c supplyBilling = new Supply_Billing__c();
        insert supplyBilling;

        // Create test records for General_Farmer__c
         
    General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876543231';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';
        
    
    insert generalFarmer;

        // Create test records for Paddy_Purchase__c
        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(
            Supply_Bill_No__c = supplyBilling.Id,
            Bag__c = 10,
            Packing__c = 0.55,
            Rate_Per_Qtl__c = 20,
            General_Farmer__c = generalFarmer.Id
        );
        insert paddyPurchase;

        // Call the trigger handler method
        List<Paddy_Purchase__c> paddyPurchases = new List<Paddy_Purchase__c>{ paddyPurchase };
        Test.startTest();
        PaddyPurchaseTriggerHandler.updateAmountSupplyBillRollupSum(paddyPurchases);
        Test.stopTest();

        // Query the updated records and assert the expected values
        supplyBilling = [SELECT Id, Amount__c FROM Supply_Billing__c WHERE Id = :supplyBilling.Id];
        
        if (WithLooseRecordTypeLabel == 'YourExpectedValue') {
            // Your condition using the custom label
            System.assertEquals(110, supplyBilling.Amount__c);
        } else {
            // Handle other scenarios
        }
        
        // Add more assertions for other scenarios as needed

    }
    
  /*  @isTest
    static void testUpdateAmountSupplyBillRollupSum() {
        // Create test records
        Supply_Billing__c supplyBilling = new Supply_Billing__c();
        insert supplyBilling;
        
         General_Farmer__c generalFarmer = new General_Farmer__c();
    generalFarmer.Name='Sonu';
    generalFarmer.Farmer_Name__c='Sonu';
    generalFarmer.Father_Name__c='Sonu Father';
    generalFarmer.Phone__c='9876543';
    generalFarmer.Village__c='Jhajhr';
    generalFarmer.Block__c='Jewar';
    generalFarmer.District__c='Gb';
    
    insert generalFarmer;
        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(
            Supply_Bill_No__c = supplyBilling.Id,
            Bag__c = 10,
            Packing__c =0.55,
            Rate_Per_Qtl__c = 20,General_Farmer__c=generalFarmer.id
        );
        insert paddyPurchase;

        List<Paddy_Purchase__c> paddyPurchases = new List<Paddy_Purchase__c>{ paddyPurchase };

        // Call the method to be tested directly using the class name
        Test.startTest();
        PaddyPurchaseTriggerHandler.updateAmountSupplyBillRollupSum(paddyPurchases);
        Test.stopTest();

        // Query the updated records and assert the expected values
        supplyBilling = [SELECT Id, Amount__c FROM Supply_Billing__c WHERE Id = :supplyBilling.Id];
        System.assertEquals(110, supplyBilling.Amount__c);
    } */

    @isTest
    static void testUpdateReparentSupplyBillingAmountRollUpSum() {
        // Create test records
        Supply_Billing__c supplyBilling = new Supply_Billing__c();
        insert supplyBilling;

        Paddy_Purchase__c paddyPurchase = new Paddy_Purchase__c(
            Supply_Bill_No__c = supplyBilling.Id,
            Bag__c = 10,
            Packing__c = 5,
            Loose_Quantity_Qtl__c = 50,
            Rate_Per_Qtl__c = 20
        );
      //  update paddyPurchase;

        Map<Id, Paddy_Purchase__c> paddyPurchaseMap = new Map<Id, Paddy_Purchase__c>{
            paddyPurchase.Id => paddyPurchase
        };

        List<Paddy_Purchase__c> newPaddyPurchases = new List<Paddy_Purchase__c>{
            new Paddy_Purchase__c(
                Supply_Bill_No__c = supplyBilling.Id,
                Bag__c = 10,
                Packing__c = 5,
                Loose_Quantity_Qtl__c = 50,
                Rate_Per_Qtl__c = 20
            )
        };

        // Call the method to be tested directly using the class name
        Test.startTest();
        PaddyPurchaseTriggerHandler.updateReparentSupplyBillingAmountRollUpSum(null, newPaddyPurchases, paddyPurchaseMap);
        Test.stopTest();

        // Query the updated records and assert the expected values
        supplyBilling = [SELECT Id, Amount__c,Total_Bags__c FROM Supply_Billing__c WHERE Id = :supplyBilling.Id];
        System.assertEquals(0, supplyBilling.Amount__c);
        System.assertEquals(0, supplyBilling.Total_Bags__c);
        
    } 
       
     @isTest static void testUpdateGrandTotalRollupSum() {
        // Create test data: General Farmer and related Paddy Purchases
         General_farmer__c gf = new General_farmer__c();
             gf.Farmer_Name__c='TestFarmer';
             gf.Father_Name__c='TestFather' ; 
             gf.Village__c='Test Village';
             gf.Block__c='Test Block' ; 
             gf.District__c='Test District';
             gf.Phone__c='9542546230' ;
             insert gf;
        
        Paddy_Purchase__c pp1 = new Paddy_Purchase__c(
            General_farmer__c = gf.Id,LABOUR_CHARGE_PER_BAG_INR__c=4,
            Credit_Settlement__c = 5
        );
        // Add other fields as needed
        insert new List<Paddy_Purchase__c>{pp1};
        
        // Call the method to update rollup values
        List<Paddy_Purchase__c> paddyPurchases = new List<Paddy_Purchase__c>{pp1};
        PaddyPurchaseTriggerHandler.updateGrandTotalRollupSum(paddyPurchases);
        
        // Verify that the General Farmer's Total_Paddy_Amount__c is updated correctly
        gf = [SELECT Total_Paddy_Amount__c FROM General_farmer__c WHERE Id = :gf.Id];
        System.assertEquals(-5, gf.Total_Paddy_Amount__c); // Expected value based on formula
    }

    @isTest static void testUpdateReparentGrandTotalRollUpSum() {
        // Create test data: General Farmer and related Paddy Purchases
        General_farmer__c gf1 = new General_farmer__c(); gf1.Farmer_Name__c='TestFarmer';
             gf1.Father_Name__c='TestFather' ; 
             gf1.Village__c='Test Village';
             gf1.Block__c='Test Block' ; 
             gf1.District__c='Test District';
             gf1.Phone__c='9542563230' ;
        General_farmer__c gf2 = new General_farmer__c();
        gf2.Father_Name__c='TestFather' ; 
        gf2.Farmer_Name__c='TestFarmer';
             gf2.Village__c='Test Village';
             gf2.Block__c='Test Block' ; 
             gf2.District__c='Test District';
             gf2.Phone__c='954230' ;
        insert new List<General_farmer__c>{gf1, gf2};
        
        Paddy_Purchase__c pp1 = new Paddy_Purchase__c(
            General_farmer__c = gf1.Id,LABOUR_CHARGE_PER_BAG_INR__c=4,
            Credit_Settlement__c = 5
        );
        insert new List<Paddy_Purchase__c>{pp1};
        
        // Update Paddy_Purchase__c's General_farmer__c to reparent
        pp1.General_farmer__c = gf2.Id;
        update new List<Paddy_Purchase__c>{pp1};
        
        // Verify that the General Farmers' Total_Paddy_Amount__c is updated correctly
        gf1 = [SELECT Total_Paddy_Amount__c FROM General_farmer__c WHERE Id = :gf1.Id];
        gf2 = [SELECT Total_Paddy_Amount__c FROM General_farmer__c WHERE Id = :gf2.Id];
        System.assertEquals(0, gf1.Total_Paddy_Amount__c); // No purchases
        System.assertEquals(-5, gf2.Total_Paddy_Amount__c); // Expected value based on formula
    }
}