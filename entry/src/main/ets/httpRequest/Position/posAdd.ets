
import http from '@ohos.net.http';
import { Position } from '../../entity/Position';
import { Baseurl } from '../../module/BaseUrl';

export function Add_pos(position:Position):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'position/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(position)
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