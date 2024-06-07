
import http from '@ohos.net.http';
import { DimUser } from '../../entity/DimUser';
import { Baseurl } from '../../module/BaseUrl';


export function findByProcess(process:string):Promise<DimUser[]>{
  return new Promise<DimUser[]>((resolve,reject)=>{

    console.log('process:'+process)
    let httpRequest =http.createHttp()
    let  url=''
    if(process=='待处理'||process=='已拒绝'){
      url=`${Baseurl()}dimission/findbyprocess?process_state=${encodeURIComponent(process)}`
    }else {
      url=`${Baseurl()}dimission/finddimissed?process_state=${encodeURIComponent(process)}`
    }

    console.log(url)
    // const url=`${Baseurl()}dimission/findbyprocess?process_state=${encodeURIComponent(process)}`
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          console.log(JSON.parse(response.result.toString()))
          console.log(response.result.toString())

          resolve(JSON.parse(response.result.toString()))
        }else {
          console.log(JSON.parse(response.result.toString()))
          console.log(response.result.toString())
          reject(response.result)
        }
      })
      .catch(error=>{
        console.log('error: '+error)
      })


  })
}