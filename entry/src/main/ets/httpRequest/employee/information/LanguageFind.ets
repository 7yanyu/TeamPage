
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Language } from '../../../pages/employee/information/languagePage';

export function languageFind(id:number):Promise<Language[]>{
  return new Promise<Language[]>((resolve,reject)=>{
    let httpRequest = http.createHttp()
    const url=Baseurl()+'language/findbyemp?emp_ID='+id

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          console.log('result:'+JSON.parse(response.result.toString()))
          resolve(JSON.parse(response.result.toString()))
        }else {
          reject(response.responseCode)
        }
      })
      .catch(error=>{
        console.log(error)
        reject(error)
      })
  })
}