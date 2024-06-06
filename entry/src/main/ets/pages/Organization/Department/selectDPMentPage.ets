import {Department} from '../../../entity/Department'
import {depby_ID} from '../../../httpRequest/Department/depby_ID'
import router from '@ohos.router'
import { Add_dep } from '../../../httpRequest/Department/depAdd';
import { Change_dep } from '../../../httpRequest/Department/depChange';
@Entry
@Component
struct SelectPage {
  @State dep_id: number = 0;
  @State departments: Department[] = [];
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 9; // 每页显示的项目数量
  @State message: string = '部门管理'
  @State message1: string = '增加部门'
  @State message2: string = '修改部门'

  @State department:Department=new Department(0,'','','','')
  private selectedDate: Date = new Date()

  @State departmentChange:Department=new Department(0,'','','','')
  private selectedDateChange: Date = new Date()

  onClickView(department: Department) {
    console.log('查看按钮被点击');
    const departmentJson = JSON.stringify(department);
    console.log('Encoded Department:', departmentJson);
    router.pushUrl({
      url: 'pages/Organization/Department/depdetailsPage',
      params: {
        department: departmentJson
      }
    });
  }

  build() {
    Row(){
      Column({space:15}){
        Tabs({barPosition:BarPosition.End}){
          TabContent(){
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

              Row({space:10}) {
                TextInput({ placeholder: '请输入查询部门id' })
                  .onChange((value: string) => {
                    const numericValue = parseInt(value, 10);
                    //判断是否输入具体的部门ID
                    this.dep_id = isNaN(numericValue) ? 0 : numericValue;
                  })
                  .width('70%')
                  .padding({ left: 25, right: 10 })
                  .fontSize(18)
                  .margin({ right: 15 });

                Button('查询')
                  .fontColor('black')
                  .backgroundColor('#99D9EA')
                  .onClick(() => {
                    // 清空已有数据
                    this.departments = [];
                    // 设置 hasSearched 为 false，表示查询过程中
                    this.hasSearched = false;
                    this.currentPage=1
                    // 根据 dep_id 查询数据
                    depby_ID(this.dep_id).then((departments)=>{
                      this.departments=departments
                      this.hasSearched = true;
                      console.log(JSON.stringify(this.departments, null, 2));
                    }).catch(error => {
                      console.error('Error fetching department:', error);
                      this.departments = []; // 确保在错误情况下清空显示的数据
                      this.hasSearched = true; // 查询完成后设置为已进行查询
                    })
                  })
                  .width('20%')
                  .padding(12)
                  .fontSize(15)
              }
              .width('100%')
              .padding({ top:5, bottom: 20 })
              //查询结果表格
              Row({space:10}) {
                Text('部门ID').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Center);
                Text('部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
                Text('部门电话').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
                Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
              }
              .width('95%')
              .padding({  bottom: 10 });

              Column(){
                // 显示查询结果
                if(this.hasSearched){

                  if(this.departments.length>0) {

                    ForEach(this.departments.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (department: Department) => {
                      Row({ space: 10 }) {

                        Text(department.dep_ID.toString()).width(60).textAlign(TextAlign.Center);
                        Text(department.dep_name).width(70).textAlign(TextAlign.Start);
                        Text(department.dep_phone).width(70).textAlign(TextAlign.Start);
                        Text(department.creat_date).width(70).textAlign(TextAlign.Start);
                        Text('查看')
                          .fontColor('#8AB7FF')
                          .onClick(() => this.onClickView(department))
                      }
                      .padding({ top: 15, bottom: 10 });
                    })


                  }
                  else {
                    // 如果没有结果，显示一条提示信息
                    Text('没有查询到相关部门信息')
                      .fontColor('red')
                      .padding({ top: 15, bottom: 10 });
                  }

                }
              }
              .height('75%')
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
                    const maxPage = Math.ceil(this.departments.length / this.itemsPerPage);
                    if (this.currentPage < maxPage) {
                      this.currentPage++;
                    }
                  });
              }.alignItems(VerticalAlign.Center)
              .height('5%')

            }
            .width('100%')
            .height('100%')
            .backgroundImageSize({width:'100%',height:'100%'})
          }.tabBar('查找部门')

          //新增
          TabContent(){
            Column({space:15}){
              Row(){
                Image($r("app.media.back"))
                  // .fitOriginalSize(true)
                  .width(30)
                  .onClick(()=>{
                    router.back()
                  })
                  .margin({right:75})

                Text(this.message1)
                  .fontSize(30)
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
          }.tabBar('新增部门')

          //修改
          TabContent(){
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
                Text('部门ID')
                  .fontSize(20)

                TextInput({placeholder:'请输入部门ID'})
                  .onChange((value)=>{
                    const id=parseInt(value)
                    this.departmentChange.dep_ID=id
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
                    this.departmentChange.dep_name=value
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
                    this.departmentChange.dep_phone=value
                  })
                  .placeholderColor('#C3C3C3')
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
              Row({ space: 15 }) {
                Text('成立时间')
                  .fontSize(20)

                Button(this.departmentChange.creat_date || '请选择日期')
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
                        this.departmentChange.creat_date = `${value.year}-${value.month + 1}-${value.day}`
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
                    this.departmentChange.detail=value
                  })
                  .placeholderColor('#C3C3C3')
                  .width('90%')
                  .height('150')
              }

              Button('提交')
                .onClick(() => {
                  Change_dep(this.departmentChange)
                    .then((response)=>{
                      if(response==true){
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
          }.tabBar('修改部门信息')
        }
      }
    }
    .width('100%')
    .height('100%')
  }

}



/*Column() {
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

  Row({space:10}) {
    TextInput({ placeholder: '请输入查询部门id' })
      .onChange((value: string) => {
        const numericValue = parseInt(value, 10);
        //判断是否输入具体的部门ID
        this.dep_id = isNaN(numericValue) ? 0 : numericValue;
      })
      .width('70%')
      .padding({ left: 25, right: 10 })
      .fontSize(18)
      .margin({ right: 15 });

    Button('查询')
      .fontColor('black')
      .backgroundColor('#99D9EA')
      .onClick(() => {
        // 清空已有数据
        this.departments = [];
        // 设置 hasSearched 为 false，表示查询过程中
        this.hasSearched = false;
        this.currentPage=1
        // 根据 dep_id 查询数据
        depby_ID(this.dep_id).then((departments)=>{
          this.departments=departments
          this.hasSearched = true;
          console.log(JSON.stringify(this.departments, null, 2));
        }).catch(error => {
          console.error('Error fetching department:', error);
          this.departments = []; // 确保在错误情况下清空显示的数据
          this.hasSearched = true; // 查询完成后设置为已进行查询
        })
      })
      .width('20%')
      .padding(12)
      .fontSize(15)
  }
  .width('100%')
  .padding({ top:5, bottom: 20 })
  //查询结果表格
  Row({space:10}) {
    Text('部门ID').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Center);
    Text('部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
    Text('部门电话').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
    Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
  }
  .width('95%')
  .padding({  bottom: 10 });

  Column(){
    // 显示查询结果
    if(this.hasSearched){

      if(this.departments.length>0) {

        ForEach(this.departments.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (department: Department) => {
          Row({ space: 10 }) {

            Text(department.dep_ID.toString()).width(60).textAlign(TextAlign.Center);
            Text(department.dep_name).width(70).textAlign(TextAlign.Start);
            Text(department.dep_phone).width(70).textAlign(TextAlign.Start);
            Text(department.creat_date).width(70).textAlign(TextAlign.Start);
            Text('查看')
              .fontColor('#8AB7FF')
              .onClick(() => this.onClickView(department))
          }
          .padding({ top: 15, bottom: 10 });
        })


      }
      else {
        // 如果没有结果，显示一条提示信息
        Text('没有查询到相关部门信息')
          .fontColor('red')
          .padding({ top: 15, bottom: 10 });
      }

    }
  }
  .height('65%')
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
        const maxPage = Math.ceil(this.departments.length / this.itemsPerPage);
        if (this.currentPage < maxPage) {
          this.currentPage++;
        }
      });
  }.alignItems(VerticalAlign.Center)
  .height('5%')
  Row({space:20}) {
    Column() {
      Image($r('app.media.test2'))
        .width(30)
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/addDPMentPage'
          })
        })
      Text(this.message1)
        .fontSize(15)
        .textAlign(TextAlign.Start)

    }.alignItems(HorizontalAlign.Center)
    .padding({top:20})
    .width('60%')

    Column() {
      Image($r('app.media.test3'))
        .width(30)
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/changeDPMentPage'
          })
        })
      Text(this.message2)
        .fontSize(15)
        .textAlign(TextAlign.End)

    }.alignItems(HorizontalAlign.Center)
    .padding({top:20})


  }.width('100%')
}
.width('100%')
.height('100%')
.backgroundImageSize({width:'100%',height:'100%'})*/