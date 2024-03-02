import DateUtil from '../../common/utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import RecordList from './RecordList'
import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  @StorageProp("selectedDate")
  @Watch("aboutToAppear") // 监控 selectedDate 数据变化，重新执行 aboutToAppear
  selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Provide records: RecordVO[] = []
  @Prop @Watch("handlePageShow") isPageShow: boolean;

  async aboutToAppear() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  handlePageShow() {
    if (this.isPageShow) {
      this.aboutToAppear();
    }
  }

  build() {
    Column() {
      // 1. 头部搜索
      SearchHeader()
      // 2. 统计卡片
      StatsCard()
      // 3. 记录列表
      RecordList()
        .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.index_page_background"))
  }
}