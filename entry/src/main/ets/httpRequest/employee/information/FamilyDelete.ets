import http from '@ohos.net.http';
import { Baseurl } from '../../../module/BaseUrl';

export function familyDelete(relation_ID: number): Promise<boolean> {
  return new Promise<boolean>((resolve, reject) => {
    let httpRequest = http.createHttp();
    const url = `${Baseurl()}family/delete?relation_ID=${relation_ID}`; // 将 relation_ID 作为查询参数

    httpRequest.request(
      url,
      {
        method: http.RequestMethod.DELETE,
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response => {
        if (response.result === '删除成功') {
          resolve(true);
        } else {
          resolve(false);
        }
      })
      .catch(error => {
        reject(error);
      });
  });
}
