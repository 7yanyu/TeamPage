import router from '@ohos.router'
import { employee } from '../../../entity/employee'
import { detailRequest } from '../../../httpRequest/employee/information/detailRequest'
@Entry
@Component
struct OpCareerPage {
  @State message: string = '职业生涯操作'
  @State emp:employee=new employee()
  // @State selectDate:Date=new Date

  onPageShow(){
    console.log('onInit called'); // 确认 onInit 被调用
    const params=router.getParams() as {employee:string}
    console.log('Params:', params); // 打印整个 params 对象
    if(params && params.employee){
      const employeeJson=params.employee
      console.log('employeeJson:',employeeJson)
      try {
        const employeeData=JSON.parse(employeeJson)
        this.emp=employeeData
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
          .margin({left:45})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row(){
        Image($r('app.media.app_icon'))
          .width(100)
          .margin(10)
        Column(){
          Text(this.emp.emp_name)
            .fontSize(30)
            .margin({bottom:15})
          Text(this.emp.phone)
            .fontSize(30)
            .margin({top:15})
        }
      }
      .width('100%')
      .margin(10)

      Row(){
        Text('学历背景')
          .fontSize(20)
          .margin({right:40})
        TextInput({text:this.emp.academic_background})
          .onChange(value=>{
            this.emp.academic_background=value
          })
      }
      .width('95%')
      .margin({top:20})
      .justifyContent(FlexAlign.Center)

      Text('工作经历')
        .fontSize(20)
        .margin({right:260,top:20,bottom:10})

      TextArea({ text:this.emp.work_experience })
        .margin(10)
        .backgroundColor('#F4F6F5')
        .width('90%')
        .onChange((value)=>{
          this.emp.work_experience=value
        })

      Button('修改')
        .width(100)
        .margin(15)
        .onClick(()=>{
          detailRequest(this.emp).then(response=>{
            if(response){
              console.log(this.emp.toString())
              AlertDialog.show({
                title:'提示',
                message:'操作成功，是否返回？',
                primaryButton:{
                  value:'No',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'Yes',
                  action:()=>{
                    router.back()
                  }
                }
              })
            }
          })
        })
    }
    .width('100%')
    .height('100%')


  }
}