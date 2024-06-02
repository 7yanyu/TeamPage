
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Family } from '../../../pages/employee/information/familyPage';
import { Language } from '../../../pages/employee/information/languagePage';

export function familyFind(id:number):Promise<Family[]>{
  return new Promise<Family[]>((resolve,reject)=>{
    let httpRequest = http.createHttp()
    const url=Baseurl()+'family/findbyemp?emp_ID='+id

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