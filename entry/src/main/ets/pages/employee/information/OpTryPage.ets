import router from '@ohos.router'
import { employee } from '../../../entity/employee'
import { tryChangeRequest } from '../../../httpRequest/employee/information/tryChangeRequest'
@Entry
@Component
struct OpTryPage {
  @State message: string = '试用期管理操作'
  @State emp:employee=new employee()
  @State selectDate:Date=new Date

  onPageShow(){
    console.log('onInit called'); // 确认 onInit 被调用
    const params=router.getParams() as {employee:string}
    console.log('Params:', params); // 打印整个 params 对象
    if(params /*&& params.item*/){
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
          .margin({left:30})
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
        Text('实习状态')
          .fontSize(20)
          .margin({right:40,left:-40})
        Select([{value:'正常实习'},
          {value:'延期'},
          {value:'未通过'},
          {value:'已转正'}])
          .value(this.emp.intern_situation)
          .backgroundColor('#F2F2F2')
          .onSelect((index)=>{
            if(index==0){
              this.emp.intern_situation='正常实习'
            }else if(index==1){
              this.emp.intern_situation='延期'
            }else if(index==2){
              this.emp.intern_situation='未通过'
            }else if(index==3){
              this.emp.intern_situation='已转正'
            }
          })
      }
      .width('95%')
      .margin({top:20})
      .justifyContent(FlexAlign.Center)

      Row(){
        Text('转正时间')
          .fontSize(20)
          .margin({right:40})
        Button(this.emp.confirm_date||'   年/月/日   ')
          .backgroundColor('#F4F6F5')
          .fontColor('black')
          .onClick(()=>{
            DatePickerDialog.show({
              start:new Date('1949-01-01'),
              end:new Date('2100-12-31'),
              selected:this.selectDate,
              onAccept:(value:DatePickerResult)=>{
                this.selectDate.setFullYear(value.year,value.month,value.day)
                this.emp.confirm_date=`${value.year}-${value.month}-${value.day}`
              }
            })
          })
      }
      .width('95%')
      .margin({top:30})
      .justifyContent(FlexAlign.Center)

      Text('实习详情')
        .fontSize(20)
        .margin({top:20,right:155})

      TextArea({ placeholder:'请输入员工实习期间的工作详情' })
        .margin(10)
        .backgroundColor('#F4F6F5')
        .width('90%')
        .onChange((value)=>{
          this.emp.intern_detail=value
        })

      Button('提交')
        .width(100)
        .margin(15)
        .onClick(()=>{
          tryChangeRequest(this.emp).then(response=>{
            if(response){
              console.log(this.emp.toString())

            }
          })
        })



      }
    .width('100%')
    .height('100%')


  }
}