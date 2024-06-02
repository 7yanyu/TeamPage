import router from '@ohos.router'
import {DimUser} from '../../../entity/DimUser'
import {dimby_depID} from '../../../httpRequest/dimission/dimby_depID'
import {dimby_posID} from '../../../httpRequest/dimission/dimby_posID'
import {dimby_empID} from '../../../httpRequest/dimission/dimby_empID'
import { dimbyDate } from '../../../httpRequest/dimission/dimbyDate'
import {dimfind_All} from '../../../httpRequest/dimission/dimfind_All'
@Entry
@Component
struct DimIndexPage {
  @State message: string = '离职管理'
  @State emp_ID :string=''
  @State pos_ID: string = ''
  @State dep_ID: string = ''
  @State startDate: string=''
  @State endDate: string=''
  private selectedDate: Date = new Date()
  @State dimusers:DimUser[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 7; // 每页显示的项目数量

  onClickView(dimuser:DimUser){
    console.log('查看按钮是否被点击')
    const dimuserJson=JSON.stringify(dimuser)
    console.log('Encoded Department: ',dimuserJson)
    router.pushUrl({
      url:'pages/employee/dimission/dimDetailsPage',
      params:{
        dimuser:dimuserJson
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

      Row({space:65}){
        Text('员工ID').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('岗位ID').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('部门ID').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);

      }.padding({top:5})
      .width('90%')
      .padding({top:10})


      Row({space:10}){
        TextInput({ placeholder: '请输入员工id',text:this.emp_ID })
          .onChange((value: string) => {
            if (this.pos_ID != '' || this.dep_ID != '' || this.startDate != '' || this.endDate != '') {
              this.pos_ID = ''
              this.dep_ID = ''
              this.startDate = ''
              this.endDate = ''
            }
            const numericValue = parseInt(value, 10)
            this.emp_ID = isNaN(numericValue) ? '' : value
          })
          .padding({top:10,left:5})
          .width('30%')

        TextInput({ placeholder: '请输入岗位id',text:this.pos_ID })
          .onChange((value: string) => {
            if (this.emp_ID!= '' || this.dep_ID != '' || this.startDate != '' || this.endDate != '') {
              this.emp_ID = ''
              this.dep_ID = ''
              this.startDate = ''
              this.endDate = ''
            }
            const numericValue = parseInt(value, 10)
            this.pos_ID = isNaN(numericValue) ? '' : value

          })
          .padding({top:10,left:20})
          .width('35%')

        TextInput({ placeholder: '请输入部门id',text:this.dep_ID })
          .onChange((value: string) => {
            if (this.emp_ID!= '' || this.pos_ID != '' || this.startDate != '' || this.endDate != '') {
              this.emp_ID = ''
              this.pos_ID = ''
              this.startDate = ''
              this.endDate = ''
            }
            const numericValue = parseInt(value, 10)
            this.dep_ID = isNaN(numericValue) ? '' : value

          })
          .padding({top:10,left:5})
          .width('30%')
      }.padding({top:5})

      Row(){
        Text('离职时间')
          .fontWeight(FontWeight.Bold)
          .width('100')
          .textAlign(TextAlign.Start)
      }.width('95%')

      Row({space:20}){
        Button(this.startDate||'开始时间')
          .backgroundColor('#F5F5F5')
          .fontColor('#459ED4')
          .width('30%')
          .onClick(() => {
            if (this.pos_ID != '' || this.dep_ID != '' || this.emp_ID != '') {
              this.pos_ID = ''
              this.dep_ID = ''
              this.emp_ID = ''
            }
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: new Date(this.startDate),
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.startDate = `${value.year}-${value.month+1}-${value.day}`
              }
            })
          })
        Divider().width(10).height(30).color('black') // 添加一条直线

        Button(this.endDate||'截止时间')
          .width('30%')
          .backgroundColor('#F5F5F5')
          .fontColor('#459ED4')
          .onClick(() => {
            if (this.pos_ID != '' || this.dep_ID != '' || this.emp_ID != '') {
              this.pos_ID = ''
              this.dep_ID = ''
              this.emp_ID = ''
            }
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2100-12-31"),
              selected: new Date(this.endDate),
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                this.endDate = `${value.year}-${value.month+1}-${value.day}`
              }
            })
          })


        Button('查询')
          .fontColor('black')
          .backgroundColor('#99D9EA')
          .onClick(() => {
            if(this.dep_ID!=''){
              //清空已有数据
              this.dimusers=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              //根据部门ID进行查询
              dimby_depID(parseInt(this.dep_ID)).then((dimusers)=>{
                this.dimusers=dimusers
                this.hasSearched = true;
                console.log(JSON.stringify(this.dimusers, null, 2))
                console.log(this.dimusers.length.toString())


              }).catch(error => {
                console.error('Error fetching department:', error);
                this.hasSearched = true;
                this.dimusers = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询


              })
            }

            else if(this.pos_ID!=''){
              //清空已有数据
              this.dimusers=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              //根据部门ID进行查询
              dimby_posID(parseInt(this.pos_ID)).then((dimusers)=>{
                this.dimusers=dimusers
                this.hasSearched = true;
                console.log(JSON.stringify(this.dimusers, null, 2))
                console.log(this.dimusers.length.toString())



              }).catch(error => {
                console.error('Error fetching department:', error);
                this.dimusers = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询

              })

            }
            else if(this.emp_ID!=''){
              //清空已有数据
              this.dimusers=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              //根据部门ID进行查询
              dimby_empID(parseInt(this.emp_ID)).then((dimusers)=>{
                this.dimusers=dimusers
                this.hasSearched = true;
                console.log(JSON.stringify(this.dimusers, null, 2))
                console.log(this.dimusers.length.toString())


              }).catch(error => {
                console.error('Error fetching department:', error);
                this.dimusers = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询

              })

            }
            else if(this.startDate!=''||this.endDate!=''){
              //清空已有数据
              this.dimusers=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              //根据部门ID进行查询
              dimbyDate(this.startDate,this.endDate).then((dimusers)=>{
                this.dimusers=dimusers
                this.hasSearched = true;
                console.log(JSON.stringify(this.dimusers, null, 2))
                console.log(this.dimusers.length.toString())


              }).catch(error => {
                console.error('Error fetching department:', error);
                this.dimusers = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询

              })

            }
            else{
              this.dimusers=[]
              // 设置 hasSearched 为 false，表示查询过程中
              this.hasSearched = false;
              this.currentPage=1
              //根据部门ID进行查询
              dimfind_All().then((dimusers)=>{
                this.dimusers=dimusers
                this.hasSearched = true;
                console.log(JSON.stringify(this.dimusers, null, 2))
                console.log(this.dimusers.length.toString())


              }).catch(error => {
                console.error('Error fetching department:', error);
                this.dimusers = []; // 确保在错误情况下清空显示的数据
                this.hasSearched = true; // 查询完成后设置为已进行查询

              })

            }



          })
          .width('20%')
          .padding(12)
          .fontSize(15)

      }.padding({top:5})

      //查询结果表格
      Row({space:10}) {
        Text('员工ID').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Center);
        Text('员工姓名').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('入职时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('离职时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
      }
      .width('95%')
      .padding({top:5})

      Column() {
        //显示查询结果
        if(this.hasSearched){
          if (this.dimusers.length > 0) {
            ForEach(this.dimusers.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (dimuser: DimUser) => {
              Row({ space: 10 }) {

                Text(dimuser.emp_ID.toString()).width(60).textAlign(TextAlign.Center);
                Text(dimuser.emp_name).width(70).textAlign(TextAlign.Start);
                Text(dimuser.date).width(70).textAlign(TextAlign.Start);
                Text(dimuser.dim_date).width(70).textAlign(TextAlign.Start);
                Text('查看')
                  .fontColor('#8AB7FF')
                  .onClick(() => this.onClickView(dimuser));

              }
              .padding({ top: 15, bottom: 10 });
            })
          }
          else {
            // 如果没有结果，显示一条提示信息
            Text('没有查询到相关离职信息')
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
            const maxPage = Math.ceil(this.dimusers.length / this.itemsPerPage);
            if (this.currentPage < maxPage) {
              this.currentPage++;
            }
          });
      }.alignItems(VerticalAlign.Center)
      .height('5%')

      Row({space:20}) {
        Column() {
          Image($r('app.media.test7'))
            .width(30)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/employee/dimission/addDimPage'
              })
            })
          Text('新增离职')
            .fontSize(15)
            .textAlign(TextAlign.Start)

        }.alignItems(HorizontalAlign.Center)
        .padding({top:20})
        .width('60%')

        Column() {
          Image($r('app.media.test8'))
            .width(30)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/Department/changeDPMentPage'
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