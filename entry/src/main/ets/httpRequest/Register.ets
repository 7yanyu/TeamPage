import http from '@ohos.net.http';
import { Users } from '../entity/Users';
import { Baseurl } from '../module/BaseUrl';
export async function Register( user:Users) :Promise<string> {
  // @ts-ignore
  return new Promise((resolve, reject) => {
    let httpRequest = http.createHttp();
    const url=Baseurl()+'user/register'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(user)
      }) .then(response => {
      if (response.result=='注册成功') {
        console.log('注册成功');
        resolve(response.result.toString());
      } else {
        console.log('注册失败');
        resolve(response.result.toString()); ;
      }

    }

    ) .catch(error => {
      console.error('注册请求失败', error);
      reject(error); // 如果请求失败，reject Promise 并传递错误信息
    });

  })
}