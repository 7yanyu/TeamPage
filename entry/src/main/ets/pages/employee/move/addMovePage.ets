import router from '@ohos.router'
import {EmployeeMov} from '../../../entity/EmployeeMov'
import  {Process} from  '../../../entity/Process'
import {ADD_Move} from '../../../httpRequest/move/Add_Move'
import {ADD_Process} from '../../../httpRequest/move/Add_Move'
@Entry
@Component
struct AddMovePage{
  @State message: string = '新增调动'
  private selectedDate: Date = new Date()
  @State empmov:EmployeeMov=new EmployeeMov(0,0,'',0,'',0,'',0,'',0,'','','','')
  @State queryType: string = '岗位间调动'
  @State process :Process =new Process(0,'')

  build(){
    Column({space:15}){
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
        Text('离职ID')
          .fontSize(20)
        TextInput({placeholder:'请输入离职ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.mov_ID=id
            this.process.id=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:30}){
        Text('员工ID')
          .fontSize(20)
        TextInput({placeholder:'请输入员工ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.emp_ID=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:15}){
        Text('员工姓名')
          .fontSize(20)
        TextInput({placeholder:'请输入员工姓名'})
          .onChange((value)=>{
            this.empmov.emp_name=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:50}){
        Text('调动类型')
          .fontSize(20)
          .textAlign(TextAlign.Start)

        Select([
          { value: '岗位间调动'},
          { value: '部门间调动' }
        ])
          .selected(0)  // 默认选择为“岗位间调动”
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor('#7BB6EB')
          .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
          .optionFont({ size: 18, weight: FontWeight.Regular })
          .onSelect((index: number) => {

            this.queryType = index ===0 ? '岗位间调动' : '部门间调动';
            this.empmov.movtype=this.queryType

            console.info('Selected query type:' + this.queryType);
          })


      }
      .width('95%')


      Row({space:30}){
        Text('原部门ID')
          .fontSize(20)
        TextInput({placeholder:'请输入原部门ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.before_dep=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:15}){
        Text('转入部门ID')
          .fontSize(20)
        TextInput({placeholder:'请输入转入部门ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.after_dep=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:30}){
        Text('原岗位ID')
          .fontSize(20)
        TextInput({placeholder:'请输入原岗位ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.before_pos=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:15}){
        Text('转入岗位ID')
          .fontSize(20)
        TextInput({placeholder:'请输入转入岗位ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.empmov.after_pos=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row({space:35}){
        Text('调动时间')
          .fontSize(20)

        Button(this.empmov.mov_date|| ' 年 / 月 / 日 ')
          .backgroundColor('#F5F5F5')
          .fontColor('#459ED4')
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDate,
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.empmov.mov_date = `${value.year}-${value.month + 1}-${value.day}`
                this.process.date = `${value.year}-${value.month + 1}-${value.day}`
              }
            })
          })

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row(){
        Text('调动原因')
          .fontSize(20)

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row(){
        TextArea({placeholder:'请输入该员工调动的相关原因'})
          .onChange((value)=>{
            this.empmov.reason=value
          })
          .placeholderColor('#C3C3C3')
          .width('90%')
          .height('125')
      }

      Button('提交')
        .onClick(() => {
          //调用接口，调动
          ADD_Move(this.empmov)
            .then((response)=>{
              if(response.toString()=='添加成功'){
                ADD_Process(this.process)
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





















    }.width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }

}