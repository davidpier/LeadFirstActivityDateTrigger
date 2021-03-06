trigger LeadFirstActivityDate on Task (before insert, before update) {

    List<Id> leadIds=new List<Id>();
    for(Task t:trigger.new){
        if(t.Status=='Completed' && (t.whoId != null)){
            if(String.valueOf(t.whoId).startsWith('00Q')==TRUE){
                leadIds.add(t.whoId);
            }
        }
    }
    
    List<Lead> leadsToUpdate=[SELECT Id, First_Activity_Date__c FROM Lead WHERE Id IN :leadIds AND IsConverted=FALSE AND First_Activity_Date__c=NULL];
    For (Lead l:leadsToUpdate){
        l.First_Activity_Date__c = date.today();
    }
    
    try{
        update leadsToUpdate;
    }catch(DMLException e){
        system.debug('Leads were not all properly updated.  Error: '+e);
    }
}
