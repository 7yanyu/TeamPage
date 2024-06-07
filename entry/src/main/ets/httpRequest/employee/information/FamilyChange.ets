
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Family } from '../../../pages/employee/information/familyPage';

export function familyChange(fan:Family):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'family/update'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.PUT,
        extraData:JSON.stringify(fan)
      }
    )
      .then(response=>{
        if(response.result=='更新成功'){
          resolve(true)
        }else {
          resolve(false)
        }
      })
      .catch(error=>{
        reject(error)
      })
  })
}