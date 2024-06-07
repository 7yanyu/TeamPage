
import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';
import {employee} from  '../../../entity/employee'

export function FindCon(confirm_process: string): Promise<employee[]> {
  return new Promise<employee[]>((resolve, reject) => {
    let httpRequest = http.createHttp();
    console.log(confirm_process + '123');
    const url = `${Baseurl()}employee/findbyprocess?confirm_process=${encodeURIComponent(confirm_process)}`;
    console.log('url:' + url);

    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response => {
        console.log(`Response received with status code: ${response.responseCode}`);
        if (response.responseCode == 200) {
          // 解析响应数据
          let responseData = JSON.parse(response.result.toString());
          if (Array.isArray(responseData)) {
            resolve(responseData);
          } else {
            resolve([responseData]);
          }
        } else {
          // 处理错误响应
          reject(`请求失败，状态码：${response.responseCode}`);
        }
      })
      .catch(error => {
        reject(`请求失败，错误信息：${error}`);
      });
  });
}
