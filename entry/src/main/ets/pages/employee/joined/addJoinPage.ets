import router from '@ohos.router'
import {employee} from '../../../entity/employee'
import  { ADD_join} from '../../../httpRequest/joined/Add_Join'
import  {filterEmptyFields} from '../../../httpRequest/joined/Add_Join'
@Entry
@Component
struct  AddJoinPage{
  @State message: string = '入职管理'
  private selectedDate: Date = new Date()
  private selectedDate1: Date = new Date()
  @State emp :employee=new employee()
  @State queryType: string = '男';
  @State queryType1: string = '普通入职';


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
        Text('员工ID')
          .fontSize(20)
        TextInput({placeholder:'请输入员工ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.emp.emp_ID=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:15}){
        Text('员工姓名')
          .fontSize(20)
        TextInput({placeholder:'请输入员工姓名'})
          .onChange((value)=>{
            this.emp.emp_name=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:50}){
        Text('员工性别')
          .fontSize(20)
          .textAlign(TextAlign.Start)

        Select([
          { value: '男'},
          { value: '女' }
        ])
          .selected(0)  // 默认选择为“男”
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor('#7BB6EB')
          .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
          .optionFont({ size: 18, weight: FontWeight.Regular })
          .onSelect((index: number) => {

            this.queryType = index ===0 ? '男' : '女';
            this.emp.gender=this.queryType

            console.info('Selected query type:' + this.queryType);
          })


      }
      .width('95%')

      Row({space:30}){
        Text('部门ID')
          .fontSize(20)
        TextInput({placeholder:'请输入部门ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.emp.dep_ID=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:30}){
        Text('岗位ID')
          .fontSize(20)
        TextInput({placeholder:'请输入岗位ID'})
          .onChange((value)=>{
            const id=parseInt(value)
            this.emp.pos_ID=id
          }) .placeholderColor('#C3C3C3')

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Row({space:20}){
        Text('入职日期')
          .fontSize(20)

        Button(this.emp.date|| ' 年 / 月 / 日 ')
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
                this.emp.date = `${value.year}-${value.month + 1}-${value.day}`
              }
            })
          })

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)


      Row({space:50}){

        Text('入职方式')
          .fontSize(20)
          .textAlign(TextAlign.Start)

        Select([
          { value: '普通入职'},
          { value: '人才库入职' }
        ])
          .selected(0)
          .font({ size: 18, weight: FontWeight.Medium })
          .fontColor('#7BB6EB')
          .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
          .optionFont({ size: 18, weight: FontWeight.Regular })
          .onSelect((index: number) => {

            this.queryType1 = index ===0 ? '普通入职' : '人才库入职';
            this.emp.entermode=this.queryType1

            console.info('Selected query type:' + this.queryType1);
          })
      }   .width('95%')

      Row({space:20}){
        Text('出生日期')
          .fontSize(20)

        Button(this.emp.birthday|| ' 年 / 月 / 日 ')
          .backgroundColor('#F5F5F5')
          .fontColor('#459ED4')
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDate1,
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate1.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.emp.birthday = `${value.year}-${value.month + 1}-${value.day}`
              }
            })
          })

      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row({space:15}){
        Text('联系方式')
          .fontSize(20)
        TextInput({placeholder:'请输入员工电话'})
          .onChange((value)=>{
            this.emp.phone=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row({space:15}){
        Text('电子邮箱')
          .fontSize(20)
        TextInput({placeholder:'请输入员工电子邮箱'})
          .onChange((value)=>{
            this.emp.email=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)
      Row({space:15}){
        Text('家庭住址')
          .fontSize(20)
        TextInput({placeholder:'请输入员工家庭住址'})
          .onChange((value)=>{
            this.emp.address=value
          }) .placeholderColor('#C3C3C3')
      }
      .width('95%')
      .justifyContent(FlexAlign.Start)

      Button('提交')
        .onClick(() => {
          console.log(JSON.stringify(this.emp))
          // 过滤掉空值字段
          const filteredEmp = filterEmptyFields(this.emp);
          //调用接口，离职
          ADD_join(filteredEmp)
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























    }.width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }


}