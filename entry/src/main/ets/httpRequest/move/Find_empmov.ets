import http from '@ohos.net.http';
import  {Movtime} from '../../entity/Movtime'
import  {EmployeeMov} from  '../../entity/EmployeeMov'
import { Baseurl } from '../../module/BaseUrl'
export function Find_empmov(movtime:Movtime):Promise<EmployeeMov[]>{
  return new Promise<EmployeeMov[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'employeemov/findby'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(movtime),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result){
          let responseData=(JSON.parse(response.result.toString()))
          // console.log(responseData)
          if (Array.isArray(responseData)) {
            resolve(responseData);
          } else {
            resolve([responseData]);
          }
        }else{
          reject('请求错误'+response.cookies)
        }
      })
  })
}

// 过滤空值字段的函数
export function filterEmptyFields(movetime:Movtime): Movtime {
  const filteredEmp: Movtime = { ...movetime }; // 复制一份员工对象
  // 遍历员工对象的每个属性
  for (const key in filteredEmp) {
    // 如果属性值为空字符串或数值为0，将其删除
    if (filteredEmp[key] === '' || filteredEmp[key] === 0) {
      delete filteredEmp[key];
    }
  }
  return filteredEmp;
}