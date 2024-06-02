import router from '@ohos.router'
import { employee } from '../../../../entity/employee'
import { queryRequest } from '../../../../httpRequest/employee/information/empQueryRequest'
import { queryRequest_0 } from '../../../../httpRequest/employee/information/queryRequest_0'
import { queryRequest_1 } from '../../../../httpRequest/employee/information/queryRequest_1'
import { queryRequest_2 } from '../../../../httpRequest/employee/information/queryRequest_2'
import { queryRequest_3 } from '../../../../httpRequest/employee/information/queryRequest_3'
import { queryRequest_4 } from '../../../../httpRequest/employee/information/queryRequest_4'
@Entry
@Component
struct QueryPage {
  @State message: string = '员工查询'
  @State emp:employee=new employee()
  @State emps:employee[]=[]
  @State currentPage:number=1
  @State itemsPerPage:number=9
  @State hasSearch:boolean=false
  @State pick:number=0
  @State empId:string=''
  @State posId:string=''
  @State depId:string=''
  @State enterMode:string='                  '
  private list01:Array<string>=['员工ID','岗位ID','部门ID']


  build() {
    Column() {
      Row(){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            router.back()
          })
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({left:70})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row({space:10}){
        ForEach(
          this.list01,
          (item:string)=>{
              Text(item+':')
                .fontWeight(FontWeight.Bold)
                .fontSize(20)
                .width(100)

          })
      }
      .width('90%')
      .margin({top:10})

      /*TextInput({placeholder:item})
        .width(100)
        .onChange((value)=>{
          if(item=='员工ID'){
            const id=parseInt(value)
            this.empId=id
            this.pick=1
            this.posId=0
            this.depId=0
            this.enterMode=''
          }else if(item=='岗位ID'){
            const id=parseInt(value)
            this.posId=id
            this.pick=2
            this.empId=0
            this.depId=0
            this.enterMode=''
          }else{
            const id=parseInt(value)
            this.depId=id
            this.pick=3
            this.posId=0
            this.empId=0
            this.enterMode=''

          }
        })*/

      Row({space:5}){
        TextInput({text:this.empId.toString()})
          .width(100)
          .onClick(()=>{
            this.posId=''
            this.depId=''
            this.enterMode='                  '
          })
          .onChange((id)=>{

            this.empId=id
            this.pick=1

          })
        TextInput({text:this.posId.toString()})
          .width(100)
          .onClick(()=>{
            this.empId=''
            this.depId=''
            this.enterMode='                  '
          })
          .onChange((id)=>{

            this.posId=id
            this.pick=2

          })
        TextInput({text:this.depId.toString()})
          .width(100)
          .onClick(()=>{
            this.posId=''
            this.empId=''
            this.enterMode='                  '
          })
          .onChange((id)=>{

            this.depId=id
            this.pick=3
          })
      }
      .width('90%')

      Row(){
        Text('入职方式：')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Select([{value:'普通入职'},
          {value:'人才库入职'}])
          .value(this.enterMode)
          .backgroundColor('#F2F2F2')
          .width(150)
          .onClick(()=>{
            if(this.empId!=''||this.posId!=''||this.depId!=''){
              this.empId=''
              this.posId=''
              this.depId=''
            }
          })
          .onSelect((index)=>{
            if(index==0){
              this.enterMode='普通入职'
            }else {
              this.enterMode='人才库入职'
            }
            this.pick=4
          })

        Button('查询')
          .type(ButtonType.Normal)
          .borderRadius(10)
          .margin({left:20})
          .onClick(()=>{
            //接口
            // pick ： 0-查全部  1-查员工id  2-岗位id  3-查部门id    4-查入职方式
            if(this.pick==0){
              queryRequest_0().then(response=>{
                if(response){
                  this.hasSearch=true
                  this.emps=response
                }
              })
            }else if(this.pick==1){
              queryRequest_1(parseInt(this.empId)).then(response=>{
                if(response){
                  this.hasSearch=true
                  this.emp=response
                }
              })
            }else if(this.pick==2){
              queryRequest_2(parseInt(this.posId)).then(response=>{
                if(response){
                  this.hasSearch=true
                  this.emps=response
                }
              })
            }else if(this.pick==3){
              queryRequest_3(parseInt(this.depId)).then(response=>{
                if(response){
                  this.hasSearch=true
                  this.emps=response
                }
              })
            }else if(this.pick==4){
              queryRequest_4(this.enterMode).then(response=>{
                if(response){
                  this.hasSearch=true
                  this.emps=response
                }
              })
            }
            /*console.log(JSON.stringify(this.emp.toString()))
            queryRequest(this.emp).then(response=>{
              if(response){
                this.hasSearch=true
                this.emps=response
              }
            })*/
          })
      }
      .margin(10)

      Row({space:10}){
        //id,name,gender,phone
        //                            详情
        Text('员工ID').fontWeight(FontWeight.Bold).width(50).margin({left:10}).textAlign(TextAlign.Center)
        Text('员工姓名').fontWeight(FontWeight.Bold).width(70).textAlign(TextAlign.Center)
        Text('性别').fontWeight(FontWeight.Bold).width(40).textAlign(TextAlign.Center)
        Text('电话').fontWeight(FontWeight.Bold).width(100).textAlign(TextAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin(10)
      .backgroundColor('#F2F2F2')
      .width('95%')
      .margin(5)


      Column({space:10}){
        if(this.hasSearch){
          if(this.pick==1)
          {
            Row({space:10}){
              Text(this.emp.emp_ID.toString()).width(50).margin({left:10}).textAlign(TextAlign.Center)
              Text(this.emp.emp_name).width(70).textAlign(TextAlign.Center)
              Text(this.emp.gender).width(40).fontSize(15).textAlign(TextAlign.Center)
              Text(this.emp.phone).fontSize(12).width(100).textAlign(TextAlign.Center)
              Text('详情').fontColor('#36D').width(40).textAlign(TextAlign.Center)
                .onClick(()=>{
                  console.log('操作按钮被点击')
                  console.log(JSON.stringify(this.emp))
                  router.pushUrl({
                    url:'pages/employee/information/Query/empDetailPage',
                    params: {
                      employee: JSON.stringify(this.emp)
                    }
                  })
                })
            }
            .width('95%')
          }else {
            ForEach(this.emps.slice((this.currentPage-1)*this.itemsPerPage,this.currentPage*this.itemsPerPage),
              (item:employee)=>{
                Row({space:10}){
                  Text(item.emp_ID.toString()).width(50).margin({left:10}).textAlign(TextAlign.Center)
                  Text(item.emp_name).width(70).textAlign(TextAlign.Center)
                  Text(item.gender).width(40).fontSize(15).textAlign(TextAlign.Center)
                  Text(item.phone).fontSize(12).width(100).textAlign(TextAlign.Center)
                  Text('详情').fontColor('#36D').width(40).textAlign(TextAlign.Center)
                    .onClick(()=>{
                      console.log('操作按钮被点击')
                      console.log(JSON.stringify(item))
                      router.pushUrl({
                        url:'pages/employee/information/Query/empDetailPage',
                        params: {
                          employee: JSON.stringify(item)
                        }
                      })
                    })
                }
                .width('95%')

              })
          }


        }    //hasSearch
      }
      .height('65%')


      //分页器
      if(this.hasSearch){
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
            })
        }.alignItems(VerticalAlign.Center)
        .height('5%')
      }


    }
    .width('100%')
    .height('100%')
  }
}