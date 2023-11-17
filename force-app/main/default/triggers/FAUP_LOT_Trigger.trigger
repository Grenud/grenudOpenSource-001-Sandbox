trigger FAUP_LOT_Trigger on FAUP_LOT__c (before insert,before update) {
    if(trigger.isBefore && trigger.isinsert){
      FAUP_LOT_Handler.checkLotResults(trigger.new); 
    }
    
    if(trigger.isBefore && trigger.isupdate){
     FAUP_LOT_Handler.updateSuspect(trigger.new);
     FAUP_LOT_Handler.checkLotResults(trigger.new);
    }

}