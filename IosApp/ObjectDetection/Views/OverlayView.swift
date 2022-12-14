

import UIKit


struct ObjectOverlay {
  let name: String
  let borderRect: CGRect
  let nameStringSize: CGSize
  let color: UIColor
  let font: UIFont
}


class OverlayView: UIView {

  var objectOverlays: [ObjectOverlay] = []
  private let cornerRadius: CGFloat = 10.0
  private let stringBgAlpha: CGFloat
    = 0.7
  private let lineWidth: CGFloat = 3
  private let stringFontColor = UIColor.white
  private let stringHorizontalSpacing: CGFloat = 13.0
  private let stringVerticalSpacing: CGFloat = 7.0

  override func draw(_ rect: CGRect) {

  
    for objectOverlay in objectOverlays {

      drawBorders(of: objectOverlay)
      drawBackground(of: objectOverlay)
      drawName(of: objectOverlay)
    }
  }


  func drawBorders(of objectOverlay: ObjectOverlay) {

    let path = UIBezierPath(rect: objectOverlay.borderRect)
    path.lineWidth = lineWidth
      
      let dashPattern: [CGFloat] = [50.0,50.0]
      path.setLineDash(dashPattern, count: dashPattern.count, phase: 2)
    objectOverlay.color.setStroke()

    path.stroke()
  }


  func drawBackground(of objectOverlay: ObjectOverlay) {

    let stringBgRect = CGRect(x: objectOverlay.borderRect.origin.x, y: objectOverlay.borderRect.origin.y , width: 2 * stringHorizontalSpacing + objectOverlay.nameStringSize.width, height: 2 * stringVerticalSpacing + objectOverlay.nameStringSize.height
    )

    let stringBgPath = UIBezierPath(rect: stringBgRect)
    objectOverlay.color.withAlphaComponent(stringBgAlpha).setFill()
    stringBgPath.fill()
  }


  func drawName(of objectOverlay: ObjectOverlay) {

   
    let stringRect = CGRect(x: objectOverlay.borderRect.origin.x + stringHorizontalSpacing, y: objectOverlay.borderRect.origin.y + stringVerticalSpacing, width: objectOverlay.nameStringSize.width, height: objectOverlay.nameStringSize.height)

    let attributedString = NSAttributedString(string: objectOverlay.name, attributes: [NSAttributedString.Key.foregroundColor : stringFontColor, NSAttributedString.Key.font : objectOverlay.font])
    attributedString.draw(in: stringRect)
  }
    let gesture = UITapGestureRecognizer(target: self, action:  #selector(clickAction(sender:)))

    @objc func clickAction(sender : UITapGestureRecognizer) {
    }
}
class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}
extension UIView {
    func setOnClickListener(action :@escaping () -> Void){
           let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
           tapRecogniser.onClick = action
           self.addGestureRecognizer(tapRecogniser)
        }
        
        @objc func onViewClicked(sender: ClickListener) {
           if let onClick = sender.onClick {
           onClick()
           }
        }
}
