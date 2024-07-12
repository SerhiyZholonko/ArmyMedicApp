//
//  AddTourniquetView.swift
//  Dehealth
//
//  Created by apple on 05.07.2024.
//

import UIKit

protocol AddTourniquetViewDelegate: AnyObject {
    func closeBottonDidTap()
    func saveTourniquet(_ tourniquet:Tourniquet)
}

class AddTourniquetView: UIView {
    //MARK: - Properties
    weak var delegate: AddTourniquetViewDelegate?
    private var viewModel = AddTourniquetViewViewModel()
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Турнікет"
        label.font = .interMedium(size: 20)
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black600
        button.addTarget(self, action: #selector(closeBottonDidTap), for: .touchUpInside)
        return button
    }()
    private lazy var localBodyPlaceControl: UISegmentedControl = {
        let items = BodyPlace.allCases.map { $0.title }
        let sc = UISegmentedControl(items: items)

        // Background color for the entire control
        sc.backgroundColor = UIColor(white: 0.95, alpha: 1)

        // Selected segment background color
        sc.selectedSegmentTintColor = UIColor(white: 0.85, alpha: 1)
        
        // Text attributes for normal state
        let normalFont = UIFont.interMedium(size: 10) // Change the size as needed
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.black
        ]
        sc.setTitleTextAttributes(normalTextAttributes, for: .normal)

        // Text attributes for selected state
        let selectedFont = UIFont.interMedium(size: 10) // Change the size as needed
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: selectedFont,
            .foregroundColor: UIColor.black
        ]
        sc.setTitleTextAttributes(selectedTextAttributes, for: .selected)

        // Make the first segment selected by default
        sc.selectedSegmentIndex = 0

        // Add target for value change
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        // Additional customization to match the design
        sc.layer.borderWidth = 1
        sc.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        sc.layer.cornerRadius = 5
        sc.clipsToBounds = true
        
        if #available(iOS 13.0, *) {
            let unselectedBackground = UIImage(color: UIColor(white: 1, alpha: 1))
            let selectedBackground = UIImage(color: UIColor(white: 0.85, alpha: 1))
            
            sc.setBackgroundImage(unselectedBackground, for: .normal, barMetrics: .default)
            sc.setBackgroundImage(selectedBackground, for: .selected, barMetrics: .default)
            sc.setDividerImage(UIImage(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        }
        
        return sc
    }()

    private lazy var placeOfOverlapView: PlaceOfOverlapView = {
       let view = PlaceOfOverlapView()
        view.delegate = self
        return view
    }()
    private lazy var typeOfTurnstileView: TypeOfTurnstileView = {
       let view = TypeOfTurnstileView()
        view.delegate = self
        return view
    }()

    private let typeOfTurnstileTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.layer.cornerRadius = 12
        tv.alpha = 0
        return tv
    }()
    private lazy var typeOfTrainingView: TypeOfTrainingView = {
       let view = TypeOfTrainingView()
        view.delegate = self
        return view
    }()
    private lazy var specifyTheExactLocationView: SpecifyTheExactLocationView = {
        let view = SpecifyTheExactLocationView()
        view.alpha = 0
        view.delegate = self
        return view
    }()
    private let bigSpecifyTheExactLocationView: BigSpecifyTheExactLocationView = {
       let view = BigSpecifyTheExactLocationView()
        view.alpha = 0
        return view
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Додати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interMedium(size: 16)
        button.backgroundColor = .purple600
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
        addGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configureUI() {
        backgroundColor = .black700?.withAlphaComponent(0.7)
        addSubview(bgView)
        bgView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16,  height: 592)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 16, paddingLeft: 16, height: 32)
        addSubview(closeButton)
        closeButton.anchor(width: 24, height: 24)
        closeButton.centerY(inView: titleLabel, rightAnchor: bgView.rightAnchor, paddingRight: 16)
        addSubview(localBodyPlaceControl)
        localBodyPlaceControl.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, right: bgView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20, height: 40)
        addSubview(placeOfOverlapView)
        placeOfOverlapView.anchor(top: localBodyPlaceControl.bottomAnchor, left: localBodyPlaceControl.leftAnchor, right: localBodyPlaceControl.rightAnchor, paddingTop: 24, height: 136)
        //
        addSubview(typeOfTrainingView)
        typeOfTrainingView.anchor(top: placeOfOverlapView.bottomAnchor, left: placeOfOverlapView.leftAnchor, right: placeOfOverlapView.rightAnchor, paddingTop: 24, height: 92)
        
        addSubview(typeOfTurnstileView)
        typeOfTurnstileView.anchor(top: typeOfTrainingView.bottomAnchor, left: typeOfTrainingView.leftAnchor, right: typeOfTrainingView.rightAnchor, paddingTop: 24, height: 76)
   
        
        addSubview(addButton)
        addButton.anchor(width: 318, height: 48)
        addButton.centerX(inView: self, topAnchor: typeOfTrainingView.bottomAnchor, paddingTop: 140)
        
        addSubview(specifyTheExactLocationView)
        specifyTheExactLocationView.anchor(top: typeOfTurnstileView.topAnchor, left: typeOfTurnstileView.leftAnchor, bottom: addButton.topAnchor, right: typeOfTurnstileView.rightAnchor, paddingBottom: 16)
        addSubview(typeOfTurnstileTableView)
        typeOfTurnstileTableView.anchor(top: typeOfTurnstileView.bottomAnchor, left: typeOfTurnstileView.leftAnchor, bottom: bottomAnchor, right: typeOfTurnstileView.rightAnchor,  paddingBottom: 9)
        
        addSubview(bigSpecifyTheExactLocationView)
        bigSpecifyTheExactLocationView.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, bottom: typeOfTurnstileView.topAnchor, right: bgView.rightAnchor, paddingBottom: 24)
    }
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    @objc
    private func addButtonDidTap() {
        guard let turnstile = viewModel.getTurnstileForSave() else { return }
        delegate?.saveTourniquet(turnstile)
    }
    
    @objc
    private func dismissKeyboard() {
        endEditing(true)
    }
    
    @objc
    private func closeBottonDidTap() {
        delegate?.closeBottonDidTap()
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bigSpecifyTheExactLocationView.alpha = 0
            self?.specifyTheExactLocationView.alpha = 0
        }
    }
    
    @objc
    private func segmentChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = BodyPlace(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        switch selectedSegment {
        case .limbs:
            viewModel.state = 0
        case .knotty:
            viewModel.state = 1
        case .abdominal:
            viewModel.state = 2
        }
    }
}

extension AddTourniquetView: PlaceOfOverlapViewDelegate {
    func getTitleOfSelect(_ title: Int) {
        viewModel.limb = title
    }
}
//TODO: - show or hide table view, typeOfTurnstileTableView
extension AddTourniquetView: TypeOfTurnstileViewDelegate {
    func getTypeOfTurnstile() {
        viewModel.isTypeOfTurnstile.toggle()
        typeOfTurnstileTableView.alpha = viewModel.isTypeOfTurnstile ? 1 : 0
    }
}

extension AddTourniquetView: TypeOfTrainingViewDelegate {
    func getTime(_ time: String) {
        viewModel.time = time
    }
    
    func setMethod(_ method: PikerStage) {
        switch method {
        case .pikedOne:
            viewModel.overlayTypeTurnstile = "Швидкий"
            viewModel.method = 0
            specifyTheExactLocationView.alpha = 0
        case .pikedTwo:
            viewModel.overlayTypeTurnstile = "Прицільний"
            viewModel.method = 1
            specifyTheExactLocationView.alpha = 1
        }
    }
}
extension AddTourniquetView: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView() {
        typeOfTurnstileTableView.delegate = self
        typeOfTurnstileTableView.dataSource = self
        typeOfTurnstileTableView.register(TypeOfTrainingViewCell.self, forCellReuseIdentifier: TypeOfTrainingViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.typeOfTurnstileList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfTrainingViewCell.identifier, for: indexPath) as! TypeOfTrainingViewCell
        let typeOfTurnstileString = viewModel.typeOfTurnstileList[indexPath.row]
        cell.setTitle(typeOfTurnstileString)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let typeOfTurnstileString = viewModel.typeOfTurnstileList[indexPath.row]
        viewModel.getIndex(indexPath)
        typeOfTurnstileView.setTitle(typeOfTurnstileString)
        getTypeOfTurnstile()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}


extension AddTourniquetView: SpecifyTheExactLocationViewDelegate {
    func changeToBig() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bigSpecifyTheExactLocationView.alpha = 1
            self?.specifyTheExactLocationView.alpha = 0
            self?.typeOfTrainingView.selectFirstButton()

        }
      
    }
}


//extension UIImage {
//    static func imageWithColor(color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage {
//        let rect = CGRect(origin: .zero, size: size)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        let context = UIGraphicsGetCurrentContext()!
//        context.setFillColor(color.cgColor)
//        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
//        context.addPath(path.cgPath)
//        context.fillPath()
//        let image = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//}


extension UIImage {
    convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: img!.cgImage!)
    }
    
    func withRoundedCorners(radius: CGFloat) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context?.closePath()
        context?.clip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
}
