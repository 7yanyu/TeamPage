import http from '@ohos.net.http';


export function requestTest(url:string,method:http.RequestMethod.POST,requestData?:any){
  let httpRequest = http.createHttp()
  httpRequest.request(
    url,
    {
      method:method,
      extraData:JSON.stringify(requestData)
      // connectTimeout:60000,//连接超时时间
      // readTimeout:60000,//读取超时时间(单位：ms),默认均为60s
    }/*,
    (err,data)=>{
      if(!err){
        console.log('Login successful:',data);
      }else{
        console.log('Login failed:',err)
      }
    }*/
  )
    .then(response=>{
      if(response.responseCode==200)
      {
        console.log('success'+response.responseCode)
      }else{
        console.log('failed'+response.responseCode)
      }
    })
}