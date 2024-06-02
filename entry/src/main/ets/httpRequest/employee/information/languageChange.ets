
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Language } from '../../../pages/employee/information/languagePage';

export function languageChange(lan:Language):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'language/update'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.PUT,
        extraData:JSON.stringify(lan)
      }
    )
      .then(response=>{
        if(response.result=='更新成功'){
          console.log('code:'+response.responseCode+',result:'+response.result)
          resolve(true)
        }else {
          console.log('code:'+response.responseCode+',result:'+response.result)
          resolve(false)
        }
      })
      .catch(error=>{
        console.log('failed , error message:'+error)
        reject(error)
      })
  })
}