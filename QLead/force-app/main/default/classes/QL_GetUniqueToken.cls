public class QL_GetUniqueToken {
    
    @InvocableMethod(label='Generate Unique Id')
    public static List<Response> getUniqueToken(){
        
        List<Response> respList = new List<Response>();
        Response resp = new Response();
        
        try{
            UUID randomUUID = UUID.randomUUID();
            String randomUUIDString = randomUUID.toString();
            system.debug(randomUUIDString);
            resp.uniqueId = randomUUIDString;
            
        }catch(exception e){
            system.debug('Error occurred: ' + e.getMessage());
            resp.errorMessage = e.getMessage();
        }
        respList.add(resp);
        system.debug(respList);
        return respList;
    }
    
    public class Response {
        @InvocableVariable(label='uniqueId')
        public String uniqueId;
        
        @InvocableVariable(label='Error Message')
        public String errorMessage;
    }
    
    
    
    public static String getUniqueToken2(){
  
        try{
            UUID randomUUID = UUID.randomUUID();
            String randomUUIDString = randomUUID.toString();
            system.debug(randomUUIDString);
            return randomUUIDString;
            
        }catch(exception e){
            system.debug('Error occurred: ' + e.getMessage());
            return null;
        }
    }
}