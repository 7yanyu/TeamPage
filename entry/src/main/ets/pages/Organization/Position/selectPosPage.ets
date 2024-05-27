import router from '@ohos.router';
import { posby_ID } from '../../../httpRequest/Position/posby_ID';
import { Position } from '../../../entity/Position'
@Entry
@Component
struct SelectPosPage {
  @State pos_id: number = 0;
  @State positions: Position[] = [];
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 9; // 每页显示的项目数量


  build() {
    Column() {
      Row({space:10}) {
        TextInput({ placeholder: '请输入查询岗位id' })
          .onChange((value: string) => {
            const numericValue = parseInt(value, 10);
            //判断是否输入具体的岗位ID
            this.pos_id = isNaN(numericValue) ? 0 : numericValue;
          })
          .width('70%')
          .padding({ left: 25, right: 10 })
          .fontSize(18)
          .margin({ right: 15 });

        Button('查询')
          .onClick(() => {
            // 清空已有数据
            this.positions = [];
            // 设置 hasSearched 为 false，表示查询过程中
            this.hasSearched = false;
            this.currentPage=1
            // 根据 dep_id 查询数据
            posby_ID(this.pos_id).then((positions)=>{
              this.positions=positions
              this.hasSearched = true;
              console.log(JSON.stringify(this.positions, null, 2));
            }).catch(error => {
              console.error('Error fetching department:', error);
              this.positions = []; // 确保在错误情况下清空显示的数据
              this.hasSearched = true; // 查询完成后设置为已进行查询
            })
          })
          .width('20%')
          .padding(12)
          .fontSize(15)
      }
      .width('100%')
      .padding({ top: 40, bottom: 20 })
      //查询结果表格

      Row({space:10}) {
        Text('岗位ID').fontWeight(FontWeight.Bold).width(60).textAlign(TextAlign.Center);
        Text('岗位名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('所属部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('详情').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
      }
      .padding({ top: 10, bottom: 10 });


      Column(){
        // 显示查询结果
        if(this.hasSearched){

          if(this.positions.length>0) {

            ForEach(this.positions.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (position:Position) => {
              Row({ space: 10 }) {
                Text(position.pos_ID.toString()).width(60).textAlign(TextAlign.Center);
                Text(position.pos_name).width(70).textAlign(TextAlign.Start);
                Text(position.creat_date).width(70).textAlign(TextAlign.Start);
                // Text(position.belong_depID).width(70).textAlign(TextAlign.Start);
                Text(position.dep_name).width(70).textAlign(TextAlign.Start);
                Text('查看')
                  .fontColor('blue')
                  .onClick(() => {
                    router.pushUrl({
                      url: ''
                    });
                  });
              }
              .padding({ top: 15, bottom: 10 });
            })
            // 分页控件

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

      if(this.positions.length>0) {
        Row() {
          Button('上一页')
            .width(100)
            .height(30)
            .fontColor('#fff')
            .backgroundColor('#8bc34a')
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
            .fontColor('#fff')
            .backgroundColor('#8bc34a')
            .borderRadius(5)
            .onClick(() => {
              const maxPage = Math.ceil(this.positions.length / this.itemsPerPage);
              if (this.currentPage < maxPage) {
                this.currentPage++;
              }
            });
        }.alignItems(VerticalAlign.Bottom)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}