import router from '@ohos.router'
import { employee } from '../../../entity/employee'
import { Findemp } from '../../../entity/Findemp'
import { tryRequest } from '../../../httpRequest/employee/information/tryQueryRequest'
@Entry
@Component
struct TryPage {
  @State message: string = '试用期管理'

  @State employee:Findemp=new Findemp(null,null,'','','','','','','')
  @State employees:employee[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage:number=1
  @State itemsPerPage:number=9
  private selectedDate:Date=new Date()



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


      Row(){
        Image($r('app.media.search'))
          .width(25)

        Text('工作时间:')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin({left:5})
      }
      .width('90%')
      .margin({top:10})

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
      .margin(5)

      Row(){
        Image($r('app.media.search'))
          .width(25)

        Text('员工实习状态:')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin({left:5})
      }
      .width('90%')
      .margin({top:10})

      //下拉选择栏+查询按钮
      Row(){
        Select([{value:'正常实习'},
          {value:'延期'},
          {value:'未通过'},
          {value:'已转正'}])
          .value('                    ')
          .backgroundColor('#F2F2F2')
          .onSelect((index)=>{
            if(index==0){
              this.employee.intern_situaiton='正常实习'
            }else if(index==1){
              this.employee.intern_situaiton='延期'
            }else if(index==2){
              this.employee.intern_situaiton='未通过'
            }else if(index==3){
              this.employee.intern_situaiton='已转正'
            }
          })

        Blank()
        Button('查询')
          .width(100)
          .stateEffect(true)
          .type(ButtonType.Normal)
          .borderRadius(15)           //四角的弧度
          .onClick(()=>{
            tryRequest(this.employee)
              .then((employees)=>{
                this.employees=employees
                this.hasSearched=true
              })
              .catch(error=>{
                this.employees=[]
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
        Text('入职时间').fontWeight(FontWeight.Bold).width(70)
        Text('实习状态').fontWeight(FontWeight.Bold).width(70)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin(10)
      .backgroundColor('#F2F2F2')

      Column({space:10}){
        if(this.hasSearched){
          ForEach(this.employees.slice((this.currentPage-1)*this.itemsPerPage,this.currentPage*this.itemsPerPage),
            (item:employee)=>{
              Row({space:10}){
                Text(item.emp_ID.toString()).width(50).textAlign(TextAlign.Center)
                Text(item.emp_name).width(70).textAlign(TextAlign.Center)
                Text(item.date).width(70).fontSize(15)
                Text(item.intern_situation).width(70).textAlign(TextAlign.Center)
                Text('操作').fontColor('#36D').width(70).textAlign(TextAlign.Center)
                  .onClick(()=>{
                    console.log('操作按钮被点击')
                    console.log(JSON.stringify(item))
                    router.pushUrl({
                      url:'pages/employee/information/OpTryPage',
                      params: {
                        employee: JSON.stringify(item)
                      }
                    })
                  })
              }
            })
        }
      }
      .height('55%')

      //分页器
      Row() {
        Button('上一页')
          .width(100)
          .height(30)
          .fontColor('black')
          .backgroundColor('')
          .borderRadius(5)
          .onClick(() => {
            if (this.currentPage > 1) {
              this.currentPage--;
            }
          });
        Text(`第 ${this.currentPage} 页`);

        Button('下一页')
          .width(100)
          .height(30)
          .fontColor('black')
          .backgroundColor('')
          .borderRadius(5)
          .onClick(() => {
            const maxPage = Math.ceil(this.employees.length / this.itemsPerPage);
            if (this.currentPage < maxPage) {
              this.currentPage++;
            }
          })
      }.alignItems(VerticalAlign.Center)
      .height('5%')


    }
    .width('100%')
    .height('100%')
  }
}

