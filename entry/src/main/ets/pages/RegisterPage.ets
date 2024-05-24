import router from '@ohos.router'
import { Users } from '../entity/Users'
import { Register } from '../httpRequest/Register' // 假设这是您注册方法所在的文件
import { registerContent } from '../module/registerContent'

@Entry
@Component
struct RegisterPage {
  @State user: Users = new Users( 0, '', '', '', '')// 初始化一个空的用户对象
  @State errorMessage: string = '' // 用于显示错误消息


  build() {
    Column({ space: 10 }) {
      Row(){
        Button('< Back')
          .fontSize(20)
          .onClick(()=>{
            router.showAlertBeforeBackPage({
              message:'确认返回登陆界面？'
            })
            router.back()
          })
      }
      .width('100%')
      .height(100)
      .padding(15)
      .alignItems(VerticalAlign.Top)

      Column({space:20}){
        // 输入账号
        registerContent({msg:'账号',user:$user})

        // 输入用户真实姓名
        registerContent({msg:'姓名',user:$user})

        // 输入密码
        registerContent({msg:'密码',user:$user})

        // 输入性别
        registerContent({msg:'性别',user:$user})

        // 提示错误信息
      if (this.errorMessage) {
        Text(this.errorMessage).fontColor(Color.Red)
      }

      // 提交按钮
      Row() {
        Button('注册').onClick(() => {
          // 调用 Register 方法，处理注册逻辑
          Register(this.user)
            .then(registerResult => {
              if (registerResult) {
                // 注册成功，执行页面跳转
                router.showAlertBeforeBackPage({
                  message:'注册成功，点击跳转登陆界面'
                })
                router.back()
              } else {
                // 注册失败，显示错误提示信息
                AlertDialog.show({
                  title:'提示',
                  message:'注册失败，账号已重复',
                  autoCancel:false,
                  primaryButton:{
                    value:'确认',
                    action:()=>{}
                  }
                })
              }
            })
          .catch(error => {
            // 注册请求失败，显示网络错误提示信息
            console.error('注册请求失败'+JSON.parse(error))
            this.errorMessage = '网络错误，请稍后重试'
          })
        })
          .width(150)
          .padding(15)
      }
      .padding({top:30})
      }
      .width('100%')
      .height('100%')
    }
    .backgroundImage($r("app.media.LoadBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}