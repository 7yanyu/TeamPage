import router from '@ohos.router'
import { employee } from '../../../entity/employee'
import { Findemp } from '../../../entity/Findemp'
@Entry
@Component
struct MonthlyReportPage {
  @State message: string = '人事月报'
  @State employee:Findemp=new Findemp(null,null,'','','','','','','')
  private  selectedDate:Date=new Date()

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
          .margin({left:70})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      //工作时间段
      Row(){
        Button(this.employee.datea || '年/月/日        ↓')
          .width(150)
          .stateEffect(true)
          .fontColor('black')
          .backgroundColor('#F4F6F5')
          .onClick(()=>{
            DatePickerDialog.show({
              start:new Date('1949-01-01'),
              end:new Date('2100-12-31'),
              selected:this.selectedDate,
              onAccept:(value:DatePickerResult)=>{
                this.selectedDate.setFullYear(value.year,value.month,value.day)
                console.log('onAcceptDate:'+JSON.stringify(value))
                this.employee.datea=`${value.year}-${value.month+1}-${value.day}`
                console.log('datea:'+this.employee.datea)
              }

            })
          })
        Text('——')
          .margin(5)
        Button(this.employee.dateb||'年/月/日        ↓')
          .width(150)
          .stateEffect(true)
          .fontColor('black')
          .backgroundColor('#F4F6F5')
          .onClick(()=>{
            DatePickerDialog.show({
              start:new Date('1949-01-01'),
              end:new Date('2100-12-31'),
              selected:this.selectedDate,
              onAccept:(value:DatePickerResult)=>{
                this.selectedDate.setFullYear(value.year,value.month,value.day)
                console.log('onAcceptDate:'+JSON.stringify(value))
                this.employee.dateb=`${value.year}-${value.month+1}-${value.day}`
                console.log('dateb:'+this.employee.dateb)
              }

            })
          })
      }
      .margin({top:30,bottom:20})

      Button('查询报表')
        .width(100)
        .onClick(()=>{
          //接口
        })
        .margin({top:30})
    }
    .width('100%')
    .height('100%')
  }
}