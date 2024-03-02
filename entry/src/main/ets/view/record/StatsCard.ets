import BreakpointType from '../../common/bean/BreanpointType';
import BreakpointConstants from '../../common/constants/BreakpointConstants';
import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil';
import RecordService from '../../service/RecordService';
import RecordVO from '../../viewmodel/RecordVO';
import StatsInfo from '../../viewmodel/StatsInfo';
import CalorieStats from './CalorieStats';
import DatePickerDialog from "./DatePickDialog";
import NutrientStats from './NutrientStats';

@Component
export default struct StatsCard {
  // 读取全局变量
  @StorageProp("selectedDate") selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @StorageProp("currentBreakpoint") currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @Consume @Watch("handleRecordsChange") records: RecordVO[]
  @State info: StatsInfo = new StatsInfo()
  controler: CustomDialogController = new CustomDialogController({
    builder: DatePickerDialog({ selectedDate: new Date(this.selectedDate) })
  })

  handleRecordsChange() {
    this.info = RecordService.calculateStatsInfo(this.records)
  }

  build() {
    Column() {
      // 1. 日期信息
      Row() {
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor($r("app.color.secondary_color"))
        Image($r("app.media.ic_public_spinner"))
          .width(20)
          .fillColor($r("app.color.secondary_color"))
      }
      .padding(CommonConstants.SPACE_12)
      .onClick(() => this.controler.open())

      // 2. 统计信息
      Swiper() {
        // 2.1 热量统计
        CalorieStats({ intake: this.info.intake, expend: this.info.expend })
        // 2. 营养素统计
        NutrientStats({ carbon: this.info.carbon, protein: this.info.protein, fat: this.info.fat })
      }
      .width("100%")
      .backgroundColor(Color.White)
      .borderRadius(CommonConstants.DEFAULT_18)
      .indicatorStyle({ selectedColor: $r("app.color.primary_color")})
      .displayCount(new BreakpointType({
        sm: 1,
        md: 1,
        lg: 2
      }).getValue(this.currentBreakpoint))

      // 3. 记录列表
    }
    .width(CommonConstants.THOUSANDTH_940)
    .backgroundColor($r("app.color.stats_title_bgc"))
    .borderRadius(CommonConstants.DEFAULT_18)
  }
}