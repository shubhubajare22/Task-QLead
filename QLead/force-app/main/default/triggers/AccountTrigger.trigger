trigger AccountTrigger on Account (before insert, after insert) {
    if(trigger.isBefore &&  trigger.isInsert){
        for(Account acc: trigger.new){
            if(acc.IsPersonAccount == true){
                String token = QL_GetUniqueToken.getUniqueToken2();
                system.debug('token--> ' + token);
                acc.Customer_ID__c = token ?? null;
            }
        } 
    }
    
    if(trigger.isAfter &&  trigger.isInsert){
        List<Account> perAccList = new List<Account>();
        for(Account acc: trigger.new){
            if(acc.IsPersonAccount == true){
                perAccList.add(acc);
            }
        }
        if(perAccList.Size() > 0){
            QL_SendEmailToCustomer.sendProfileUpdateEmail(perAccList);
        }
    }
    
}