import http from '@ohos.net.http'
import { Position } from '../../entity/Position'
import { Baseurl } from '../../module/BaseUrl'

export function  posby_ID(pos_id:number):Promise<Position[]>{
  return new Promise<Position[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=pos_id==0?Baseurl()+'position/findAll':Baseurl()+`position/findbyID?id=${pos_id}`
    httpRequest.request
    (
      // `182.92.245.184:8012/position/findbyID?id=${pos_id}`,
      // `localhost:8080/position/findbyID?id=${pos_id}`,
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          let responseData=(JSON.parse(response.result.toString()))
          // console.log(responseData)
          if(pos_id==0){
            resolve(responseData)
          }else {
            resolve([responseData])
          }
        }else{
          reject('请求错误'+response.cookies)
        }
      })
      .catch(error=>{
        reject('请求错误'+error.message)
      })
  })

}
export function  depby_ID(dep_id:number):Promise<Position[]>{
  return new Promise<Position[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=Baseurl()+`position/findbydep?dep_id=${dep_id}`
    httpRequest.request
    (
      // `182.92.245.184:8012/position/findbyID?id=${pos_id}`,
      // `localhost:8080/position/findbyID?id=${pos_id}`,
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response=>{
        if(response.result){
          let responseData=(JSON.parse(response.result.toString()))
          // 确保返回的数据是数组
          if (Array.isArray(responseData)) {
            resolve(responseData);
          } else {
            resolve([responseData]);
          }

        }else{
          reject('请求错误'+response.cookies)
        }
      })
      .catch(error=>{
        reject('请求错误'+error.message)
      })
  })

}