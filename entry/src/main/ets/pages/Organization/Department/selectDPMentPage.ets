import {Department} from '../../../entity/Department'
import {depby_ID} from '../../../httpRequest/Department/depby_ID'
import router from '@ohos.router'
@Entry
@Component
struct SelectPage {
  @State dep_id: number = 0;
  @State departments: Department[] = [];
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 9; // 每页显示的项目数量
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
    Column() {
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
      .padding({ top: 40, bottom: 20 })
      //查询结果表格

      Row({space:10}) {
        Text('部门ID').fontWeight(FontWeight.Bold).width(60).textAlign(TextAlign.Center);
        Text('部门名称').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('部门电话').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('成立时间').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
        Text('详情').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Start);
      }
      .padding({ top: 10, bottom: 10 });


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
                  .fontColor('blue')
                  .onClick(() => this.onClickView(department))
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

      if(this.departments.length>0) {
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
              const maxPage = Math.ceil(this.departments.length / this.itemsPerPage);
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