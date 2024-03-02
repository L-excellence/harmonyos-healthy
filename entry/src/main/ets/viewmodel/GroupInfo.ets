export default class GroupInfo<TYPE, ELEMENT> {
  /**
   * 分组类型
   */
  type: TYPE
  /**
   * 组内数据集合
   */
  items: ELEMENT[]

  /**
   * 组内记录的总热量
   */
  calorie: number = 0

  constructor(type: TYPE, items: ELEMENT[]) {
    this.type = type
    this.items = items
  }
}