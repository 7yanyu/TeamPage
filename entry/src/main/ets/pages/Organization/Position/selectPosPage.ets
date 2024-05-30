import router from '@ohos.router';
import { posby_ID } from '../../../httpRequest/Position/posby_ID';
import { Position } from '../../../entity/Position'
import {depby_ID}  from '../../../httpRequest/Position/posby_ID'
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
      .backgroundImageSize({ width: '100%', height: '100%' })
    }
  }
