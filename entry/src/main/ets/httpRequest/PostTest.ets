import http from '@ohos.net.http';


export function requestTest(url:string,method:http.RequestMethod.POST,requestData?:any){
  let httpRequest = http.createHttp()
  httpRequest.request(
    url,
    {
      method:method,
      header:{
        'Content-Type':'application/json'
      },
      extraData:JSON.stringify(requestData),
      connectTimeout:60000,
      readTimeout:60000,
    },
    (err,data)=>{
      if(!err){
        console.log('Login successful:',data);
      }else{
        console.log('Login failed:',err)
      }
    }
  )
}