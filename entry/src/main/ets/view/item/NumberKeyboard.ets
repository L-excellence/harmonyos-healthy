import { CommonConstants } from '../../common/constants/CommonConstants';
@Component
export default struct NumberKeyboard {
  numbers: string[] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."];
  @Link amount: number
  @Link value: string

  @Styles keyBoxStyle() {
    .backgroundColor(Color.White)
    .height(60)
    .borderRadius(8)
  }

  build() {
    Grid() {
      ForEach(this.numbers, num => {
        GridItem() {
          Text(num).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
        }
        .keyBoxStyle()
        .onClick(() => this.clickNumber(num))
      })
      GridItem() {
        Text("删除").fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_900)
          .onClick(() => this.clickDelete())
      }
      .keyBoxStyle()
    }
    .width("100%")
    .height(280)
    .backgroundColor($r("app.color.index_page_background"))
    .columnsTemplate("1fr 1fr 1fr")
    .columnsGap(8)
    .rowsGap(8)
    .padding(8)
    .margin({ top: 10 })
  }

  clickNumber(num: string) {
    // 1. 拼接用户输入内容
    let val = this.value + num;
    // 2. 校验输入格式是否正确
    let firstIndex = val.indexOf(".")
    let lastIndex = val.lastIndexOf(".")
    // 出现多个小数点 || 小数点位数超过 1 位
    if (firstIndex !== lastIndex || (lastIndex !== -1 && lastIndex < val.length - 2)) {
      // 非法输入
      return
    }
    // 3. 将字符串转为数值
    let amount = this.parserFloat(val)
    // 4. 保存
    if (amount >= 999.9) {
      this.amount = 999.9
      this.value = "999"
    } else {
      this.amount = amount;
      this.value = val;
    }
  }

  clickDelete() {
    if (this.value.length <= 0) {
      this.value = ""
      this.amount = 0
      return;
    }
    this.value = this.value.substring(0, this.value.length - 1)
    this.amount = this.parserFloat(this.value)
  }

  parserFloat(str: string) {
    if (!str) return 0
    if (str.endsWith(".")) {
      str = str.substring(0, str.length - 1)
    }
    return parseFloat(str)
  }
}