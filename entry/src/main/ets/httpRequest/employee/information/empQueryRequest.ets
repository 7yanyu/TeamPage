
import http from '@ohos.net.http';
import { employee } from '../../../entity/employee';
import { Baseurl } from '../../../module/BaseUrl';

export function queryRequest(emp:employee):Promise<employee[]>{
  return new Promise<employee[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'employee/findbyall'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData: {
          'emp_ID':emp.emp_ID,
          'pos_ID':emp.pos_ID,
          'dep_ID':emp.dep_ID,
          'entermode':emp.entermode
        }
      }
    )
      .then(response=>{
        if(response.result){
          console.log('success:'+response.responseCode)
          console.log(response.result.toString())
          resolve(JSON.parse(response.result.toString()))
        }else{
          reject(response.result)
        }
      })
  })
}