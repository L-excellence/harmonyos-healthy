declare interface BreakpointTypeOptions<T>{
  sm?:T,
  md?:T,
  lg?:T
}

// 推荐的 优雅使用 Media 方式。
export default class BreakpointType<T>{
  options: BreakpointTypeOptions<T>

  constructor(options: BreakpointTypeOptions<T>) {
    this.options = options
  }

  getValue(breakpoint: string): T{
    return this.options[breakpoint]
  }
}