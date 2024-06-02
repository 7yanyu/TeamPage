import router from '@ohos.router';

import { languageFind } from '../../../httpRequest/employee/information/LanguageFind';
@Entry
@Component
struct LanguagePage {
  @State message: string = '外语能力'

  @State empId:string=''
  @State language:Language=new Language()
  @State languages:Language[]=[]
  @State hasSearched: boolean = false; // 用于跟踪是否进行了查询




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
            languageFind(id)
              .then(response=>{
                this.languages=response
              })
          })

      }
      .width('90%')
      .margin(10)

      Row({space:10}){
        //id,name,datea,situation
        //                            操作
        Text('员工ID').fontWeight(FontWeight.Bold).width(50).margin({left:10})
        Text('员工姓名').fontWeight(FontWeight.Bold).width(70)
        Text('工作经历').fontWeight(FontWeight.Bold).width(70)
        Text('学历背景').fontWeight(FontWeight.Bold).width(70)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin(10)
      .backgroundColor('#F2F2F2')

      ForEach(
        this.languages,
        (item:Language)=>{
          Row({space:10}){
            if(this.hasSearched){
              Text(item.emp_ID.toString()).width(50).textAlign(TextAlign.Center)
              Text(item.emp_name).width(70).textAlign(TextAlign.Center)
              Text(item.language_name).width(70).fontSize(15).textAlign(TextAlign.Center)
              Text(item.proficiency_level).width(70).textAlign(TextAlign.Center)
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
        }
      )

    }
    .width('100%')
    .height('100%')
  }
}

export class Language {
  language_ID:number
  emp_ID:number
  emp_name:string
  language_name:string
  proficiency_level:string
}