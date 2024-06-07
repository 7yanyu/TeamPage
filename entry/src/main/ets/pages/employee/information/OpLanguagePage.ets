import router from '@ohos.router'
import { employee } from '../../../entity/employee'
import { detailRequest } from '../../../httpRequest/employee/information/detailRequest'
import { languageChange } from '../../../httpRequest/employee/information/languageChange'
import { languageFind } from '../../../httpRequest/employee/information/LanguageFind'
import { Language } from './languagePage'
@Entry
@Component
struct OpCareerPage {
  @State message: string = '外语能力操作'
  @State language:Language=new Language()
  // @State selectDate:Date=new Date

  onPageShow(){
    console.log('onInit called'); // 确认 onInit 被调用
    const params=router.getParams() as {language:string}
    console.log('Params:', params); // 打印整个 params 对象
    if(params && params.language){
      const languageJson=params.language
      console.log('employeeJson:',languageJson)
      try {
        const languageData=JSON.parse(languageJson)
        this.language=languageData
      }catch (error){
        console.error('Failed to parse employee data', error);
      }
    }else {
      console.log('not found')
    }
  }

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
          .margin({left:45})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row(){
        Image($r('app.media.lang'))
          .width(100)
          .margin(10)
        Column(){
          Text(this.language.emp_name)
            .fontSize(30)
            .margin({bottom:15})
          /*Text(this.language)
            .fontSize(30)
            .margin({top:15})*/
        }
      }
      .width('100%')
      .margin(10)

      Row(){
        Text('外语语种')
          .fontSize(20)
          .margin({right:40})
        TextInput({text:this.language.language_name})
          .onChange(value=>{
            this.language.language_name=value
          })
      }
      .width('95%')
      .margin({top:20})
      .justifyContent(FlexAlign.Center)

      Text('等级')
        .fontSize(20)
        .margin({right:260,top:20,bottom:10})

      TextArea({ text:this.language.proficiency_level })
        .margin(10)
        .backgroundColor('#F4F6F5')
        .width('90%')
        .onChange((value)=>{
          this.language.proficiency_level=value
        })

      Button('修改')
        .width(100)
        .margin(15)
        .onClick(()=>{
          languageChange(this.language).then(response=>{
            if(response){
              console.log(this.language.toString())
              AlertDialog.show({
                title:'提示',
                message:'操作成功，是否返回？',
                primaryButton:{
                  value:'No',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'Yes',
                  action:()=>{
                    router.back()
                  }
                }
              })
            }
          })
        })
    }
    .width('100%')
    .height('100%')


  }
}