import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import PreferenceUtil from '../common/utils/PreferenceUtil';
import { CommonConstants } from '../common/constants/CommonConstants';
import DateUtil from '../common/utils/DateUtil';
import DbUtil from '../common/utils/DbUtil';
import RecordModel from '../model/RecordModel';

export default class EntryAbility extends UIAbility {
  async onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // 1.加载用户首选项
    PreferenceUtil.loadPreference(this.context)
    // 2.初始化日期
    AppStorage.SetOrCreate(CommonConstants.RECORD_DATE, DateUtil.beginTimeOfDay(new Date()))
    // 3.初始化RDB工具
    await DbUtil.initDB(this.context)
    // 4.创建record表
    DbUtil.createTable(RecordModel.getCreateTableSql())

    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 2. 默认进入 欢迎页
    windowStage.loadContent('pages/WelcomePage', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
