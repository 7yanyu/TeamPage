import router from '@ohos.router'
import { Position } from '../../../entity/Position'
import { Add_pos } from '../../../httpRequest/Position/posAdd'
@Entry
@Component
struct AddPosPage {
  @State message: string = '增加岗位'
  @State pos:Position=new Position(0,'','','','','')
  private selectedDate: Date = new Date()

  build() {
    Column({space:15}) {
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
            this.pos.pos_ID=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:15}){
        Text('岗位名称')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位名称'})
          .onChange((value)=>{
            this.pos.pos_name=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:20}){
        Text('成立时间')
          .fontSize(20)

        Button(this.pos.creat_date || '请选择日期')
          .backgroundColor('#F5F5F5')
          .fontColor('#C3C3C3')
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDate,
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.pos.creat_date = `${value.year}-${value.month + 1}-${value.day}`
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
            this.pos.dep_ID=value
          })   .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:10}){
        Text('所属部门名称')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位所属部门名称'})
          .onChange((value)=>{
            this.pos.dep_name=value
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
            this.pos.detail=value
          })
          .placeholderColor('#C3C3C3')
          .width('90%')
          .height('150')
      }



      Button('提交')
        .onClick(() => {
          //调用接口，新增岗位
          Add_pos(this.pos)
            .then((response)=>{
              if(response.toString()=='添加成功'){
                AlertDialog.show({
                  title:'提示',
                  message:'添加成功,是否继续添加',
                  primaryButton:{
                    value:'返回',
                    action:()=>{
                      router.back()
                    }
                  },
                  secondaryButton:{
                    value:'继续',
                    action:()=>{}
                  }
                })
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