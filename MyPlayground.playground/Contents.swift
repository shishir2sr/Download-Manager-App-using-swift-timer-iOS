import UIKit
var count = 0
let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
    count += 1
    print(count)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    timer.invalidate()
}
