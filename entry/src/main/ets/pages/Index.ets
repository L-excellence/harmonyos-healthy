import { CommonConstants } from '../common/constants/CommonConstants'
import RecordIndex from '../view/record/RecordIndex'
@Entry
@Component
struct Index {
  @State currentIndex: number = 0

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

  selectColor(index: number) {
    return this.currentIndex === index ? $r("app.color.primary_color") : $r("app.color.gray");
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        RecordIndex()
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
  }
}