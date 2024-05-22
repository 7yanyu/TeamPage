
import http from '@ohos.net.http';
import { User } from '../entity/User';
import { requestTest } from '../module/PostTest';

export async  function Login(user:User){
  const result= await requestTest('182.92.245.184:8012/user/login',http.RequestMethod.POST,user)
  console.log('result:',result)
  return result
}