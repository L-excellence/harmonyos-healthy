import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct CalorieStats {
  @Prop intake: number // 摄入值
  @Prop expend: number // 消耗值
  recommend: number = CommonConstants.RECOMMEND_CALORIE; // 推荐值

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 1. 饮食摄入
      this.StatsBuilder({ label: "饮食摄入", value: this.intake});
      // 2. 还可以吃
      Stack() {
        // 2.1 进度条
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(120)
          .style({ strokeWidth: CommonConstants.DEFAULT_10 })
          .color($r("app.color.primary_color"))
        this.StatsBuilder({ label: "还可以吃", value: (this.recommend - this.intake + this.expend), tips: `推荐摄入${this.recommend}`});
      }
      // 3. 运动消耗
      this.StatsBuilder({ label: "运动消耗", value: this.expend });
    }
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  // !!!通过将参数使用 对象引用方式，实现数据变化，Builder 函数执行视图更新。
  // 如果觉得这样比较麻烦，涉及状态更新，使用组件形式。
  @Builder StatsBuilder($$: { label: string, value: number, tips?: string }) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Text($$.label)
        .fontColor($r("app.color.gray"))
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
      Text($$.value.toFixed(0))
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      if ($$.tips) {
        Text($$.tips)
          .fontSize(12)
          .fontColor($r("app.color.light_gray"))
      }
    }
  }
}