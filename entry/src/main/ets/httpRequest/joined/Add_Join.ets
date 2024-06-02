import http from '@ohos.net.http';
import  {employee} from  '../../entity/employee'
import { Baseurl } from '../../module/BaseUrl'
export function ADD_join(emp:employee):Promise<string>{
  return new Promise<string>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'/employee/add'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:JSON.stringify(emp),
        header: {
          'Content-Type': 'application/json'
        }
      }
    )
      .then(response=>{
        if(response.result=='添加成功'){
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
export function filterEmptyFields(emp: employee): employee {
  const filteredEmp: employee = { ...emp }; // 复制一份员工对象
  // 遍历员工对象的每个属性
  for (const key in filteredEmp) {
    // 如果属性值为空字符串，将其删除
    if (filteredEmp[key] === '') {
      delete filteredEmp[key];
    }
  }
  return filteredEmp;
}