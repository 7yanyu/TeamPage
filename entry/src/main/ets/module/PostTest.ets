import http from '@ohos.net.http';


export function requestTest(url:string,method:http.RequestMethod.POST,requestData?:any):Promise<boolean>{
  return new Promise((resolve,reject)=>{
    let httpRequest = http.createHttp()
    httpRequest.request(
      url,
      {
        method:method,
        extraData: {
          'account':requestData.username,
          'password':requestData.password
        }
        // connectTimeout:60000,//连接超时时间
        // readTimeout:60000,//读取超时时间(单位：ms),默认均为60s
      }
    )
      .then(response=>{
        if(response.result)
        {
          console.log('success'+response.responseCode)
          // console.log('username:'+requestData.account+'password:'+requestData.password)
          console.log('username:'+requestData.username+'password:'+requestData.password)
          console.log(response.result.toString())
          resolve(true)

        }else{
          console.log('failed'+response.responseCode)
          // console.log('username:'+requestData.account+'password:'+requestData.password)
          console.log('username:'+requestData.username+'password:'+requestData.password)
          console.log(response.result.toString())
          reject(false)
        }
      })
  })

}