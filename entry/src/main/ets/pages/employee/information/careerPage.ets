import router from '@ohos.router';
import { employee } from '../../../entity/employee';
import { queryRequest_1 } from '../../../httpRequest/employee/information/queryRequest_1';
@Entry
@Component
struct CareerPage {
  @State message: string = '职业生涯'

  // @State employee:Findemp=new Findemp(null,null,'','','','','','','')
  @State empId:string=''
  @State emp:employee=new employee()
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询




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


      //输入栏+查询按钮
      Row(){
        Image($r('app.media.search'))
          .width(25)

        TextInput({ placeholder:'请输入员工ID' })
          .width(150)
          .onChange((value)=>{
            this.empId=value
          })

        Blank()

        Button('查询')
          .width(100)
          .stateEffect(true)
          .type(ButtonType.Normal)
          .borderRadius(15)           //四角的弧度
          .onClick(()=>{
            this.hasSearched=true
            const id=parseInt(this.empId)
            queryRequest_1(id)
              .then(response=>{
                this.emp=response
              })
          })

      }
      .width('90%')
      .margin(10)

      Row({space:10}){
        //id,name,datea,situation
        //                            操作
        Text('员工ID').fontWeight(FontWeight.Bold).width(50).margin({left:10})
        Text('员工姓名').fontWeight(FontWeight.Bold).width(70)
        Text('工作经历').fontWeight(FontWeight.Bold).width(70)
        Text('学历背景').fontWeight(FontWeight.Bold).width(70)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin(10)
      .backgroundColor('#F2F2F2')

      Row({space:10}){
        if(this.hasSearched){
          Text(this.empId).width(50).textAlign(TextAlign.Center)
          Text(this.emp.emp_name).width(70).textAlign(TextAlign.Center)
          Text(this.emp.work_experience).width(70).fontSize(15).textAlign(TextAlign.Center)
          Text(this.emp.academic_background).width(70).textAlign(TextAlign.Center)
          Text('操作').fontColor('#36D').width(70).textAlign(TextAlign.Center)
            .onClick(()=>{
              console.log('操作按钮被点击')
              console.log(JSON.stringify(this.emp))
              router.pushUrl({
                url:'pages/employee/information/OpCareerPage',
                params: {
                  employee: JSON.stringify(this.emp)
                }
              })
            })
        }
      }
      .width('100%')

    }
    .width('100%')
    .height('100%')
  }
}
