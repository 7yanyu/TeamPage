import router from '@ohos.router'
import {employee} from '../../../entity/employee'
import {Findemp} from '../../../entity/Findemp'
import {Find_join} from '../../../httpRequest/joined/Find_join'
import {ReportByDate} from '../../../httpRequest/joined/ReportByDate'
@Entry
@Component
struct JoinIndexPage {
  @State message: string = '入职管理'
  private selectedDate: Date = new Date()
  @State findemp :Findemp=new Findemp(0,0,'','','','','','','')
  @State emps:employee[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 8; // 每页显示的项目数量

  build() {

      Column() {
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
            .fontSize(30)
            .textAlign(TextAlign.Center)

        }.padding({top:15})
        .width('90%')

        Row(){
          Text('入职时间:')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100')
            .textAlign(TextAlign.Start)
        }.width('85%')
         .padding({top:10})

        Row({space:20}){
          Button(this.findemp.datea||'年 / 月 / 日 ')
            .backgroundColor('#F5F5F5')
            .fontColor('#459ED4')
            .width('30%')
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2100-12-31"),
                selected: this.selectedDate,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedDate.setFullYear(value.year, value.month, value.day)
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                  this.findemp.datea = `${value.year}-${value.month+1}-${value.day}`
                  console.log(this.findemp.datea)
                }
              })
            })

          Divider().width(10).height(30).color('black') // 添加一条直线

          Button(this.findemp.dateb||' 年 / 月 / 日')
            .width('30%')
            .backgroundColor('#F5F5F5')
            .fontColor('#459ED4')
            .onClick(() => {

              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2100-12-31"),
                selected: this.selectedDate,
                onAccept: (value: DatePickerResult) => {
                  console.log(this.findemp.pos_ID.toString())
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedDate.setFullYear(value.year, value.month, value.day)
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                  this.findemp.dateb = `${value.year}-${value.month+1}-${value.day}`
                  console.log(this.findemp.dateb)
                }
              })
            })
          Button('查询')
            .fontColor('black')
            .backgroundColor('#99D9EA')
            .width('20%')
            .padding(12)
            .fontSize(13)
            .onClick(()=>{
              //清空已有数据
              this.emps=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              Find_join(this.findemp).then((emps)=>{
                this.emps=emps
                this.hasSearched = true;
                console.log(JSON.stringify(this.emps, null, 2))
                console.log(this.emps.length.toString())


              }).catch(error => {
                console.error('Error fetching department1:', error);
                this.hasSearched = true;
                this.emps= []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询
              })
            })



          }.padding({top:10})
         .width('95%')

        //查询结果表格
        Row({space:8}) {
          Text('ID').fontWeight(FontWeight.Bold).width(30).textAlign(TextAlign.Center);
          Text('姓名').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Center);
          Text('入职时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
          Text('入职方式').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
          Text('实习状态').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        }
        .width('95%')
        .padding({top:8})

        Column() {
          //显示查询结果
          if(this.hasSearched){
            if (this.emps.length > 0) {
              ForEach(this.emps.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (emp: employee) => {
                Row({ space: 10 }) {

                  Text(emp.emp_ID.toString()).width(30).textAlign(TextAlign.Center);
                  Text(emp.emp_name).width(50).textAlign(TextAlign.Start);
                  Text(emp.date).width(70).textAlign(TextAlign.Start);
                  Text(emp.entermode).width(70).textAlign(TextAlign.Start);
                  Text(emp.intern_situation).width(70).textAlign(TextAlign.Start);

                }
                .padding({ top: 15, bottom: 10 });
              })
            }
            else {
              // 如果没有结果，显示一条提示信息
              Text('没有查询到相关入职信息')
                .fontColor('red')
                .padding({ top: 15, bottom: 10 });
            }
          }
        }.height('65%')
        .width('100%')
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
              const maxPage = Math.ceil(this.emps.length / this.itemsPerPage);
              if (this.currentPage < maxPage) {
                this.currentPage++;
              }
            });
        }.alignItems(VerticalAlign.Center)
        .height('5%')

        Row({space:20}) {
          Column() {
            Image($r('app.media.test10'))
              .width(30)
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/employee/joined/addJoinPage'
                })
              })
            Text('新增入职')
              .fontSize(15)
              .textAlign(TextAlign.Start)

          }.alignItems(HorizontalAlign.Center)
          .padding({top:20})
          .width('60%')

          Column() {
            Image($r('app.media.test8'))
              .width(30)
              .onClick(()=>{
                ReportByDate(this.findemp.datea,this.findemp.dateb).then(()=>{
                  console.log('Excel 报表下载成功');

                }).catch(error => {
                  console.error('下载报表时发生错误:', error);

                })

              })
            Text('报表生成')
              .fontSize(15)
              .textAlign(TextAlign.End)

          }.alignItems(HorizontalAlign.Center)
          .padding({top:20})


        }.width('100%')








      }
      .width('100%')
      .height('100%')
      .backgroundImageSize({width:'100%',height:'100%'})

  }
}