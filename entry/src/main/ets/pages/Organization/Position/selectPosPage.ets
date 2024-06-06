import router from '@ohos.router';
import { posby_ID } from '../../../httpRequest/Position/posby_ID'
import { Position } from '../../../entity/Position'
import {depby_ID}  from '../../../httpRequest/Position/posby_ID'
import { Add_pos } from '../../../httpRequest/Position/posAdd';
import { Change_pos } from '../../../httpRequest/Position/posChange';
@Entry
@Component
struct SelectPosPage {
  @State pos_id: number = 0;
  @State dep_id: number = 0;
  @State queryType: string = '岗位ID查询';
  @State inputValue: string = '';
  @State positions: Position[] = [];
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 8; // 每页显示的项目数量
  @State message: string = '岗位管理'
  @State message1: string = '增加岗位'
  @State message2: string = '修改岗位'

  @State pos:Position=new Position(0,'','','','','')
  private selectedDate: Date = new Date()

  @State posChange:Position=new Position(0,'','','','','')
  private selectedDateChange: Date = new Date()


  onClickView(pos: Position) {
    console.log('查看按钮被点击');
    const positionJson = JSON.stringify(pos);
    console.log('Encoded position:', positionJson);
    router.pushUrl({
      url: 'pages/Organization/Position/posdetailsPage',
      params: {
        pos: positionJson
      }
    });
  }

  build() {
    Tabs({barPosition:BarPosition.End}){
      //查找
      TabContent(){
        Column() {
          Row() {
            Column() {
              Image($r("app.media.back"))
                // .fitOriginalSize(true)
                .width(30)
                .onClick(() => {
                  router.back()
                })
            }.width('30%')
            .alignItems(HorizontalAlign.Start)

            Text(this.message)
              .fontSize(30)
              .textAlign(TextAlign.Center)

          }.padding({ top: 15 })
          .width('90%')

          Row({ space: 10 }) {
            TextInput({ placeholder: '请输入查询id',text:this.inputValue})

              .onChange((value: string) => {
                this.inputValue=value
                const numericValue = parseInt(value, 10);
                if (this.queryType === '岗位ID查询') {
                  this.pos_id = isNaN(numericValue) ? 0 : numericValue;

                } else if (this.queryType === '部门ID查询') {
                  this.dep_id = isNaN(numericValue) ? 0 : numericValue;
                }
                console.info('Input value changed, pos_id: ' + this.pos_id + ', dep_id: ' + this.dep_id);
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
                this.positions = [];
                // 设置 hasSearched 为 false，表示查询过程中
                this.hasSearched = false;
                this.currentPage = 1
                if (this.dep_id != 0) {
                  // 根据 dep_id 查询数据
                  depby_ID(this.dep_id).then((positions) => {
                    this.positions = positions
                    this.hasSearched = true;
                    console.log(JSON.stringify(this.positions, null, 2));
                  }).catch(error => {
                    console.error('Error fetching department:', error);
                    this.positions = []; // 确保在错误情况下清空显示的数据
                    this.hasSearched = true; // 查询完成后设置为已进行查询
                  })

                }
                else{
                  // 根据 dep_id 查询数据
                  posby_ID(this.pos_id).then((positions) => {
                    this.positions = positions
                    this.hasSearched = true;
                    console.log(JSON.stringify(this.positions, null, 2));
                  }).catch(error => {
                    console.error('Error fetching department:', error);
                    this.positions = []; // 确保在错误情况下清空显示的数据
                    this.hasSearched = true; // 查询完成后设置为已进行查询
                  })
                }
              })
              .width('20%')
              .padding(12)
              .fontSize(15)
          }
          .width('100%')
          .padding({ top:5})


          // Select component for choosing query type
          Select([
            { value: '岗位ID查询'},
            { value: '部门ID查询' }
          ])
            .selected(0)  // 默认选择为“岗位”
            .font({ size: 16, weight: FontWeight.Medium })
            .fontColor('#7BB6EB')
            .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
            .optionFont({ size: 16, weight: FontWeight.Regular })
            .onSelect((index: number) => {
              this.pos_id=0
              this.dep_id=0
              this.inputValue = ''; // 清空输入框的值
              this.queryType = index ===0 ? '岗位ID查询' : '部门ID查询';

              console.info('Selected query type:' + this.queryType);
            })
          // Adding some margin for better spacing

          //查询结果表格

          Row({ space: 10 }) {
            Text('岗位ID').fontWeight(FontWeight.Bold).width(60).textAlign(TextAlign.Center);
            Text('岗位名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
            Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
            Text('部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
            Text('详情').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
          }
          .padding({ bottom: 10 });


          Column() {
            // 显示查询结果
            if (this.hasSearched) {

              if (this.positions.length > 0) {

                ForEach(this.positions.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (position: Position) => {
                  Row({ space: 10 }) {
                    Text(position.pos_ID.toString()).width(60).textAlign(TextAlign.Center);
                    Text(position.pos_name).width(70).textAlign(TextAlign.Start);
                    Text(position.creat_date).width(70).textAlign(TextAlign.Start);
                    // Text(position.belong_depID).width(70).textAlign(TextAlign.Start);
                    Text(position.dep_name).width(70).textAlign(TextAlign.Start);
                    Text('查看')
                      .fontColor('#8AB7FF')
                      .onClick(() => this.onClickView(position));
                  }
                  .padding({ top: 15, bottom: 10 });
                })
                // 分页控件

              }
              else {
                // 如果没有结果，显示一条提示信息
                Text('没有查询到相关岗位信息')
                  .fontColor('red')
                  .padding({ top: 15, bottom: 10 });
              }

            }
          }
          .height('70%')
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
                const maxPage = Math.ceil(this.positions.length / this.itemsPerPage);
                if (this.currentPage < maxPage) {
                  this.currentPage++;
                }
              });
          }.alignItems(VerticalAlign.Center)
          .height('5%')
        }
        .width('100%')
        .height('100%')
        .backgroundImageSize({ width: '100%', height: '100%' })
      }.tabBar('查找岗位信息')

      //新增
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
      }.tabBar('新增岗位')

      //修改
      TabContent(){
        Column({space:10}) {
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
                this.posChange.pos_ID=id
              }).placeholderColor('#C3C3C3')
          }
          .width('95%')
          .justifyContent(FlexAlign.Start)



          Row({space:15}){
            Text('岗位名称')
              .fontSize(20)
            TextInput({placeholder:'请输入岗位名称'})
              .onChange((value)=>{
                this.posChange.pos_name=value
              }) .placeholderColor('#C3C3C3')
          }
          .width('95%')
          .justifyContent(FlexAlign.Start)


          Row({space:20}){
            Text('成立时间')
              .fontSize(20)

            Button(this.posChange.creat_date || '请选择日期')
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
                    this.posChange.creat_date = `${value.year}-${value.month + 1}-${value.day}`
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
                this.posChange.dep_ID=value
              })   .placeholderColor('#C3C3C3')
          }
          .width('95%')
          .justifyContent(FlexAlign.Start)

          Row({space:10}){
            Text('所属部门名称')
              .fontSize(20)
            TextInput({placeholder:'请输入岗位所属部门名称'})
              .onChange((value)=>{
                this.posChange.dep_name=value
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
                this.posChange.detail=value
              })
              .placeholderColor('#C3C3C3')
              .width('90%')
              .height('150')
          }

          Button('提交')
            .onClick(() => {
              //调用接口，修改岗位
              Change_pos(this.posChange)
                .then((response)=>{
                  if(response){
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
                    console.log('修改成功')
                  }else{
                    console.log('修改失败')
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
      }.tabBar('修改岗位信息')
    }
  }
}


/*Column() {
  Row() {
    Column() {
      Image($r("app.media.back"))
        // .fitOriginalSize(true)
        .width(30)
        .onClick(() => {
          router.back()
        })
    }.width('30%')
    .alignItems(HorizontalAlign.Start)

    Text(this.message)
      .fontSize(30)
      .textAlign(TextAlign.Center)

  }.padding({ top: 15 })
  .width('90%')

  Row({ space: 10 }) {
    TextInput({ placeholder: '请输入查询id',text:this.inputValue})

      .onChange((value: string) => {
        this.inputValue=value
        const numericValue = parseInt(value, 10);
        if (this.queryType === '岗位ID查询') {
          this.pos_id = isNaN(numericValue) ? 0 : numericValue;

        } else if (this.queryType === '部门ID查询') {
          this.dep_id = isNaN(numericValue) ? 0 : numericValue;
        }
        console.info('Input value changed, pos_id: ' + this.pos_id + ', dep_id: ' + this.dep_id);
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
        this.positions = [];
        // 设置 hasSearched 为 false，表示查询过程中
        this.hasSearched = false;
        this.currentPage = 1
        if (this.dep_id != 0) {
          // 根据 dep_id 查询数据
          depby_ID(this.dep_id).then((positions) => {
            this.positions = positions
            this.hasSearched = true;
            console.log(JSON.stringify(this.positions, null, 2));
          }).catch(error => {
            console.error('Error fetching department:', error);
            this.positions = []; // 确保在错误情况下清空显示的数据
            this.hasSearched = true; // 查询完成后设置为已进行查询
          })

        }
        else{
          // 根据 dep_id 查询数据
          posby_ID(this.pos_id).then((positions) => {
            this.positions = positions
            this.hasSearched = true;
            console.log(JSON.stringify(this.positions, null, 2));
          }).catch(error => {
            console.error('Error fetching department:', error);
            this.positions = []; // 确保在错误情况下清空显示的数据
            this.hasSearched = true; // 查询完成后设置为已进行查询
          })
        }
      })
      .width('20%')
      .padding(12)
      .fontSize(15)
  }
  .width('100%')
  .padding({ top:5})


  // Select component for choosing query type
  Select([
    { value: '岗位ID查询'},
    { value: '部门ID查询' }
  ])
    .selected(0)  // 默认选择为“岗位”
    .font({ size: 16, weight: FontWeight.Medium })
    .fontColor('#7BB6EB')
    .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
    .optionFont({ size: 16, weight: FontWeight.Regular })
    .onSelect((index: number) => {
      this.pos_id=0
      this.dep_id=0
      this.inputValue = ''; // 清空输入框的值
      this.queryType = index ===0 ? '岗位ID查询' : '部门ID查询';

      console.info('Selected query type:' + this.queryType);
    })
  // Adding some margin for better spacing

  //查询结果表格

  Row({ space: 10 }) {
    Text('岗位ID').fontWeight(FontWeight.Bold).width(60).textAlign(TextAlign.Center);
    Text('岗位名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
    Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
    Text('部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
    Text('详情').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
  }
  .padding({ bottom: 10 });


  Column() {
    // 显示查询结果
    if (this.hasSearched) {

      if (this.positions.length > 0) {

        ForEach(this.positions.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (position: Position) => {
          Row({ space: 10 }) {
            Text(position.pos_ID.toString()).width(60).textAlign(TextAlign.Center);
            Text(position.pos_name).width(70).textAlign(TextAlign.Start);
            Text(position.creat_date).width(70).textAlign(TextAlign.Start);
            // Text(position.belong_depID).width(70).textAlign(TextAlign.Start);
            Text(position.dep_name).width(70).textAlign(TextAlign.Start);
            Text('查看')
              .fontColor('#8AB7FF')
              .onClick(() => this.onClickView(position));
          }
          .padding({ top: 15, bottom: 10 });
        })
        // 分页控件

      }
      else {
        // 如果没有结果，显示一条提示信息
        Text('没有查询到相关岗位信息')
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
        const maxPage = Math.ceil(this.positions.length / this.itemsPerPage);
        if (this.currentPage < maxPage) {
          this.currentPage++;
        }
      });
  }.alignItems(VerticalAlign.Center)
  .height('4%')

  Row({ space: 20 }) {
    Column() {
      Image($r('app.media.test2'))
        .width(30)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Organization/Position/addPosPage'
          })
        })
      Text(this.message1)
        .fontSize(15)
        .textAlign(TextAlign.Start)

    }.alignItems(HorizontalAlign.Center)
    .padding({ top: 10 })
    .width('55%')

    Column() {
      Image($r('app.media.test3'))
        .width(30)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/Organization/Position/changePosPage'
          })
        })
      Text(this.message2)
        .fontSize(15)
        .textAlign(TextAlign.End)

    }.alignItems(HorizontalAlign.Center)
    .padding({ top: 20 })
  }.width('100%')

}
.width('100%')
.height('100%')
.backgroundImageSize({ width: '100%', height: '100%' })*/