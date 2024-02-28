import { CommonConstants } from '../../common/constants/CommonConstants'

@Extend(Text) function grayText() {
  .fontSize(14)
  .fontColor($r("app.color.light_gray"))
}

@Component
export default struct RecordList {
  build() {
    List({ space: CommonConstants.SPACE_10}) {
      ForEach([1, 2, 3, 4, 5], (item) => {
        ListItem() {
          Column() {
            // 1. 分组的标题
            Row({ space: CommonConstants.SPACE_4 }) {
              Image($r("app.media.ic_breakfast")).width(24)
              Text("早餐")
                .fontSize(18)
                .fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text("建议423~592千卡").grayText()
              Blank()
              Text("190").fontSize(14).fontColor($r("app.color.primary_color"))
              Text("千卡").grayText()
              Image($r("app.media.ic_public_add_norm_filled"))
                .width(20)
                .fillColor($r("app.color.primary_color"))
            }
            .width("100%")

            // 2. 组内记录列表
            List() {
              ForEach([1, 2], (item) => {
                ListItem() {
                  Row({ space: CommonConstants.SPACE_6 }) {
                    Image($r("app.media.toast")).width(50)
                    Column({ space: CommonConstants.SPACE_4 }) {
                      Text("全麦吐司").fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text("1 片").grayText()
                    }
                    Blank()
                    Text("91千卡").grayText()
                  }
                  .width("100%")
                  .padding(CommonConstants.SPACE_6)
                }.swipeAction({ end: this.deleteButton.bind(this) })
              })
            }
            .width("100%")
          }
          .width("100%")
          .backgroundColor(Color.White)
          .borderRadius(CommonConstants.DEFAULT_18)
          .padding(CommonConstants.SPACE_12)
        }
      })
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height("100%")
    .margin({ top: 10 })
  }

  @Builder deleteButton() {
    Image($r("app.media.ic_public_delete_filled"))
      .width(20)
      .fillColor(Color.Red)
      .margin(5)
  }
}