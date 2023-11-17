public class GeneralFarmerTriggerHandler{
 public static void handleBeforeInsert(List<General_Farmer__c> newFarmers) {
   // Query the maximum series number from existing records
        Decimal maxSeries = 0;
        
        for (General_Farmer__c existingFarmer : [SELECT Series__c FROM General_Farmer__c]) {
            if (existingFarmer.Series__c > maxSeries) {
                maxSeries = existingFarmer.Series__c;
            }
        }

        // Update the new records with Name and Series values
        for (General_Farmer__c newFarmer : newFarmers) {
            if (newFarmer.Farmer_Name__c != null) {
                maxSeries++;
                newFarmer.Series__c = maxSeries;
                newFarmer.Name = 'GFN-23-' + newFarmer.Farmer_Name__c + '-' + maxSeries;
            }
        }
    }

    public static void handleBeforeUpdate(List<General_Farmer__c> updatedFarmers, Map<Id, General_Farmer__c> oldFarmersMap) {
        // Logic for before update event
        for (General_Farmer__c updatedFarmer : updatedFarmers) {
            if (updatedFarmer.Farmer_Name__c != null) {
                if (oldFarmersMap != null && oldFarmersMap.containsKey(updatedFarmer.Id)) {
                    // Check if Farmer_Name__c has changed during the update
                    if (!updatedFarmer.Farmer_Name__c.equals(oldFarmersMap.get(updatedFarmer.Id).Farmer_Name__c)) {
                        // Only update the Name field, Series__c remains unchanged
                        updatedFarmer.Name = 'GFN-23-' + updatedFarmer.Farmer_Name__c + '-' + updatedFarmer.Series__c;
                    }
                }
            }
        }
    }

    public static void preventDuplicatePhone(List<General_Farmer__c> newPaddyPurchases) {
        Set<String> phoneNumbers = new Set<String>();

        // Collect all phone numbers from the incoming records
        for (General_Farmer__c purchase : newPaddyPurchases) {
            if (String.isNotBlank(purchase.Phone__c)) {
                phoneNumbers.add(purchase.Phone__c);
            }
        }

        // Query for existing records with the same phone numbers
        List<General_Farmer__c> existingRecords = [SELECT Id, Phone__c FROM General_Farmer__c WHERE Phone__c IN :phoneNumbers];

        // Map existing phone numbers to their corresponding record Ids
        Map<String, Id> phoneToRecordIdMap = new Map<String, Id>();
        for (General_Farmer__c existingRecord : existingRecords) {
            phoneToRecordIdMap.put(existingRecord.Phone__c, existingRecord.Id);
        }

        // Check for duplicate phone numbers and prevent record creation or update
        for (General_Farmer__c purchase : newPaddyPurchases) {
            if (String.isNotBlank(purchase.Phone__c) && phoneToRecordIdMap.containsKey(purchase.Phone__c)) {
                purchase.addError('A record with this phone number already exists (Record ID: ' + phoneToRecordIdMap.get(purchase.Phone__c) + ')');
            }
        }
    }
}