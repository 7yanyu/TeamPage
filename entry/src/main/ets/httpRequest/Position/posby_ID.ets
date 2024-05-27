import http from '@ohos.net.http'
import { Position } from '../../entity/Position'

export function  posby_ID(pos_id:number):Promise<Position[]>{
  return new Promise<Position[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url=pos_id==0?'localhost:8080/position/findAll':`localhost:8080/position/findbyID?id=${pos_id}`
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