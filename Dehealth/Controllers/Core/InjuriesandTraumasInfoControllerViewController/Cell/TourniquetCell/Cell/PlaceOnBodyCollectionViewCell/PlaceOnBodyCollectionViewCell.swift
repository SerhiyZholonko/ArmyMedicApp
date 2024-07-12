//
//  PlaceOnBodyCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 03.07.2024.
//

import UIKit


class PlaceOnBodyCollectionViewCell: UICollectionViewCell {
     //MARK: - Properties
    static let identifier = "PlaceOnBodyCollectionViewCell"
    private let bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .black200
        view.layer.cornerRadius = 12
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ліва рука"
        label.font = .interMedium(size: 18)
        return label
    }()
    private let editView: UIImageView = {
        let image = UIImage(named: "ellipsis")
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var editButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let turnstileTypeLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 16)
        return label
    }()
    private let subTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .interLight(size: 12)
        label.text = "CAT 7"
        return label
    }()
    private let timeView: TimeImageTextView = {
        let timeView = TimeImageTextView()
        return timeView
    }()
    private let createTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:00"
        label.font = .interLight(size: 16)
        label.setHeight(24)
        label.setWidth(48)
        return label
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func configureCell(model: Tourniquet) {
        if let limbSegment = StateSegment(rawValue: model.limb) {
            titleLabel.text = limbSegment.title
        }
        if let typeSegment = TourniquetType(rawValue: model.type) {
            subTypeLabel.text = typeSegment.title
        }
        if model.method == 0 {
            turnstileTypeLabel.text = "Швидкий"
        } else {
            turnstileTypeLabel.text = "Прицільний"
        }
        timeView.startTimer(with: model.appliedAt)
        if let createTime = formatTime(from: model.releasedAt) {
            createTimeLabel.text = createTime
        }
    }
    private func getColorBasedOnTime() -> UIColor {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: now)
        
        guard let hour = components.hour, let minute = components.minute else {
            return .red // Default color if unable to get the current time
        }
        
        let totalMinutes = (hour * 60) + minute
        let oneAndHalfHourMinutes = 90
        let twoHourMinutes = 120
        
        switch totalMinutes {
        case ..<oneAndHalfHourMinutes:
            return .black
        case oneAndHalfHourMinutes..<twoHourMinutes:
            return .yellow
        default:
            return .red
        }
    }
    private func configureUI() {
        addSubview(bgView)
        bgView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 32, paddingBottom: 4, paddingRight: 32)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingLeft: 16, width: 146, height: 48)
        addSubview(turnstileTypeLabel)
        turnstileTypeLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, height: 24)
        addSubview(subTypeLabel)
        subTypeLabel.anchor(top: turnstileTypeLabel.bottomAnchor, left: turnstileTypeLabel.leftAnchor)
        addSubview(timeView)
        timeView.anchor(top: turnstileTypeLabel.topAnchor, left: titleLabel.rightAnchor, paddingLeft: 16, width: 68, height: 24)
        addSubview(createTimeLabel)
        createTimeLabel.centerY(inView: timeView, leftAnchor: timeView.rightAnchor, paddingLeft: 16)
        addSubview(editView)
        editView.anchor(top: topAnchor, right: bgView.rightAnchor, paddingTop: 14, paddingRight: 14, width: 20, height: 20)
        addSubview(editButton)
        editButton.anchor(top: bgView.topAnchor, right: bgView.rightAnchor, width: 112, height: 24)
    }
    private func formatTime(from dateString: String) -> String? {
        // Define the input and output date formats
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let outputDateFormat = "HH:mm"

        // Create a DateFormatter for the input format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputDateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Create a DateFormatter for the output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputDateFormat

        // Convert the string to a Date object
        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }

        // Convert the Date object to the desired output string format
        let formattedTime = outputFormatter.string(from: date)
        return formattedTime
    }
    @objc
    private func editButtonDidTap() {
        print("editButtonDidTap")
    }
}
