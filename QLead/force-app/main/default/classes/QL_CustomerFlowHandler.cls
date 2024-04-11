public without sharing class  QL_CustomerFlowHandler {
    
    @InvocableMethod(label='Get/Update Account Details')
    public static List<Account> getUniqueToken(List<Request> req){
        String uniqueId = req[0].uniqueId;
        Account accnt = req[0].acc;
        if(uniqueId != null){
            List<Account> acc = [select Id, FirstName, LastName, PersonEmail, Phone, Date_of_Birth__c, T_Shirt_Size__c, Shoe_Size__c, Loyalty_Customer_ID__c,Profile_Completed__c from account where Customer_ID__c =:uniqueId];
            if(acc.Size()>0){
                return acc;
            }
        }else{
            
            RequestBody reqBody = new RequestBody();
            reqBody.email = accnt.PersonEmail;
            reqBody.tshirtSize = accnt.T_Shirt_Size__c;
            reqBody.shoeSize = accnt.Shoe_Size__c;
            
            API_URL_Token__mdt urlToken = [SELECT Id, DeveloperName, Endpoint__c, Token__c FROM API_URL_Token__mdt where DeveloperName ='QLead_Task' limit 1];
            
            HTTP ht = new HTTP();
            HTTPRequest rq = new HTTPRequest();
            rq.setMethod('POST');
            rq.setEndpoint(urlToken.Endpoint__c);
            rq.setBody(JSON.serialize(reqBody));
            system.debug(JSON.serialize(reqBody));
            
            HTTPResponse resp = ht.send(rq);
            ResponseBody respBody = (ResponseBody)JSON.deserialize(resp.getBody(), ResponseBody.class);
            system.debug('Status Code: '+ resp.getStatusCode() + ' Status: ' + resp.getStatus());
            system.debug('Response: '+ resp.getBody());
            if(resp.getStatusCode() == 200){
                accnt.Loyalty_Customer_ID__c = respBody.customer_id;
            }else{
                system.debug('Error in API Call --> ' + respBody.message);
            }
            
            update accnt;
        }
        
        return null;
    }  
    
    public class Request {
        @InvocableVariable(label='uniqueId')
        public String uniqueId;
        
        @InvocableVariable(label='Account')
        public Account acc;
    }
    
    public class RequestBody{
        public string email;
        public string tshirtSize;
        public double shoeSize;
    }
    public class ResponseBody{
        public string status;
        public string customer_id;
        public string message;
    }
}