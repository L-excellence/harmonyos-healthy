
import common from '@ohos.app.ability.common'
import router from '@ohos.router';
import PreferenceUtil from '../common/utils/PreferenceUtil';
import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'
// 复用 CSS 样式
@Extend(Text) function opacityWhiteText(opacity: number, fontSize: number = 10) {
  .fontSize(fontSize)
  .opacity(opacity)
  .fontColor(Color.White)
}

const PREF_KEY = "userPrivacyKey-test"

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext;
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  aboutToAppear(){
    // 1. 加载首选项
    const isAgree = PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    // 2. 判断是否同意
    if (isAgree) {
      // 2.1 同意，跳转至首页
      this.jumpToIndex();
      this.controller.open();
    } else {
      // 2.2 不同意，弹窗
      this.controller.open();
    }
  }

  jumpToIndex() {
    setTimeout(() => {
      router.replaceUrl({
        url: "pages/Index"
      })
    }, 3000)
  }

  onConfirm() {
    // 1. 保存首选项
    PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    // 2. 跳转至首页
    this.jumpToIndex();
  }

  exitApp() {
    // 退出 APP
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {
      // 1. 中央 Slogan
      Row() {
        Image($r("app.media.home_slogan")).width(260)
      }
      .layoutWeight(1) // 占据剩余空间
      // 2. logo
      Image($r("app.media.home_logo")).width(150)
      // 3. 文字描述
      Row() {
        Text("黑马健康支持").opacityWhiteText(0.8, 12)
        Text("IPv6")
          .opacityWhiteText(0.8)
          .border({ style: BorderStyle.Solid, width: 1, color: Color.White, radius: 15 })
          .padding({ left: 5, right: 5 })
        Text("网络").fontSize(12).opacity(0.8).fontColor(Color.White)
      }
      Text(`'减更多'指黑马健康App希望通过软件工具的形式，帮助更多用户实现身材管理`).opacityWhiteText(0.6)
      Text('浙ICP备0000000号-36D')
        .opacityWhiteText(0.4)
        .margin({ bottom: 35 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r("app.color.welcome_page_background"))
  }
}