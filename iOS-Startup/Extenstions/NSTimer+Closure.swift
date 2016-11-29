import Foundation

public typealias TimerExcuteClosure = @convention(block) () -> ()

extension Timer {
    private class TimerActionBlockWrapper : NSObject {
        var block : TimerExcuteClosure
        init(block: @escaping TimerExcuteClosure) {
            self.block = block
        }
    }

    public class func YQ_scheduledTimerWithTimeInterval(_ ti:TimeInterval, closure: @escaping TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer {
        return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.excuteTimerClosure(_:)), userInfo: TimerActionBlockWrapper(block: closure), repeats: true)
    }
    
    @objc private class func excuteTimerClosure(_ timer: Timer) {
        if let action = timer.userInfo as? TimerActionBlockWrapper {
            action.block()
        }
    }
}
