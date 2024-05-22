import router from '@ohos.router'
import { User } from '../entity/User'
import { Login } from '../httpRequest/Login'
@Entry
@Component
struct LoadPage {
  @State message: string = 'HELLO！'
  @State user:User= new User('','')
  @State loadtofirst:number =0

  build() {
    Column({space:10}) {

      Row(){
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor('#81B337')
      }
      .width('100%')
      .padding({top:200,left:30})
      .justifyContent(FlexAlign.Center)

      //输入账号，密码
      Row(){
        Column({space:10}){
          TextInput({placeholder:'请输入账号'})
            .onChange((value:string)=>{
              // this.user.account=value
              this.user.username=value
            })
          TextInput({placeholder:'请输入密码'})
            .type(InputType.Password)
            .onChange((value:string)=>{
              this.user.password=value
            })
        }
      }
      .width('90%')
      .padding({top:30})

      //登陆按钮
      Row(){
        Button('登陆')
          .onClick(() => {
            Login(this.user)
              .then(LoginResult =>{
                if(LoginResult){
                  this.loadtofirst=1
                  console.log('Login successful, navigating to FirstPage'); // 添加日志输出
                  router.pushUrl({
                    url:'pages/FirstPage',
                    // params:{flag:1}//标记为该用户已登录
                  })
                }
              })
            if(this.loadtofirst==0){
              console.log('Login failed, showing AlertDialog'); // 添加日志输出
              AlertDialog.show({
                title:'错误',
                message:'账户与密码不匹配或账户不存在',
                autoCancel:false,
                primaryButton:{
                  value:'确认',
                  action:()=>{}
                }
              })
            }

        })
          .width(150)
          .padding(15)
      }
      .padding({top:30})

      Row(){
        //勾选组件

        Text('我已同意并阅读')
          .fontSize(12)
          .onClick(()=>{
            //勾选前面的√组件,目前测试
            console.log('click succeed')
          })
        Text('《用户协议》与《隐私政策》')
          .fontSize(12)
          .fontColor('#36D')
          .onClick(()=>{
            //跳转协议与政策文件界面
            console.log('connect')
          })
      }
      .padding({top:10})
      .height(40)

      Row(){
        Text('忘记密码?')
          .onClick(()=>{
            router.pushUrl({
              url:'pages/RetrievePage'
            })
          })
      }
      .height(160)
      //.backgroundColor(Color.Green)


      Row(){
        Text('没有账号？')
        Text('注册')
          .fontColor('#36D')
          .onClick(() => {
            router.pushUrl({
              url:'pages/RegisterPage'
            })
          })
      }
      .height(75)
      .alignItems(VerticalAlign.Bottom)
      //.backgroundColor(Color.Red)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}


