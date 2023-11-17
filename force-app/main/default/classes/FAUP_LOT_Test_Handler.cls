@isTest
public class FAUP_LOT_Test_Handler {
    
    // Test method to cover the updateSuspect method
    static testMethod void testUpdateSuspect() {
        
// LOT STATUS = FAIL.
        FAUP_LOT__c lot = new FAUP_LOT__c(UP_Status__c = 'Fail');
        insert lot;
        system.debug('lot status: '+lot.UP_Status__c);
        Account clientFarmer = new Account(Name = 'Test Client Farmer',Farmer_Code__c ='FRL1949',Suspect__c = false,
                                           LOT_2_Status__c =null, 
                                           LOT_2_Name__c = null, 
                                           LOT_1_Status__c = null,
                                           LOT_1_Name__c = null,
                                           LOT_3_Name__c = null,
                                           LOT_3_Status__c = null
                                          );
        insert clientFarmer;
        
        
        FAUP_Sample__c sample = new FAUP_Sample__c(UP_LOT__c = lot.Id,Client_Farmer__c = clientFarmer.Id, UP_Suspect__c = false);
        insert sample;
        
        lot.UP_Status__c = 'Fail';
        update lot;
        
        Farm__c farm = new Farm__c(Name = 'Test Farm', UP_Sample__c = sample.Id, Client_Farmer__c = clientFarmer.Id, UP_Suspect__c = false);
        insert farm;
        system.debug('lot : '+lot);
        
        // Call the updateSuspect method
        List<FAUP_LOT__c> lotRecordList = [SELECT Id ,Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lot.Id];
        system.debug(lotRecordList);
        FAUP_LOT_Handler.updateSuspect(lotRecordList);
        
        // Verify the results
        lot = [SELECT Id, Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lot.Id];
        System.assertEquals('Fail', lot.UP_Status__c, 'Lot UP_Status__c should be "Fail".');
        
        sample = [SELECT Id, UP_Suspect__c FROM FAUP_Sample__c WHERE Id = :sample.Id];
        System.assertEquals(true, sample.UP_Suspect__c, 'Sample UP_Suspect__c should be true.');
        
        clientFarmer = [SELECT Id, Suspect__c, LOT_1_Status__c, LOT_1_Name__c, LOT_2_Status__c,LOT_2_Name__c,LOT_3_Name__c,LOT_3_Status__c FROM Account WHERE Id = :clientFarmer.Id];
        System.assertEquals(true, clientFarmer.Suspect__c, 'Client Farmer Suspect__c should be true.');
        System.assertEquals('Doubt', clientFarmer.LOT_1_Status__c, 'Client Farmer LOT_1_Status__c should be "Doubt".');
        
        farm = [SELECT Id, UP_Suspect__c FROM Farm__c WHERE Id = :farm.Id];
        System.assertEquals(true, farm.UP_Suspect__c, 'Farm UP_Suspect__c should be true.'); 
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        // LOT STATUS = PASS.
        FAUP_LOT__c lotPass = new FAUP_LOT__c(UP_Status__c = 'Pass');
        insert lotPass;
        
        Account clientFarmerPass = new Account(Name = 'Test Client Farmer Pass',Farmer_Code__c ='FRL2049',
                                                LOT_2_Status__c = null, 
                                                LOT_2_Name__c = null, 
                                                LOT_1_Status__c = null,
                                                LOT_1_Name__c = null,
                                               LOT_3_Name__c = null,
                                               LOT_3_Status__c = null
                                              );
        insert clientFarmerPass;
        
        FAUP_Sample__c samplePass = new FAUP_Sample__c(UP_LOT__c = lotPass.Id, Client_Farmer__c = clientFarmerPass.Id);
        insert samplePass;
        
        
        lotPass.UP_Status__c = 'Pass';
        update lotPass;        
        
        Farm__c farmPass = new Farm__c(Name = 'Test Farm Pass', UP_Sample__c = samplePass.Id, Client_Farmer__c = clientFarmerPass.Id, UP_Suspect__c = true);
        insert farmPass;
       
 // Call the updateSuspect method for the "Pass" condition
        List<FAUP_LOT__c> lotRecordListPass = [SELECT Id, Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lotPass.Id];
        FAUP_LOT_Handler.updateSuspect(lotRecordListPass);
        
        // Verify the results for the "Pass" condition
        lotPass = [SELECT Id,Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lotPass.Id];
        System.assertEquals('Pass', lotPass.UP_Status__c, 'Lot UP_Status__c should be "Pass".');
        
        //clientFarmerPass = [SELECT Id, LOT_1_Status__c, LOT_1_Name__c, LOT_2_Status__c,LOT_2_Name__c,LOT_3_Name__c,LOT_3_Status__c FROM Account WHERE Id = :clientFarmerPass.Id];
       // System.assertEquals('No Doubt', clientFarmerPass.LOT_3_Status__c, 'Client Farmer LOT_1_Status__c should be " No Doubt".');
       // System.assertEquals(lotPass.Name, clientFarmerPass.LOT_3_Name__c, 'Client Farmer LOT_3_Name__c should be lotPass.Name.');        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
// LOT STATUS = FAIL and LOT_3_Name__c = null & LOT_3_Status__c = null
FAUP_LOT__c lot1 = new FAUP_LOT__c(UP_Status__c = 'Fail');
        insert lot1;
        system.debug('lot status: '+lot.UP_Status__c);
        Account clientFarmer1 = new Account(Name = 'Test Client Farmer1',Farmer_Code__c ='FRL1749',Suspect__c = false,
                                            LOT_2_Status__c = 'No Doubt', 
                                            LOT_2_Name__c = 'Lot019', 
                                            LOT_1_Status__c = 'No Doubt',
                                            LOT_1_Name__c = 'Lot018',
                                            LOT_3_Name__c = null,
                                            LOT_3_Status__c = null
                                           );
        insert clientFarmer1;
        
        
        FAUP_Sample__c sample1 = new FAUP_Sample__c(UP_LOT__c = lot1.Id,Client_Farmer__c = clientFarmer1.Id, UP_Suspect__c = false);
        insert sample1;
        
        lot1.UP_Status__c = 'Fail';
        update lot1;
        
        Farm__c farm1 = new Farm__c(Name = 'Test Farm1', UP_Sample__c = sample1.Id, Client_Farmer__c = clientFarmer1.Id, UP_Suspect__c = false);
        insert farm1;
        system.debug('lot1 : '+lot1);
        
        // Call the updateSuspect method
        List<FAUP_LOT__c> lotRecordList1 = [SELECT Id ,Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lot1.Id];
        system.debug(lotRecordList1);
        FAUP_LOT_Handler.updateSuspect(lotRecordList1);
        
        // Verify the results
        lot1 = [SELECT Id, Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lot1.Id];
        System.assertEquals('Fail', lot.UP_Status__c, 'Lot UP_Status__c should be "Fail".');
        
        sample1 = [SELECT Id, UP_Suspect__c FROM FAUP_Sample__c WHERE Id = :sample1.Id];
        System.assertEquals(true, sample.UP_Suspect__c, 'Sample UP_Suspect__c should be true.');
        
        clientFarmer1 = [SELECT Id, Suspect__c, LOT_1_Status__c, LOT_1_Name__c, LOT_2_Status__c,LOT_2_Name__c,LOT_3_Name__c,LOT_3_Status__c FROM Account WHERE Id = :clientFarmer1.Id];
        System.assertEquals(true, clientFarmer1.Suspect__c, 'Client Farmer Suspect__c should be true.');
        System.assertEquals('Doubt', clientFarmer1.LOT_3_Status__c, 'Client Farmer LOT_1_Status__c should be "Doubt".');
        System.assertEquals(lot1.Name, clientFarmer1.LOT_3_Name__c, 'Client Farmer LOT_3_Name__c should be lot1.Name.');
        
        farm1 = [SELECT Id, UP_Suspect__c FROM Farm__c WHERE Id = :farm.Id];
        System.assertEquals(true, farm.UP_Suspect__c, 'Farm UP_Suspect__c should be true.');
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        FAUP_LOT__c lotPass1 = new FAUP_LOT__c(UP_Status__c = 'Pass');
        insert lotPass1;
        
        Account clientFarmerPass1 = new Account(Name = 'Test Client Farmer Pass1',Farmer_Code__c ='FRL2099',
                                                LOT_2_Status__c = 'No Doubt', 
                                                LOT_2_Name__c = 'Lot021', 
                                                LOT_1_Status__c = 'No Doubt',
                                                LOT_1_Name__c = 'Lot022',
                                                LOT_3_Name__c = null,
                                                LOT_3_Status__c = null
                                               );
        insert clientFarmerPass1;
        
        FAUP_Sample__c samplePass1 = new FAUP_Sample__c(UP_LOT__c = lotPass1.Id, Client_Farmer__c = clientFarmerPass1.Id);
        insert samplePass1;
        
        
        lotPass.UP_Status__c = 'Pass';
        update lotPass;
        
        
        Farm__c farmPass1 = new Farm__c(Name = 'Test Farm Pass', UP_Sample__c = samplePass1.Id, Client_Farmer__c = clientFarmerPass1.Id, UP_Suspect__c = true);
        insert farmPass1;
        // Call the updateSuspect method for the "Pass" condition
        List<FAUP_LOT__c> lotRecordListPass1 = [SELECT Id, Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lotPass1.Id];
        FAUP_LOT_Handler.updateSuspect(lotRecordListPass1);
        
        // Verify the results for the "Pass" condition
        lotPass1 = [SELECT Id,Name, UP_Status__c FROM FAUP_LOT__c WHERE Id = :lotPass1.Id];
        System.assertEquals('Pass', lotPass.UP_Status__c, 'Lot UP_Status__c should be "Pass".');
        
        
        clientFarmerPass1 = [SELECT Id, LOT_1_Status__c, LOT_1_Name__c, LOT_2_Status__c,LOT_2_Name__c,LOT_3_Name__c,LOT_3_Status__c FROM Account WHERE Id = :clientFarmerPass1.Id];
        System.assertEquals('No Doubt', clientFarmerPass1.LOT_3_Status__c, 'Client Farmer LOT_1_Status__c should be " No Doubt".');
        //System.assertEquals(lotPass1.Name, clientFarmerPass1.LOT_3_Name__c, 'Client Farmer LOT_3_Name__c should be lotPass1.Name.');
        
    }
}