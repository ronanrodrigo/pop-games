import UIKit

class LoadingView: NibLoadableView {

    func stopLoading() {
        update(alpha: CGFloat.Alpha.hiding) { [unowned self] in
            self.isHidden = true
        }
    }

    func startLoading() {
        update(alpha: CGFloat.Alpha.showing) { [unowned self] in
            self.isHidden = false
        }
    }

    private func update(alpha: CGFloat, completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: TimeInterval.animationSpeed, animations: { [unowned self] in
            self.alpha = CGFloat(alpha)
        }) { completed in
            guard completed else { return }
            completion()
        }
    }

}
