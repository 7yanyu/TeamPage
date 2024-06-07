import http from '@ohos.net.http';
import {Process} from  '../../../entity/Process'
import { Baseurl } from '../../../module/BaseUrl'
export function ADD_Process(process:Process):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employee/confirm'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(process),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='已处理'){
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}
export function ADD_Reject(process:Process):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employee/reject'
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(process),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='已处理'){
          console.log(response.result.toString())
          resolve(response.result.toString())
        }else{
          console.log('failed'+response.result.toString())
          resolve(response.result.toString())
        }
      })
  })
}
// 过滤空值字段的函数
export function filterEmptyFields(pro:Process): Process {
  const filteredEmp: Process = { ...pro }; // 复制一份员工对象
  // 遍历员工对象的每个属性
  for (const key in filteredEmp) {
    // 如果属性值为空字符串，将其删除
    if (filteredEmp[key] === '') {
      delete filteredEmp[key];
    }
  }
  return filteredEmp;
}