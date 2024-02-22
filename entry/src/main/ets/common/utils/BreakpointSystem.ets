import mediaQuery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants'

export default class BreakpointSystem{

  private smListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_SM)
  private mdListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_MD)
  private lgListener: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_LG)

  smListenerCallback(result: mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM)
    }
  }

  mdListenerCallback(result: mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD)
    }
  }

  lgListenerCallback(result: mediaQuery.MediaQueryResult){
    if(result.matches){
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG)
    }
  }

  updateCurrentBreakpoint(breakpoint: string){
    AppStorage.SetOrCreate(BreakpointConstants.CURRENT_BREAKPOINT, breakpoint)
  }

  register(){
    this.smListener.on('change', this.smListenerCallback.bind(this))
    this.mdListener.on('change', this.mdListenerCallback.bind(this))
    this.lgListener.on('change', this.lgListenerCallback.bind(this))
  }

  unregister(){
    this.smListener.off('change', this.smListenerCallback.bind(this))
    this.mdListener.off('change', this.mdListenerCallback.bind(this))
    this.lgListener.off('change', this.lgListenerCallback.bind(this))
  }
}