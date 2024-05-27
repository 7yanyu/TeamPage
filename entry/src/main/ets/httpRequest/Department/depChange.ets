
import http from '@ohos.net.http';
import { Department } from '../../entity/Department';


export function Change_dep(department:Department):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest = http.createHttp()

    const url='localhost:8080/department/update'
    console.log('url:'+url)
    console.log(department.creat_date)

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.PUT,
        extraData:JSON.stringify(department)
      }
    )
      .then((response)=>{
        if(response.result=='更新成功'){
          console.log(response.result.toString())
          resolve(true)
        }else{
          console.log(response.result.toString())
          resolve(false)
        }
      })
      .catch((error)=>{
        reject(`请求失败：${error.message}`)
      })
  })
}