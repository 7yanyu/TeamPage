
import http from '@ohos.net.http'
import { Baseurl } from '../../module/BaseUrl'



export function Delete_dim(emp_ID:number):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+`dimission/delete?id=${emp_ID}`

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET,
        // header:{
        //   'Content-Type':'application/json'
        // }
      }
    )
      .then((response)=>{
        if(response.result=='删除成功'){
          console.log(response.result.toString())
          resolve(true)
        }else{
          resolve(false)
        }
      })
      .catch((error)=>{
        reject(`删除失败:${error.message}`)
      })
  })
}