import router from '@ohos.router'
import {Holiday} from '../../entity/Holiday'
import {Find_holiday} from  '../../httpRequest/HolidayCat'
@Entry
@Component
struct HoIndexPage{
  @State message:string='假期管理'
  @State holidays:Holiday[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage: number = 1; // 当前页码
  @State itemsPerPage: number = 10; // 每页显示的项目数量
  @State process_state:string=''

  onClickView(holiday:Holiday){
    console.log('查看按钮是否被点击')
    const holidayJson=JSON.stringify(holiday)
    console.log('Encoded Department: ',holidayJson)
    router.pushUrl({
      url:'pages/Holiday/HolidayTails',
      params:{
        holiday:holidayJson
      }
    })
  }

  build(){
    Column(){
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


      Row({space:40}){
        Row({space:10}){
          Image($r("app.media.search"))
            .width(20)
          Text('处理状态:').fontSize('20').width(100).textAlign(TextAlign.Center);
          Select([
            {value:'待处理'},
            { value: '已处理'},
            { value: '已拒绝' }
          ])
            .value('请选择')
            .selected(0)
            .font({ size: 18, weight: FontWeight.Medium })
            .fontColor('#7BB6EB')
            .selectedOptionFont({ size: 16, weight: FontWeight.Regular })
            .optionFont({ size: 18, weight: FontWeight.Regular })
            .onSelect((index: number) => {
              if(index==0){
                this.process_state='待处理'

              }
              else if(index==1){
                this.process_state='已处理'

              }
              else{
                this.process_state='已拒绝'
              }


            })
        }

        Button('查询')
          .fontColor('black')
          .backgroundColor('#99D9EA')
          .width('20%')
          .padding(8)
          .fontSize(13)
          .onClick(()=>{
            console.log('123')
            //清空已有数据
            this.holidays=[]
            // 设置 hasSearched 为 false，表示查询过程中
            this.hasSearched = false;
            this.currentPage=1
            console.log(this.process_state)
            Find_holiday(this.process_state).then(holidays=>{
              this.holidays=holidays
              this.hasSearched = true;
              console.log(JSON.stringify(this.holidays, null, 2))
              console.log(this.holidays.length.toString())



            }).catch(error => {
              console.error('Error fetching department:', error);
              this.hasSearched = true;
              this.holidays= []; // 确保在错误情况下清空显示的数据
              this.hasSearched = true; // 查询完成后设置为已进行查询


            })




          })
      }.width('90%')
        .padding({top:8})

      //查询结果表格
      Row({space:10}) {
        Text('ID').fontWeight(FontWeight.Bold).width(20).textAlign(TextAlign.Start);
        Text('员工ID').fontWeight(FontWeight.Bold).width(50).textAlign(TextAlign.Start);
        Text('员工姓名').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
        Text('请假类型').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
        Text('处理状态').fontWeight(FontWeight.Bold).width(65).textAlign(TextAlign.Start);
      }
      .width('95%')
      .padding({top:8})

      Column() {
        //显示查询结果
        if(this.hasSearched){
          if (this.holidays.length > 0) {
            ForEach(this.holidays.slice((this.currentPage - 1) * this.itemsPerPage, this.currentPage * this.itemsPerPage), (holiday:Holiday) => {
              Row({ space: 20 }) {
                Text(holiday.id.toString()).width(30).textAlign(TextAlign.Center);
                Text(holiday.emp_ID.toString()).width(30).textAlign(TextAlign.Start);
                Text(holiday.emp_name).width(50).textAlign(TextAlign.Start);
                Text(holiday.type).width(50).textAlign(TextAlign.Start);
                Text(holiday.process_state).width(50).textAlign(TextAlign.Start);
                Text('处理')
                  .fontColor('#8AB7FF')
                  .onClick(() => this.onClickView(holiday))
              }
              .padding({ top: 15, bottom: 10 })
            })
          }
          else {
            // 如果没有结果，显示一条提示信息
            Text('没有查询到相关假期信息')
              .fontColor('red')
              .padding({ top: 15, bottom: 10 });
          }
        }
      }.height('70%')
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
            const maxPage = Math.ceil(this.holidays.length / this.itemsPerPage);
            if (this.currentPage < maxPage) {
              this.currentPage++;
            }
          });
      }.alignItems(VerticalAlign.Center)
      .height('5%')
























    } .width('100%')
    .height('100%')
  }
}