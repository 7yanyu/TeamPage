import http from '@ohos.net.http';
import  {Findemp} from '../../entity/Findemp'
import  {employee} from  '../../entity/employee'
import { Baseurl } from '../../module/BaseUrl'
export function Find_join(findemp:Findemp):Promise<employee[]>{
  return new Promise<employee[]>((resolve,reject)=>{
    let httpRequest=http.createHttp()
    const url = Baseurl()+'employee/findbyall'

    httpRequest.request(
      url,
      {
        method:http.RequestMethod.POST,
        extraData:{
          datea: findemp.datea,
          dateb:findemp.dateb
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