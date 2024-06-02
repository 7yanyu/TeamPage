import router from '@ohos.router'
import {EmployeeMov} from '../../../entity/EmployeeMov'
import {Movtime} from  '../../../entity/Movtime'
import {Find_empmov} from  '../../../httpRequest/move/Find_empmov'
import {filterEmptyFields} from '../../../httpRequest/move/Find_empmov'
@Entry
@Component
struct MoveIndexPage {
  @State message: string = '调动管理'
  private selectedDate: Date = new Date()
  @State movtime:Movtime=new Movtime(0,'','','','')
  @State empmovs:EmployeeMov[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 8; // 每页显示的项目数量
  onClickView(empmov:EmployeeMov){
    console.log('查看按钮是否被点击')
    const empmovJson=JSON.stringify(empmov)
    console.log('Encoded Department: ',empmovJson)
    router.pushUrl({
      url:'pages/employee/move/moveDetailsPage',
      params:{
        empmov:empmovJson
      }
    })
  }

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
          Text('调动时间:')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .width('100')
            .textAlign(TextAlign.Start)
        }.width('85%')
        .padding({top:10})

        Row({space:20}) {
          Button(this.movtime.datea || '年 / 月 / 日 ')
            .backgroundColor('#F5F5F5')
            .fontColor('#459ED4')
            .width('40%')
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2100-12-31"),
                selected: this.selectedDate,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedDate.setFullYear(value.year, value.month, value.day)
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                  this.movtime.datea = `${value.year}-${value.month + 1}-${value.day}`
                  console.log(this.movtime.datea)
                }
              })
            })

          Divider().width(20).height(30).color('black') // 添加一条直线

          Button(this.movtime.dateb || ' 年 / 月 / 日')
            .width('40%')
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
                  this.movtime.dateb = `${value.year}-${value.month + 1}-${value.day}`
                  console.log(this.movtime.dateb)
                }
              })
            })
        }.width("100%")
          .padding({top:5})

        Row({space:65}){
          Text('员工ID').fontSize('18').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
          Text('调动类型').fontSize('18').fontWeight(FontWeight.Bold).width(80).textAlign(TextAlign.Start);
        }
        .width('90%')
        .padding({top:10,left:5})


        Row({space:30}){
          TextInput({ placeholder: '请输入员工id'})
            .onChange((value: string) => {
              const numericValue = parseInt(value, 10)
              this.movtime.emp_ID = numericValue
            })
            .padding({top:10,left:5})
            .width('30%')
          Column(){
            Select([
              {value:'无'},
              { value: '岗位间调动'},
              { value: '部门间调动' }
            ])
              .selected(0)
              .font({ size: 18, weight: FontWeight.Medium })
              .fontColor('#7BB6EB')
              .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
              .optionFont({ size: 18, weight: FontWeight.Regular })
              .onSelect((index: number) => {
                if(index==0){
                  this.movtime.movtype=''

                }
                else if(index==1){
                  this.movtime.movtype='岗位间调动'

                }
                else{
                  this.movtime.movtype='部门间调动'
                }


              })


          }.width('30%')


          Button('查询')
            .fontColor('black')
            .backgroundColor('#99D9EA')
            .width('20%')
            .padding(12)
            .fontSize(13)
            .onClick(()=>{
              //清空已有数据
              this.empmovs=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              // 过滤掉空值字段
              const filteredEmp = filterEmptyFields(this.movtime);
              //根据部门ID进行查询
             Find_empmov(filteredEmp).then((empmovs)=>{
                this.empmovs=empmovs
                this.hasSearched = true;
                console.log(JSON.stringify(this.empmovs, null, 2))
                console.log(this.empmovs.length.toString())
               this.movtime.datea=''
               this.movtime.dateb=''


              }).catch(error => {
                console.error('Error fetching department:', error);
                this.hasSearched = true;
                this.empmovs = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询
               this.movtime.datea=''
               this.movtime.dateb=''

              })

            })
        }.width('95%')
          .padding({top:5,left:5})

        //查询结果表格
        Row({space:10}) {
          Text('ID').fontWeight(FontWeight.Bold).width(20).textAlign(TextAlign.Start);
          Text('员工ID').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Start);
          Text('员工姓名').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
          Text('调动时间').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
          Text('调动类型').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
        }
        .width('95%')
        .padding({top:8})

        Column() {
          //显示查询结果
          if(this.hasSearched){
            if (this.empmovs.length > 0) {
              ForEach(this.empmovs.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (empmov:EmployeeMov) => {
                Row({ space: 20 }) {
                  Text(empmov.mov_ID.toString()).width(30).textAlign(TextAlign.Center);
                  Text(empmov.emp_ID.toString()).width(30).textAlign(TextAlign.Start);
                  Text(empmov.emp_name).width(50).textAlign(TextAlign.Start);
                  Text(empmov.mov_date).width(50).textAlign(TextAlign.Start);
                  Text(empmov.movtype).width(50).textAlign(TextAlign.Start);
                  Text('查看')
                    .fontColor('#8AB7FF')

                }
                .padding({ top: 15, bottom: 10 })
                .onClick(() => this.onClickView(empmov));
              })
            }
            else {
              // 如果没有结果，显示一条提示信息
              Text('没有查询到相关调动信息')
                .fontColor('red')
                .padding({ top: 15, bottom: 10 });
            }
          }
        }.height('55%')
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
              const maxPage = Math.ceil(this.empmovs.length / this.itemsPerPage);
              if (this.currentPage < maxPage) {
                this.currentPage++;
              }
            });
        }.alignItems(VerticalAlign.Center)
        .height('5%')
        Row({space:20}) {
          Column() {
            Image($r('app.media.test12'))
              .width(30)
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/employee/move/addMovePage'
                })
              })
            Text('岗位报表生成')
              .fontSize(13)
              .textAlign(TextAlign.End)

          }.alignItems(HorizontalAlign.Center)
          .padding({top:20})
          .width('30%')
          Column() {
            Image($r('app.media.test11'))
              .width(30)
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/employee/move/addMovePage'
                })
              })
            Text('新增调动')
              .fontSize(15)
              .textAlign(TextAlign.Start)

          }.alignItems(HorizontalAlign.Center)
          .padding({top:20})
          .width('30%')

          Column() {
            Image($r('app.media.test8'))
              .width(30)
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/employee/move/addMovePage'
                })
              })
            Text('部门报表生成')
              .fontSize(15)
              .textAlign(TextAlign.End)

          }.alignItems(HorizontalAlign.Center)
          .padding({top:20})
          .width('30%')


        }.width('100%')




















      }
      .width('100%')
      .height('100%')
      .backgroundImageSize({width:'100%',height:'100%'})

  }
}