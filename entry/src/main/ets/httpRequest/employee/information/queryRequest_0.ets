
import http from '@ohos.net.http';
import { employee } from '../../../entity/employee';
import { Baseurl } from '../../../module/BaseUrl';

export function queryRequest_0():Promise<employee[]>{
  return new Promise<employee[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'employee/findAll'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          console.log('result:'+response.result.toString())
          resolve(JSON.parse(response.result.toString()))
        }
      })
  })
}