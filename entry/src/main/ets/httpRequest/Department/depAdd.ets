
import http from '@ohos.net.http';
import { Department } from '../../entity/Department';

export function Add_dep(department:Department):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = 'localhost:8080/department/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(department)
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
          resolve(response.result.toString())
        }else{
          console.log(response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}