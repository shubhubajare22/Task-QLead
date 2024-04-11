public class QL_SendEmailToCustomer {
	
    
    public static void sendProfileUpdateEmail(List<Account> accList){
        String emailTemplateName = 'Update_Customer_Profile';
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =:emailTemplateName];
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'test'];
        for(Account acc: accList){
            List<string> toAddress = new List<string>();
            toAddress.add(acc.PersonEmail);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTemplateId(et.Id);
            email.setToAddresses(toAddress);
            system.debug('acc---> ' + acc.IsPersonAccount);
            email.setTargetObjectId(acc.PersonContactId);
            email.setOrgWideEmailAddressId(owea[0].Id);
            //email.plainTextBody = 'This is the message body.';
            //email.setWhatId(cs.contactId);
            //email.setSaveAsActivity(true);
            //email.setUseSignature(false);
            emails.add(email);
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
        system.debug(results);
    }
}