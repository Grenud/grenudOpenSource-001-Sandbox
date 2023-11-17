public class FAUP_Sampling_Component {
    
    // GET CLIENT FARMERS WHOSE FARM ARE LEFT FOR SAMPLING
    @AuraEnabled(cacheable=true)
    public static List<Account> getClientFarmerList(String searchVillage) {
        List<Account> ClientFarmerList = new List<Account>();
                system.debug('searchVillage'+searchVillage);
         

        if (searchVillage != null && searchVillage != '') {
            // Use a subquery to filter Account records based on related Farm__c records
            ClientFarmerList = [
                SELECT Id, Name, Phone, Father_Name__c, Village__c, Suspect__c
                FROM Account
                WHERE Village__c LIKE :searchVillage + '%'
                AND Id IN (SELECT Client_Farmer__c
                           FROM Farm__c
                           WHERE UP_Sample_Collect__c = false)
            ];
        }
        
        system.debug('ClientFarmerList'+ClientFarmerList.Size());
         
        return ClientFarmerList;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
    //GET FARMS OF SELECTED CLIENT FARMER 
    @AuraEnabled(cacheable=true)
    public static List<Farm__c> getFarmList(Id clientfarmId) {
        List<Farm__c> Farm = new List<Farm__c>();
        system.debug(clientfarmId);
        Farm =  [SELECT Id, Name,Plot_Size__c,Plot_Type__c,UP_Sample_Collect__c, Client_Farmer__c 
                FROM Farm__c 
                Where Client_Farmer__c =: clientfarmId
                AND UP_Sample_Collect__c= false];
        return Farm;
        
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    
    //CREATE SAMPLE RECORDS FOR CLIENT FARMERS ACCORDING TO SELECTED FARMS
    @AuraEnabled
    public static ID createSampleRecords(List<Farm__c> selectedFarms, ID LotId) { 

        ID sampleId = null;
        decimal NoOfFarms = selectedFarms.Size();
        if (selectedFarms != null && !selectedFarms.isEmpty()) {        
            FAUP_Sample__c newSampleRec = new FAUP_Sample__c();
            newSampleRec.UP_LOT__c = LotId;
            newSampleRec.Client_Farmer__c = selectedFarms[0].Client_Farmer__c;
            newSampleRec.No_Of_Farms__c = NoOfFarms;
            
            // Create a comma-separated list of Farm names
            String farmNames = '';
            for (Farm__c farm : selectedFarms) {
                if (!String.isBlank(farmNames)) {                     farmNames += ', ';

                }
                
                farmNames += farm.Name;
            }
            newSampleRec.Farms__c = farmNames;
            
            insert newSampleRec;
            
            // Set sampleId to the Id of the newly inserted record
            sampleId = newSampleRec.Id;
            system.debug('sampleId'+sampleId);
        }
        return sampleId;
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //UPDATE MANUALLYSELECTED FARMS 
    @AuraEnabled
    public static void updateSelectedFarms(List<Farm__c> SelectedFarmsData, ID LotId, Id SampleId) { 
        List<Farm__c> updatedFarms = new List<Farm__c>();
        string LotName = null;
        
        List<FAUP_LOT__c> ClientFarmerList = [SELECT Id, Name FROM FAUP_LOT__c WHERE Id =: LotId limit 1];        
        LotName =  ClientFarmerList[0].Name;
        
        if (SelectedFarmsData != null && !SelectedFarmsData.isEmpty()) {        
            for (Farm__c farm : SelectedFarmsData) {
                farm.UP_Sample__c = SampleId;
                farm.UP_Sample_Collected_Date__c = system.now();
                farm.UP_Sample_Collect__c = true;
                farm.FAUP_LOT_Name__c = LotName;
                
                // Add the updated farm to the list of updated records
                updatedFarms.add(farm);
            }
            
            // Update the records
            update updatedFarms;
        }
        
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    
    // CREATE SAMPLES FOR ALL SELECTED CLIENT FARMERS
    @AuraEnabled
    public static List<FAUP_Sample__c> createClientFrmSamples(List<Account> SelectedFarmersIds, ID LotId) { 
        List<FAUP_Sample__c> craeteSamplesList = new List<FAUP_Sample__c>();
        Map<Id, List<Farm__c>> clientFarmsMap = new Map<Id, List<Farm__c>>();
        
        if (SelectedFarmersIds != null && !SelectedFarmersIds.isEmpty()) {
            // Collect related Farm records in a map
            for (Account cltfrm : SelectedFarmersIds) {
                clientFarmsMap.put(cltfrm.Id, new List<Farm__c>());
            }
            
            List<Farm__c> farmsList = [SELECT Id, Name, UP_Sample_Collect__c, Client_Farmer__c 
                                       FROM Farm__c 
                                       WHERE Client_Farmer__c IN :SelectedFarmersIds
                                       AND UP_Sample_Collect__c = false];
            
            for (Farm__c farm : farmsList) {
                clientFarmsMap.get(farm.Client_Farmer__c).add(farm);
            }
            
            for (Account cltfrm : SelectedFarmersIds) {
                List<Farm__c> farms = clientFarmsMap.get(cltfrm.Id); //Get list of realted farm of given client farmer Id.
                
                if(farms.size()>0){            
                    FAUP_Sample__c newSampleRec = new FAUP_Sample__c();
                    newSampleRec.UP_LOT__c = LotId;
                    newSampleRec.Client_Farmer__c = cltfrm.Id;
                    newSampleRec.No_Of_Farms__c = farms.size();
                    
                    // Create a comma-separated list of Farm names   
                    String farmNames = '';
                    for (Farm__c farm : farms) {
                        if (!String.isBlank(farmNames)) {                             farmNames += ', ';

                        }
                        farmNames += farm.Name;
                    }
                    newSampleRec.Farms__c = farmNames;
                    craeteSamplesList.add(newSampleRec);
                }
            }
            
            if(craeteSamplesList.Size()>0){       
                insert craeteSamplesList;
            }            
        }
        
        return craeteSamplesList;      
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
    
    //UPDATE ALL FARMS OF SELECTED CLIENT FARMERS
    @AuraEnabled
    public static void updateClientFarmerAllFarms(List<Account> SelectedClientFarmer, ID LotId, List<FAUP_Sample__c> SampleRecords) {
        
        List<Farm__c> updatedFarms = new List<Farm__c>();
        Map<Id, List<Farm__c>> clientFarmsMap = new Map<Id, List<Farm__c>>();
        Set<ID> Setclientfarmer = new Set <Id>();
        
        String LotName = null;
        
        List<FAUP_LOT__c> ClientFarmerList = [SELECT Id, Name FROM FAUP_LOT__c WHERE Id = :LotId LIMIT 1];
        LotName = ClientFarmerList[0].Name;
        
        if (SampleRecords != null && !SampleRecords.isEmpty()) {
            
            for (FAUP_Sample__c sample : SampleRecords) {
                clientFarmsMap.put(sample.Client_Farmer__c, new List<Farm__c>());
                Setclientfarmer.add(sample.Client_Farmer__c);
            }
            
            List<Farm__c> farmsList = [SELECT Id, Name, UP_Sample_Collect__c, Client_Farmer__c 
                                       FROM Farm__c 
                                       WHERE Client_Farmer__c IN :Setclientfarmer 
                                       AND UP_Sample_Collect__c = false];
            
            for (Farm__c farm : farmsList) {
                clientFarmsMap.get(farm.Client_Farmer__c).add(farm);
            }
            
            for (FAUP_Sample__c sample : SampleRecords) {
                List<Farm__c> farmsToUpdate = clientFarmsMap.get(sample.Client_Farmer__c);
                
                // Iterate through the farms associated with the client farmer and perform updates
                for (Farm__c farm : farmsToUpdate) {
                    // Perform your updates here
                    farm.UP_Sample__c = sample.Id;  // Assign the appropriate FAUP_Sample__c ID
                    farm.UP_Sample_Collected_Date__c = System.now();
                    farm.UP_Sample_Collect__c = true;
                    farm.FAUP_LOT_Name__c = LotName;
                    
                    // Add the updated farm to the list of updated records
                    updatedFarms.add(farm);
                }
            }
            
            // Update the records
            update updatedFarms;
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
}