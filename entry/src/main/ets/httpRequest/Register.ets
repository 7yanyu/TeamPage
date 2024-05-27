import http from '@ohos.net.http';
import { Users } from '../entity/Users';
export async function Register( user:Users) :Promise<boolean> {
  // @ts-ignore
  return new Promise((resolve, reject) => {
    let httpRequest = http.createHttp();
    httpRequest.request(
      '182.92.245.184:8012/user/register',
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(user)
      }) .then(response => {
      if (response.result!=0) {
        console.log('注册成功');
        resolve(true);
      } else {
        console.log('注册失败');
        resolve(false); ;
      }

    }

    ) .catch(error => {
      console.error('注册请求失败', error);
      reject(error); // 如果请求失败，reject Promise 并传递错误信息
    });

  })
}