
import http from '@ohos.net.http';
import { Process } from '../../entity/Process';
import { Baseurl } from '../../module/BaseUrl';

export function agreeDim(agree:Process):Promise<boolean>{
  return new Promise<boolean>((resolve,reject)=>{

    let httpRequest=http.createHttp()
    const url=Baseurl()+'dimission/process'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(agree)
      }
    )
      .then(response=>{
        if(response.result=='已处理'){
          console.log('succeed:'+response.responseCode+response.result)

          resolve(true)
        }else {
          console.log('agree:'+JSON.stringify(agree))
          console.log('failed:'+response.responseCode+response.result)
          resolve(false)
        }
      })
  })
}