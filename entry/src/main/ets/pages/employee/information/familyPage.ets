import router from '@ohos.router'
import { familyDelete } from '../../../httpRequest/employee/information/FamilyDelete'
import { familyFind } from '../../../httpRequest/employee/information/FamilyFind'
@Entry
@Component
struct FamilyPage {
  @State message: string = '家庭关系'

  @State empId:string=''
  @State family:Family=new Family()
  @State families:Family[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询
  @State currentPage:number=1
  @State itemsPerPage:number=12

  private tabsController:TabsController =new TabsController()



  build() {
    Row(){
      Column(){
        Tabs({barPosition:BarPosition.End,controller:this.tabsController}){
          TabContent(){
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


              //输入栏+查询按钮
              Row(){
                Image($r('app.media.search'))
                  .width(25)

                TextInput({ placeholder:'请输入员工ID' })
                  .width(150)
                  .onChange((value)=>{
                    this.empId=value
                  })

                Blank()

                Button('查询')
                  .width(100)
                  .stateEffect(true)
                  .type(ButtonType.Normal)
                  .borderRadius(15)           //四角的弧度
                  .onClick(()=>{
                    this.hasSearched=true
                    const id=parseInt(this.empId)
                    familyFind(id)
                      .then(response=>{
                        this.families=response
                      })
                  })

              }
              .width('90%')
              .margin(10)

              Row({space:10}){
                Text('员工ID').fontWeight(FontWeight.Bold).width(50).margin({left:10})
                Text('员工姓名').fontWeight(FontWeight.Bold).width(50)
                Text('联系人姓名').fontWeight(FontWeight.Bold).width(50)
                Text('联系人关系').fontWeight(FontWeight.Bold).width(50)
                Text('联系人电话').fontWeight(FontWeight.Bold).width(90)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
              .margin(10)
              .backgroundColor('#F2F2F2')


              Column({space:10}){
                ForEach(
                  this.families.slice((this.currentPage-1)*this.itemsPerPage,this.currentPage*this.itemsPerPage),
                  (item:Family)=>{
                    Row({space:10}){
                      if(this.hasSearched){
                        Text(item.emp_ID.toString()).width(50).textAlign(TextAlign.Center)
                        Text(item.emp_name).width(50).textAlign(TextAlign.Center)
                        Text(item.relation_name).width(50).textAlign(TextAlign.Center)
                        Text(item.relation_type).width(50).textAlign(TextAlign.Center)
                        Text(item.contact_info).width(90).textAlign(TextAlign.Center)

                        Text('操作').fontColor('#36D').width(70).textAlign(TextAlign.Center)
                          .onClick(()=>{
                            console.log('操作按钮被点击')
                            console.log(JSON.stringify(item))
                            router.pushUrl({
                              url:'pages/employee/information/OpLanguagePage',
                              params: {
                                language: JSON.stringify(item)
                              }
                            })
                          })
                      }
                    }
                    .width('100%')
                  })
              }
              .height('70%')
              //分页器
              if(this.hasSearched){
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
                      const maxPage = Math.ceil(this.families.length / this.itemsPerPage);
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
          }.tabBar('家庭关系')

          //新增
          TabContent(){
            Column(){
              Row(){
                Image($r('app.media.back'))
                  .width(30)
                  .onClick(()=>{
                    router.back()
                  })
                Text('新增家庭关系')
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:50})
              }
              .width('90%')
              .margin({top:10})

              Divider()
                .strokeWidth(5)
                .margin({top:5,bottom:20})

              Column({space:15}){
                Row(){
                  Text('关系ID')
                    .width(100)
                  TextInput({placeholder:'请输入关系ID'})
                    .width(200)
                    .onChange((value)=>{
                      const id=parseInt(value)
                      this.family.relation_ID=id
                    })
                }.width('95%')
                Row(){
                  Text('员工ID')
                    .width(100)
                  TextInput({placeholder:'请输入员工ID'})
                    .width(200)
                    .onChange((value)=>{
                      const id=parseInt(value)
                      this.family.emp_ID=id
                    })
                }.width('95%')
                Row(){
                  Text('员工姓名')
                    .width(100)
                  TextInput({placeholder:'请输入员工姓名'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.emp_name=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人姓名')
                    .width(100)
                  TextInput({placeholder:'请输入联系人姓名'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.relation_name=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人关系')
                    .width(100)
                  TextInput({placeholder:'请输入联系人关系'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.relation_type=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人电话')
                    .width(100)
                  TextInput({placeholder:'请输入联系人电话'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.contact_info=value
                    })
                }.width('95%')
              }

              Button('提交')
                .width(100)
                .onClick(()=>{
                  //
                })
                .margin({top:50})
            }
            .height('100%')
          }.tabBar('新增家庭关系')

          //修改
          TabContent(){
            Column(){
              Row(){
                Image($r('app.media.back'))
                  .width(30)
                  .onClick(()=>{
                    router.back()
                  })
                Text('修改家庭关系')
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:50})
              }
              .width('90%')
              .margin({top:10})

              Divider()
                .strokeWidth(5)
                .margin({top:5})

              Column({space:15}){
                Row(){
                  Text('关系ID')
                    .width(100)
                  TextInput({placeholder:'请输入关系ID'})
                    .width(200)
                    .onChange((value)=>{
                      const id=parseInt(value)
                      this.family.relation_ID=id
                    })
                }.width('95%')
                Row(){
                  Text('员工ID')
                    .width(100)
                  TextInput({placeholder:'请输入员工ID'})
                    .width(200)
                    .onChange((value)=>{
                      const id=parseInt(value)
                      this.family.emp_ID=id
                    })
                }.width('95%')
                Row(){
                  Text('员工姓名')
                    .width(100)
                  TextInput({placeholder:'请输入员工姓名'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.emp_name=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人姓名')
                    .width(100)
                  TextInput({placeholder:'请输入联系人姓名'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.relation_name=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人关系')
                    .width(100)
                  TextInput({placeholder:'请输入联系人关系'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.relation_type=value
                    })
                }.width('95%')
                Row(){
                  Text('联系人电话')
                    .width(100)
                  TextInput({placeholder:'请输入联系人电话'})
                    .width(200)
                    .onChange((value)=>{
                      this.family.contact_info=value
                    })
                }.width('95%')
              }

              Button('修改')
                .width(100)
                .onClick(()=>{
                  //
                })
                .margin({top:50})


              Text('提示：根据关系id进行查找修改')
                .fontSize(15)
                .fontColor('red')
                .margin(20)
            }
            .height('100%')
          }.tabBar('修改家庭关系')

          //删除
          TabContent(){
            Column(){
              Row(){
                Image($r('app.media.back'))
                  .width(30)
                  .onClick(()=>{
                    router.back()
                  })
                Text('删除家庭关系')
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)
                  .margin({left:50})
              }
              .width('90%')
              .margin({top:10})

              Divider()
                .strokeWidth(5)
                .margin({top:5})

              Row(){
                Text('关系ID')
                  .width(100)
                TextInput({placeholder:'请输入关系ID'})
                  .width(200)
                  .onChange((value)=>{
                    const id=parseInt(value)
                    this.family.relation_ID=id
                  })
              }.width('95%')
              .margin(20)

              Button('删除')
                .margin(10)
                .width(100)
                .fontColor('red')
                .onClick(()=>{
                  AlertDialog.show({
                    title:'提示',
                    message:'确认删除该关系？',
                    primaryButton:{
                      value:'否',
                      action:()=>{}
                    },
                    secondaryButton:{
                      value:'是',
                      action:()=>{
                        familyDelete(this.family.relation_ID)
                          /*.then(response=>{
                            if(response){

                            }
                          })*/
                      }
                    }
                  })

                })
            }
            .height('100%')
          }.tabBar('删除家庭关系')

        }
        .scrollable(false)
        .height('100%')
        .barWidth('100%')
      }
    }

  }
}

export class Family {
  relation_ID:number
  emp_ID:number
  emp_name:string
  relation_name:string
  relation_type:string
  contact_info:string
}