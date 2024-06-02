
import http from '@ohos.net.http'
import { Baseurl } from '../../module/BaseUrl'



export function Delete_Mov(mov_ID:number):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+`employeemov/delete?mov_ID=${mov_ID}`

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.DELETE,
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