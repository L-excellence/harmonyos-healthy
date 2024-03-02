export default class RecordType{
  /**
   * 类型id
   */
  id: number
  /**
   * 类型名称
   */
  name: ResourceStr
  /**
   * 类型图标
   */
  icon: ResourceStr
  /**
   * 类型推荐最小卡路里
   */
  min: number
  /**
   * 类型推荐最大卡路里
   */
  max: number

  constructor(id: number, name: ResourceStr, icon: ResourceStr, min: number = 0, max: number = 0) {
    this.id = id
    this.name = name
    this.icon = icon
    this.min = min
    this.max = max
  }
}