
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import { Family } from '../../../pages/employee/information/familyPage';

export function familyDelete(id:number):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'family/delete?relation_ID='+id

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.DELETE

      }
    )
      .then(response=>{
        if(response.result=='删除成功'){
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