import http from '@ohos.net.http';
import { User } from '../entity/User';
import { Baseurl } from '../module/BaseUrl';


export function Login(user:User):Promise<string>{
  return new Promise((resolve,reject)=>{
    let httpRequest = http.createHttp()

    const url=Baseurl()+'user/login'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData: {
          'account':user.username,
          'password':user.password
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
          console.log('username:'+user.username+'password:'+user.password)
          console.log(response.result.toString())
          resolve(response.result.toString())

        }else{
          console.log('failed'+response.responseCode)
          // console.log('username:'+requestData.account+'password:'+requestData.password)
          console.log('username:'+user.username+'password:'+user.password)
          console.log(response.result.toString())
          resolve(response.result.toString())
        }
      })
      .catch(error=>{
        resolve(error)
      })
  })

}