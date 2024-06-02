import http from '@ohos.net.http'
import {DimUser} from '../../entity/DimUser'
import { Baseurl } from '../../module/BaseUrl';
export function dimbyDate(startDate:string,endDate:string):Promise<DimUser[]>{
  return new Promise<DimUser[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url =  Baseurl()+`dimission//findByDateRange?startDate=${startDate}&&endDate=${endDate}`;
    console.log('url:'+url)
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }
    )  .then(response => {
      console.log(`Response received with status code: ${response.responseCode}`)
      if (response.responseCode === 200) {
        // 解析响应数据
        let responseData = JSON.parse(response.result.toString())
        if (Array.isArray(responseData)) {
          resolve(responseData);
        } else {
          resolve([responseData]);
        }
      } else {
        // 处理错误响应
        reject(`请求失败，状态码：${response.responseCode}`)
      }
    })
      .catch(error=>{
        reject('请求错误'+error.message)
      })

  }








  )
}