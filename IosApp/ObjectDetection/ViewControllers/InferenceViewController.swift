

import UIKit

protocol InferenceViewControllerDelegate {

  func didChangeThreadCount(to count: Int)
}

class InferenceViewController: UIViewController {

  private enum InferenceSections: Int, CaseIterable {
    case InferenceInfo
  }

  private enum InferenceInfo: Int, CaseIterable {
    case Resolution
    case Crop
    case InferenceTime

    func displayString() -> String {

      var toReturn = ""

      switch self {
      case .Resolution:
        toReturn = "Resolution"
      case .Crop:
        toReturn = "Crop"
      case .InferenceTime:
        toReturn = "Inference Time"

      }
      return toReturn
    }
  }


  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var threadStepper: UIStepper!
  @IBOutlet weak var stepperValueLabel: UILabel!

 
  private let normalCellHeight: CGFloat = 27.0
  private let separatorCellHeight: CGFloat = 42.0
  private let bottomSpacing: CGFloat = 21.0
  private let minThreadCount = 1
  private let bottomSheetButtonDisplayHeight: CGFloat = 60.0
  private let infoTextColor = UIColor.black
  private let lightTextInfoColor = UIColor(displayP3Red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
  private let infoFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
  private let highlightedFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)

  
  var inferenceTime: Double = 0
  var wantedInputWidth: Int = 0
  var wantedInputHeight: Int = 0
  var resolution: CGSize = CGSize.zero
  var threadCountLimit: Int = 0
  var currentThreadCount: Int = 0

  var delegate: InferenceViewControllerDelegate?

  var collapsedHeight: CGFloat {
    return bottomSheetButtonDisplayHeight

  }

  override func viewDidLoad() {
    super.viewDidLoad()

    threadStepper.isUserInteractionEnabled = true
    threadStepper.maximumValue = Double(threadCountLimit)
    threadStepper.minimumValue = Double(minThreadCount)
    threadStepper.value = Double(currentThreadCount)

  }


  @IBAction func onClickThreadStepper(_ sender: Any) {

    delegate?.didChangeThreadCount(to: Int(threadStepper.value))
    currentThreadCount = Int(threadStepper.value)
    stepperValueLabel.text = "\(currentThreadCount)"
  }
}


extension InferenceViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {

    return InferenceSections.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    guard let inferenceSection = InferenceSections(rawValue: section) else {
      return 0
    }

    var rowCount = 0
    switch inferenceSection {
    case .InferenceInfo:
      rowCount = InferenceInfo.allCases.count
    }
    return rowCount
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    var height: CGFloat = 0.0

    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
      return height
    }

    switch inferenceSection {
    case .InferenceInfo:
      if indexPath.row == InferenceInfo.allCases.count - 1 {
        height = separatorCellHeight + bottomSpacing
      }
      else {
        height = normalCellHeight
      }
    }
    return height
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "INFO_CELL") as! InfoCell

    guard let inferenceSection = InferenceSections(rawValue: indexPath.section) else {
      return cell
    }

    var fieldName = ""
    var info = ""

    switch inferenceSection {
    case .InferenceInfo:
      let tuple = displayStringsForInferenceInfo(atRow: indexPath.row)
      fieldName = tuple.0
      info = tuple.1

    }
    cell.fieldNameLabel.font = infoFont
    cell.fieldNameLabel.textColor = infoTextColor
    cell.fieldNameLabel.text = fieldName
    cell.infoLabel.text = info
    return cell
  }

  // MARK: Format Display of information in the bottom sheet
  /**
   This method formats the display of additional information relating to the inferences.
   */
  func displayStringsForInferenceInfo(atRow row: Int) -> (String, String) {

    var fieldName: String = ""
    var info: String = ""

    guard let inferenceInfo = InferenceInfo(rawValue: row) else {
      return (fieldName, info)
    }

    fieldName = inferenceInfo.displayString()

    switch inferenceInfo {
    case .Resolution:
      info = "\(Int(resolution.width))x\(Int(resolution.height))"
    case .Crop:
      info = "\(wantedInputWidth)x\(wantedInputHeight)"
    case .InferenceTime:

      info = String(format: "%.2fms", inferenceTime)
    }

    return(fieldName, info)
  }
}
