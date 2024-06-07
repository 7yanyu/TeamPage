import router from '@ohos.router'
import { User } from '../entity/User'
import { Login } from '../httpRequest/Login'

@Entry
@Component
struct LoadPage {
  @State message: string = '人事E通'
  @State user:User= new User('','')
  // @State loadtofirst:number =0
  @State checked:boolean=false

  build() {
    Column({space:10}) {

      Row(){
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor('#81B337')
      }
      .width('100%')
      .padding({top:200})
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
      .padding({top:50})

      //登陆按钮
      Row(){
        Button('登陆')
          .onClick(() => {
            if(this.checked){
              Login(this.user)
                .then(LoginResult =>{
                  if(LoginResult=='登陆成功'){
                    // this.loadtofirst=1
                    console.log('Login successful, navigating to FirstPage'); // 添加日志输出
                    router.replaceUrl({
                      url:'pages/FirstPage',
                      // params:{flag:1}//标记为该用户已登录
                    })
                    }
                    else{

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
            }else{
              AlertDialog.show({
                title:'提示',
                message:'未同意《用户协议》与《隐私政策》，请阅读协议。',
                autoCancel:false,
                primaryButton:{
                  value:'确认',
                  action:()=>{}
                }
              })
            }

            // if(this.loadtofirst==0){

            // }

        })
          .width(150)
          .padding(15)
      }
      .padding({top:30})

      Row(){
        //勾选组件
        Checkbox({name:'Agree'})
          .onChange(value=>{
            this.checked=value
          })
        Text('我已同意并阅读')
          .fontSize(12)
        Text('《用户协议》与《隐私政策》')
          .fontSize(12)
          .fontColor('#36D')
          .onClick(()=>{
            router.pushUrl({
              url:'pages/protocolPage'
            })
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
      .height(140)

      //.backgroundColor(Color.Green)


      Row(){
        Text('没有账号？')
        Text('注册')
          .fontColor('white')
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
    .backgroundImage($r("app.media.LoadBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}


