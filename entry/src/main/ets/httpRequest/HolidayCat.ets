import http from '@ohos.net.http';
import  {Holiday} from  '../entity/Holiday'
import { Baseurl } from '../module/BaseUrl'
import {Process} from  '../entity/Process'
export function Find_holiday(process_state:string):Promise<Holiday[]>{
  return new Promise<Holiday[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = `${Baseurl()}holiday/findbyprocess?process_state=${encodeURIComponent(process_state)}`;
    console.log(url)
    console.log('12345')
    console.log(process_state)
    httpRequest.request(
      url,
      {
        method:http.RequestMethod.GET
      }
    )
      .then(response => {
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
export function ADD_Process(process:Process):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/holiday/process'
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
    const url = Baseurl()+'/holiday/reject'
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
