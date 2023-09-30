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
}