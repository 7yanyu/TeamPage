import http from '@ohos.net.http';
import { Department } from '../entity/Department';

export function depby_ID(dep_id: number): Promise<Department[]> {
  return new Promise<Department[]>((resolve, reject) => {
    let httpRequest = http.createHttp();
    console.log(`Sending request to http://localhost:8080/department/find?id=${dep_id}`);

    const url = dep_id === 0 ? `http://localhost:8080/department/findAll` : `http://localhost:8080/department/find?id=${dep_id}`;

    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }
    ).then(response => {
      console.log(`Response received with status code: ${response.responseCode}`);
      if (response.responseCode === 200) {
        // 解析响应数据
        let responseData = JSON.parse(response.result.toString());
        if (dep_id === 0) {
          // 如果是查询所有部门，直接返回数组
          resolve(responseData);
        } else {
          // 如果是查询特定部门，将结果转换为数组返回
          resolve([responseData]);
        }
      } else {
        // 处理错误响应
        reject(`请求失败，状态码：${response.responseCode}`);
      }
    }).catch(error => {
      // 处理请求失败
      console.error(`请求失败，错误：${error.message}`);
      reject(`请求失败，错误：${error.message}`);
    });
  });
}
