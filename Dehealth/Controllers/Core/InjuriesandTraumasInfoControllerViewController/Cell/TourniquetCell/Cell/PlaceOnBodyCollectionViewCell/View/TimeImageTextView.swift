//
//  TimeImageTextView.swift
//  Dehealth
//
//  Created by apple on 04.07.2024.
//

import UIKit

class TimeImageTextView: UIView {
    // MARK: - Properties
    private let timeImageView: UIImageView = {
        let image = UIImage(named: "clock")?.withRenderingMode(.alwaysTemplate)
        let iv = UIImageView(image: image)
        iv.alpha = 0
        return iv
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "00:01"
        label.font = .systemFont(ofSize: 16)  // Assuming .interLight(size: 16) is a custom font
        return label
    }()
    
    private var timer: Timer?
    private var startDate: Date?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Functions
    func setColor(_ color: UIColor) {
        timeImageView.tintColor = color
        timeLabel.textColor = color
    }
    
    private func configureUI() {
        addSubview(timeImageView)
        timeImageView.centerY(inView: self)
        timeImageView.anchor(left: leftAnchor, width: 14, height: 14)
        addSubview(timeLabel)
        timeLabel.anchor(left: timeImageView.rightAnchor, paddingLeft: 8, height: 24)
        centerY(inView: timeImageView)
    }
    
    private func parseDate(from dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: dateString)
    }
    
    func startTimer(with startTimeString: String) {
        guard let startDate = parseDate(from: startTimeString) else { return }
        self.startDate = startDate
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        guard let startDate = startDate else { return }
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(startDate)
        
        let elapsedHours = Int(elapsedTime) / 3600
        let elapsedMinutes = (Int(elapsedTime) % 3600) / 60
        
        // Format time as HH:mm
        let formattedTime = String(format: "%02d:%02d", elapsedHours, elapsedMinutes)
        timeLabel.text = formattedTime
        
        // Determine color based on total elapsed minutes
        let totalElapsedMinutes = elapsedHours * 60 + elapsedMinutes
        if totalElapsedMinutes < 90 {
            timeImageView.alpha = 1
            setColor(.black700!)
        } else if totalElapsedMinutes < 120 {
            timeImageView.alpha = 1
            setColor("#FF8F00".hexColor())
        } else {
            timeImageView.alpha = 1
            setColor(.red300!)
        }
    }
}

// Helper Extensions
extension UIView {
    func centerY(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func anchor(left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

