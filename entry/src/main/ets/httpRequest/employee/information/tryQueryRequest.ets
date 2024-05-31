
import http from '@ohos.net.http'
import { employee } from '../../../entity/employee'
import { Findemp } from '../../../entity/Findemp'
import { Baseurl } from '../../../module/BaseUrl'

export function tryRequest(emp:Findemp):Promise<employee[]>{
  return new Promise<employee[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()

    const url=Baseurl()+'employee/findbyall'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData: {
          'datea':emp.datea,
          'dateb':emp.dateb,
          'intern_situation':emp.intern_situaiton
        }
      }
    )
      .then(response=>{
        if(response.result){
          console.log('success:'+response.result.toString())
          resolve(JSON.parse(response.result.toString()))
        }else {
          console.log('failed:'+JSON.parse(response.result.toString()))
          reject(response.responseCode)
        }
      })
      .catch(error=>{
        console.log(error)
        reject('error:'+error)
      })
  })
}