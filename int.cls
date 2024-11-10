public class omdbmovie{
    private static final string movieapikey='1c939cf6';
    private static final string movieurl='https://www.omdbapi.com/?apiKey='+movieapikey;
    
    @AuraEnabled(cacheable=true)
    public static string searchmovie(String query){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(movieurl+'&t='+EncodingUtil.urlEncode(query, 'UTF-8'));
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            return response.getBody();
    }
        else {
            throw new AuraHandledException('Failed to fetch movies.');
        }
    }
}
