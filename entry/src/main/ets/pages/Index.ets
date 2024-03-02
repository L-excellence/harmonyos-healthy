import BreakpointType from '../common/bean/BreanpointType'
import BreakpointConstants from '../common/constants/BreakpointConstants'
import { CommonConstants } from '../common/constants/CommonConstants'
import BreakpointSystem from '../common/utils/BreakpointSystem'
import RecordIndex from '../view/record/RecordIndex'
@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp("currentBreakpoint") currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @State isPageShow: boolean = false;

  onPageShow() {
    this.isPageShow = true;
  }

  onPageHide() {
    this.isPageShow = false;
  }

  // 自定义 Bar 样式
  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image)
        .width(22)
        .fillColor(this.selectColor(index))
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor(index))
    }
  }

  aboutToAppear() {
    // 注册媒体查询监听事件
    this.breakpointSystem.register()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  selectColor(index: number) {
    return this.currentIndex === index ? $r("app.color.primary_color") : $r("app.color.gray");
  }

  chooseBarPosition() {
    let p = {
      sm: BarPosition.End,
      md: BarPosition.Start,
      lg: BarPosition.Start,
    }
    return p[this.currentBreakpoint];
  }

  build() {
    Tabs({ barPosition: this.chooseBarPosition() }) {
      TabContent() {
        RecordIndex({ isPageShow: this.isPageShow })
      }
      .tabBar(this.TabBarBuilder($r("app.string.tab_record"), $r("app.media.ic_calendar"), 0))

      TabContent() {
        Text("发现页面")
      }
      .tabBar(this.TabBarBuilder($r("app.string.tab_discover"), $r("app.media.discover"), 1))

      TabContent() {
        Text("我的主页")
      }
      .tabBar(this.TabBarBuilder($r("app.string.tab_user"), $r("app.media.ic_user_portrait"), 2))
    }
    .width("100%")
    .height("100%")
    .onChange(index => this.currentIndex = index)
    // 传统使用方式
    // .vertical({
    //   sm: false,
    //   md: true,
    //   lg: true,
    // }[this.currentBreakpoint])
    // Media 优雅使用方式
    .vertical(new BreakpointType({
      sm: false,
      md: true,
      lg: true,
    }).getValue(this.currentBreakpoint))
  }
}