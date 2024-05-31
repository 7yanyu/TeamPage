//试用期管理操作请求
import http from '@ohos.net.http';
import { employee } from '../../../entity/employee';
import { Baseurl } from '../../../module/BaseUrl';


export function tryChangeRequest(emp:employee):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+'employee/update'
    console.log('empJson:'+JSON.stringify(emp))

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.PUT,
        extraData: {
          'emp_ID':emp.emp_ID,
          'intern_situation':emp.intern_situation,
          'confirm_date':emp.confirm_date,
          'intern_detail':emp.intern_detail
        }
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