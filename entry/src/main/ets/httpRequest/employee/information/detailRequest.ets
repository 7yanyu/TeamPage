
import http from '@ohos.net.http';
import { employee } from '../../../entity/employee';
import { Baseurl } from '../../../module/BaseUrl';

export function detailRequest(emp:employee):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest =http.createHttp()
    const url=Baseurl()+'employee/update'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.PUT,
        extraData:JSON.stringify(emp)
      }
    )
      .then(response=>{
        if(response.result=='更新成功'){
          console.log('code:'+response.responseCode+',result:'+response.result)
          resolve(true)
        }else{
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