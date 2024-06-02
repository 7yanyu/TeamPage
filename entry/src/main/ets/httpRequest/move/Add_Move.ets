import http from '@ohos.net.http';
import {EmployeeMov} from  '../../entity/EmployeeMov'
import {Process} from  '../../entity/Process'
import { Baseurl } from '../../module/BaseUrl'
export function ADD_Move(empmov:EmployeeMov):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employeemov/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(empmov),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='添加成功1'){
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}
export function ADD_Process(process:Process):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employeemov/process'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(process),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}