
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Family } from '../../../pages/employee/information/familyPage';


export function familyAdd(fan:Family):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'family/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(fan)
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
          resolve(true)
        }else{
          resolve(false)
        }
      })
      .catch(error=>{
        reject(error)
      })
  })
}