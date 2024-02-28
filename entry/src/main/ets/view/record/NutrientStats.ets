import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export default struct NutrientStats {
  carbon: number = 23; // 碳水化合物
  protein: number = 9; // 蛋白质
  fat: number = 7; // 脂肪
  recommendCarbon: number = CommonConstants.RECOMMEND_CARBON;
  recommendProtein: number = CommonConstants.RECOMMEND_PROTEIN;
  recommendFat: number = CommonConstants.RECOMMEND_FAT;

  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      // 1. 碳水化合物
      this.StatsBuilder(
        "碳水化合物",
        this.carbon,
        this.recommendCarbon,
        $r("app.color.carbon_color")
      );
      // 2. 蛋白质
      this.StatsBuilder(
        "蛋白质",
        this.protein,
        this.recommendProtein,
        $r("app.color.protein_color")
      );
      // 3. 脂肪
      this.StatsBuilder(
        "脂肪",
        this.fat,
        this.recommendFat,
        $r("app.color.fat_color")
      );
    }
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder StatsBuilder(label: string, value: number, recommend: number, color: ResourceStr) {
    Column({ space: CommonConstants.SPACE_6 }) {
      Stack() {
        // 2.1 进度条
        Progress({
          value: value,
          total: recommend,
          type: ProgressType.Ring
        })
          .width(95)
          .style({ strokeWidth: CommonConstants.DEFAULT_6 })
          .color($r("app.color.primary_color"))
        Column({ space: CommonConstants.SPACE_6 }) {
          Text("摄入推荐")
            .fontSize(12)
            .fontColor($r("app.color.light_gray"))
          Text(`${value.toFixed(0)}/${recommend.toFixed(0)}`)
            .fontSize(18)
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
        }
      }
      Text(`${label}（克）`)
        .fontSize(12)
        .fontColor($r("app.color.light_gray"))
    }
  }
}