import {Department} from '../../../entity/Department'
import router from '@ohos.router';
@Entry
@Component
struct introduceDPMPage {
  @State message: string = '部门详情'
  @State department: Department | null = null
  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { department: string }; // 类型断言
    console.log('Params:', params); // 打印整个 params 对象
    if (params && params.department) {
      const departmentJson = params.department;
      console.log('Department JSON:', departmentJson); // 打印 department 参数
      try {
        const departmentData = JSON.parse(departmentJson);
        this.department = new Department(
          departmentData.dep_ID,
          departmentData.dep_name,
          departmentData.dep_phone,
          departmentData.creat_date,
          departmentData.detail
        );
        console.log('Department Phone:', this.department.dep_phone); // 确认数据解析成功
      } catch (e) {
        console.error('Failed to parse department data', e);
      }
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.message)
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 20, top: 20 })
          .textAlign(TextAlign.Center);
      }
      if(this.department){
        Column() {
          Row() {
            Text('部门名称:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_name)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }
          Row() {
            Text('部门ID:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_ID.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }
          Row() {
            Text('部门电话:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_phone)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }

          Row() {
            Text('成立时间:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.creat_date)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }

          Row() {
            Text('部门简介:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('100%')
              .padding({top: 15, bottom: 15})
          }
          Row(){
            Text(this.department.detail)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('80%')
              .padding({top: 10, bottom: 15});
          }
        }.height('80%')
        .padding(20)
        .borderRadius(10)
        .margin({ top: 20 })
        .shadow({ color: '#000000', radius: 5, });
      }


    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}