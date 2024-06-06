import router from '@ohos.router'
import { employee } from '../../../../entity/employee'
import { detailRequest } from '../../../../httpRequest/employee/information/detailRequest'
@Entry
@Component
struct EmpDetailPage {
  @State message: string = '员工详细信息'
  @State emp:employee=new employee()
  @State empId:string=''

  onPageShow(){
    const params=router.getParams() as {employee:string}
    console.log('Params:', params); // 打印整个 params 对象
    if(params && params.employee){
      const employeeJson=params.employee
      console.log('employeeJson:',employeeJson)
      try {
        const employeeData=JSON.parse(employeeJson)
        this.emp=employeeData
        this.empId=employeeData.emp_ID
        console.log(this.empId)
      }catch (error){
        console.error('Failed to parse employee data', error);
      }
    }else {
      console.log('not found')
    }
  }


  build() {
    Column() {
      Row(){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            router.back()
          })
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({left:50})
        Blank()
        Button('修改')
          .backgroundColor('#36B8D0')
          // .fontColor('#36B8D0')
          .onClick(()=>{
            //update
            AlertDialog.show({
              title:'提示',
              message:'是否确认更改该员工信息',
              primaryButton:{
                value:'否',
                action:()=>{}
              },
              secondaryButton:{
                value:'是',
                action:()=>{
                  detailRequest(this.emp)
                    .then(response=>{
                      if(response){
                        console.log('员工详细信息更新成功')
                      }
                    })
                }
              }
            })

          })

      }
      .width('95%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row(){
        Image($r('app.media.person'))
          .width(100)
        Column({space:15}){
          TextInput({text:this.emp.emp_name})
            .width(100)
            .fontWeight(FontWeight.Bold)
            .onChange((value)=>{
              this.emp.emp_name=value
            })
          Text('员工ID:'+this.empId)

        }
        .width(150)
      }
      .width('90%')
      .margin(10)

      Column({space:10}){
        Row(){
          Text('性别:')
          Text(this.emp.gender)
        }
        .width('90%')

        Row(){
          Text('电话:')
          TextInput({text:this.emp.phone})
            .width(200)
            .onChange((value)=>{
              this.emp.phone=value

            })
        }
        .width('90%')

        Row(){
          Text('入职方式:')
          Text(this.emp.entermode)
        }
        .width('90%')

        Row(){
          Text('部门ID(名称):')
          Text(this.emp.dep_ID+'('+this.emp.dep_name+')')
        }
        .width('90%')

        Row(){
          Text('岗位ID(名称):')
          Text(this.emp.pos_ID+'('+this.emp.pos_name+')')
        }
        .width('90%')

        Row(){
          Text('入职时间:')
          Text(this.emp.date)
        }
        .width('90%')

        Row(){
          Text('出生日期:')
          TextInput({text:this.emp.date})
            .width(200)
            .onChange(value=>{
              this.emp.date=value
            })
        }
        .width('90%')

        Row(){
          Text('电子邮箱:')
          TextInput({text:this.emp.email})
            .width(200)
            .onChange(value=>{
              this.emp.email=value
            })
        }
        .width('90%')

        Row(){
          Text('家庭地址:')
          TextInput({text:this.emp.address})
            .width(200)
            .onChange(value=>{
              this.emp.address=value
            })
        }
        .width('90%')

        Row(){
          Text('工作经历:')
          Text(this.emp.work_experience)
        }
        .width('90%')

        Row(){
          Text('学历背景:')
          Text(this.emp.academic_background)
        }
        .width('90%')

        Row(){
          Text('员工身份:')
          Text(this.emp.emp_type)
        }
        .width('90%')

        Row(){
          Text('转正时间:')
          Text(this.emp.confirm_date)
        }
        .width('90%')

        Row(){
          Text('实习详情:')
          Text(this.emp.intern_detail)
        }
        .width('90%')

        Row(){
          Text('外语水平:')
          //
        }
        .width('90%')

        Row(){
          Text('父亲(联系方式):')

        }
        .width('90%')

        Row(){
          Text('母亲(联系方式):')

        }
        .width('90%')
      }


    }
    .width('100%')
    .height('100%')
  }
}