
import http from '@ohos.net.http';
import { Position } from '../../entity/Position';
import { Baseurl } from '../../module/BaseUrl';


export function Change_pos(position:Position):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{
    let httpRequest = http.createHttp()

    const url=Baseurl()+'position/update'
    console.log('url:'+url)

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(position)
      }
    )
      .then((response)=>{
        if(response.result=='更新成功'){
          console.log(response.result.toString())
          resolve(true)
        }else{
          console.log('failed'+response.result.toString())
          resolve(false)
        }
      })
      .catch((error)=>{
        reject(`请求失败：${error.message}`)
      })
  })
}