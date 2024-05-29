import router from '@ohos.router'
import { Department } from '../../../entity/Department'
import { Add_dep } from '../../../httpRequest/Department/depAdd'
@Entry
@Component
struct AddPage {
  @State message: string = '增加部门'
  @State department:Department=new Department(0,'','','','')
  private selectedDate: Date = new Date()
  // private item:Array<string>=['部门ID','部门名称','部门电话','成立时间','部门成立时间','部门简介']
  build() {
    Column({space:15}) {
      Row(){
        Column(){
          Image($r('app.media.test1'))
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
        Text('部门ID')
          .fontSize(20)

        TextInput({placeholder:'请输入部门ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.department.dep_ID=id
          })
          .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:15}){
        Text('部门名称')
          .fontSize(20)

        TextInput({placeholder:'请输入部门名称'})
          .onChange((value)=>{
            this.department.dep_name=value
          })
          .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:15}){
        Text('部门电话')
          .fontSize(20)

        TextInput({placeholder:'请输入部门电话'})
          .onChange((value)=>{
            this.department.dep_phone=value
          })
          .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row({space:15}){
        Text('成立时间')
          .fontSize(20)

        Button(this.department.creat_date || '请选择日期')
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
                this.department.creat_date = `${value.year}-${value.month + 1}-${value.day}`
              }
            })
          })
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row(){
        Text('部门简介')
          .fontSize(20)
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row(){
        TextArea({placeholder:'     请输入部门简介'})
          .onChange((value)=>{
            this.department.detail=value
          })
          .placeholderColor('#C3C3C3')
          .width('90%')
          .height('150')
      }

      Button('提交')
        .onClick(() => {
          Add_dep(this.department)
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