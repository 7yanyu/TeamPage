import http from '@ohos.net.http'
import { Baseurl } from '../../module/BaseUrl';
export function ReportByDate(startDate:string,endDate:string):Promise<void>{
  return new Promise<void>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url =  Baseurl()+`/api/reports/employees/date?startDate=${startDate}&&endDate=${endDate}`;
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

        resolve()
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