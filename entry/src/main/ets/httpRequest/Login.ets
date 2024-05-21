
import http from '@ohos.net.http';
import { User } from '../entity/User';
import { requestTest } from './PostTest';

export function Login(user:User){
  return requestTest('localhost:8080/user/login',http.RequestMethod.POST,user)
}