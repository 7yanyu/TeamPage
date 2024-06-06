import router from '@ohos.router'
import { Position } from '../../../entity/Position'
import { Change_pos } from '../../../httpRequest/Position/posChange'
@Entry
@Component
struct ChangePosPage {
  @State message: string = '修改岗位'
  @State posChange:Position=new Position(0,'','','','','')
  private selectedDateChange: Date = new Date()

  build() {
    Column({space:10}) {
      Row(){
        Column(){
          Image($r("app.media.back"))
            // .fitOriginalSize(true)
            .width(30)
            .onClick(()=>{
              router.back()
            })
        }.width('30%')
        .alignItems(HorizontalAlign.Start)


        Text(this.message)
          .fontSize(28)
          .textAlign(TextAlign.Center)


      }.padding({top:15})
      .width('90%')

      Row({space:30}){
        Text('岗位ID')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.posChange.pos_ID=id
          }).placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)



      Row({space:15}){
        Text('岗位名称')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位名称'})
          .onChange((value)=>{
            this.posChange.pos_name=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:20}){
        Text('成立时间')
          .fontSize(20)

        Button(this.posChange.creat_date || '请选择日期')
          .backgroundColor('#F5F5F5')
          .fontColor('#C3C3C3')
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDateChange,
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDateChange.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.posChange.creat_date = `${value.year}-${value.month + 1}-${value.day}`
              }
            })
          })

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:26}){
        Text('所属部门ID')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位所属部门ID'})
          .onChange((value)=>{
            this.posChange.dep_ID=value
          })   .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:10}){
        Text('所属部门名称')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位所属部门名称'})
          .onChange((value)=>{
            this.posChange.dep_name=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row(){
        Text('岗位介绍')
          .fontSize(20)

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row(){
        TextArea({placeholder:'请输入该岗位的相关介绍'})
          .onChange((value)=>{
            this.posChange.detail=value
          })
          .placeholderColor('#C3C3C3')
          .width('90%')
          .height('150')
      }

      Button('提交')
        .onClick(() => {
          //调用接口，修改岗位
          Change_pos(this.posChange)
            .then((response)=>{
              if(response){
                AlertDialog.show({
                  title:'提示',
                  message:'修改成功',
                  primaryButton:{
                    value:'确认',
                    action:()=>{
                      router.back()
                    }
                  }
                })
                console.log('修改成功')
              }else{
                console.log('修改失败')
              }
            })
        })
        .fontColor('black')
        .backgroundColor('#99D9EA')
        .width(100)
        .margin(20)
    }
    .width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}