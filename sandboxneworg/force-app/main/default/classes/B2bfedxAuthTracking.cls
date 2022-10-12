public with sharing class B2bfedxAuthTracking {
   @AuraEnabled
    public static String getToken()
    {        
         String grantType = 'client_credentials';
         String clientId = 'l7b03fe79a20f94909b6cec7839941efab';
     	   String clientSecret = '5f86c15cd8ac45b8bc871b0c0f3e10c4';	
         Http http = new Http();
         HttpRequest request = new HttpRequest();  
         request.setEndpoint('https://apis-sandbox.fedex.com/oauth/token');
         request.setMethod('POST');
         request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
         request.setHeader('Accept', 'application/json');         
         String payload = 'client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&grant_type='+EncodingUtil.urlEncode(grantType,'UTF-8');
     	   //System.debug(payload);        
     	   request.setBody(payload);
         
         HttpResponse response = http.send(request);
         if (response.getStatusCode() != 200) {
             System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
         } 
         System.debug(response.getBody());
         
         Map<String, String> m = (Map<String, String>) JSON.deserialize(response.getBody(), Map<String, String>.class);
 		     String accessToken = m.get('access_token');
         
         return accessToken;
     } 
    @AuraEnabled
    public static Map<String,Object> sendRequest(Map<String, Object> trackingno){

      System.debug('Map-->' + trackingno);
       
       String trackNum = (String)trackingno.get('trackingNum');
       System.debug('tracking number ==>'+ trackNum);
        
         Http http = new Http();
         HttpRequest request = new HttpRequest(); 
 
         String token = getToken();
 
         //String token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJDWFMiLCJTRUNVUkUiXSwiUGF5bG9hZCI6ImFLcEpEZEJ1MXN4WmY3bEpFOUxxd2g3OEFCZ3FCSzcxa2hvdkRnWHpWWUtyeTg2bTdkWkdFR1lUbVd2WGx5a3B2OWJ0RHljU3pqVTB2UWhKM1JONnZGb2dLcklIZE8zQjNEUXJqZlU2OUJWSnpXSVAwQlF4UlFsN0FCMjJOdUNwZHVnNTNuV0d0RzVFQTltR3lET2NCcityeSswMkpUd0c4R3RDS1BYa05uQ1BvcFdNQ2VlRU1vVkVSK3JqS1BPY0hUZmltWGY5M0thTWNHbXlxQ0R4WmpVeHY5Y0hzMEIzdnV3cUlRbXFiSlBSVVAyaWljS1JyY3RYTHczOWZqdFZXTHVud1FHZ0xtYk5YMWVyb21oSVEvaHJRQzZMWTJwTHd0bGFaRkdRVzNFPSIsImV4cCI6MTY1Mjc5NDEwMCwianRpIjoiYzI1ZGQ4OTgtYzk1NC00ZGM3LWE1M2MtNGQzYTg4ZTMwYTIyIiwiY2xpZW50X2lkIjoibDdiMDNmZTc5YTIwZjk0OTA5YjZjZWM3ODM5OTQxZWZhYiJ9.N6NuVss_wBMZKqYrKCyR6W6Hy6fw-0GurfjGHW7FC0BR30cT902AeCErkyL4D5S2j7YvglV1NofHXYbGiqi74eszLfIiSi6hGrKDf5BIs0pBBq3cPdPmKDzqhn-zcTM829hA8Z7usQcTy1hj8K_6J8JeMf0kMWbSiYcqWPjcpWTltqLN-FI_qbcYLZH8H-jgu7mRkYdmMXbZ2IdXdQfsue1PijwRSMjrss8RAYkjTD2b-UXj1EbQNlFkV_CsFvcj0CnTsIUfsi6bujrL4qa48y3CaDCinwFh8NoSR6cgFVVWLXsO-B2dnaqKW0289vBpssHHxT5tF0qStXT-_XQqIlwv1Z9qBcDplydX7-KAKOansknvcu-AoPqHRMKsDebOuMgIFNYWYCXuFsktx0likbE46v7kMBA23efHpxnlluPYhu6ndQiuoZt7pB9rdF7LcitVS4b454mVtGiAU0qw52jsFLTj5WdNM2vkEbzvStN-YixUH2_2SjdtFepygXdAT0LYTO6mU-MKwOKgaLpmIM3NvlRICgg1UHODDx8F5Be9wtprP7nNCLaHLIb_LkztgLJ7qDLbiFVirQMDSd-pO2BYqp-6vYRv6CuJlzT6jvHMYrr25g2uhZz6C2oF_zYKyirB57MQtiuigPUxxgumjD4Gi0D2PWhxKmJPfuc22HE';  
         request.setEndpoint('https://apis-sandbox.fedex.com/track/v1/trackingnumbers');
         request.setMethod('POST');
         request.setHeader('x-customer-transaction-id','624deea6-b709-470c-8c39-4b5511281492');
         request.setHeader('x-locale', 'en_US');
         request.setHeader('Content-Type', 'application/json');
         request.setHeader('Accept', 'application/json');
         request.setHeader('Authorization', 'Bearer ' + token);
         
         request.setBody('{'+
         '"includeDetailedScans": true,'+
         '"trackingInfo": ['+
           '{'+
             '"trackingNumberInfo": {'+
               '"trackingNumber":' + trackNum +
             '}'+
           '},'+
           '{'+
             '"trackingNumberInfo": {'+
               '"trackingNumber": "128667043726",'+
               '"carrierCode": "FDXE",'+
               '"trackingNumberUniqueId": "245822~123456789012~FDEG"'+
             '},'+
             '"shipDateBegin": "2020-03-29",'+
             '"shipDateEnd": "2020-04-01"'+
           '}'+
         ']'+
       '}');

         
         HttpResponse response = http.send(request);
        //  if (response.getStatusCode() == 200)
        //   {
        //    //Map<String,Object> mapResponse = (Map<String,Object>)JSON.deserialize(response.getBody(), Map<String,Object>.class);
 		    //   //  String accessToken = m.get('token');
        //   //  return accessToken;
          
        //   System.debug(response.getBody());
        //   return response.getBody();
        //  // System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());            
        // } 
        //  else
        //   {
        //       return null ;
        //   }
        String Body = response.getBody();
        Map<String,Object> mapResponse = (Map<String,Object>)JSON.deserializeUntyped(Body);
        System.debug(mapResponse);
        return mapResponse;
     }
        
}