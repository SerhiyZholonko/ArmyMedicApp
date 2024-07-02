//
//  SearchViewController.swift
//  Dehealth
//
//  Created by apple on 06.02.2024.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
	func closeDidTouch()
}

class SearchViewController: UIViewController {
	//MARK: - Properties
    private var viewModel: SearchViewControllerViewModelPro!
	weak var delegate: SearchViewControllerProtocol?
	private lazy var rotatingCircleView: RotatingCircleView = {
		let view = RotatingCircleView()
		view.delegate = self
		return view
	}()
	private let rotatingCircleViewBG: UIView = {
		let view = UIView()
		view.alpha = 0
		view.backgroundColor = "#F4F4F7".hexColor().withAlphaComponent(0.7)
		return view
	}()
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		return collectionView
	}()
    private var searchEmptyView: SearchEmpryCartView = {
        let view = SearchEmpryCartView()
        view.setWidth(358)
        view.setHeight(60)
        view.alpha = 0
        return view
    }()
	private lazy var closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Закрити", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .interMedium(size: 14)
		button.addTarget(self, action: #selector(closeButtonDidTouch), for: .touchUpInside)
		return button
	}()
	private let searchTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Введіть ID пораненого"
		label.font = .interLight(size: 14)
		return label
	}()
	 lazy var searchTextField: UITextField = {
		let tf = UITextField()
		tf.backgroundColor = .white
         tf.tintColor = .black
        tf.font = .interBold(size: 24) // Set the font to bold
        tf.delegate = self
		// Add placeholder text
		tf.placeholder = "Введіть ID пораненого"
		let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 20))

		leftViewContainer.backgroundColor = .clear

		// Create an image view for the left view
		let leftImageView = UIImageView(image: UIImage(named: "search"))
		leftImageView.contentMode = .center
		leftImageView.frame = CGRect(x: 8, y: 0, width: 24, height: 24) // Adjust the padding as needed

		// Add the left image view to the container view
		leftViewContainer.addSubview(leftImageView)

		// Set the left view of the text field to the container view
		tf.leftView = leftViewContainer
		tf.leftViewMode = .always // Ensure the left view is always visible

		// Create a container view to hold the image view and padding for the right view
		let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 20)) // Adjust the width as needed for padding
		rightViewContainer.backgroundColor = .clear

		// Create an image view for the right view
		let rightImageView = UIImageView(image: UIImage(named: "xmark"))
		rightImageView.contentMode = .center
		rightImageView.frame = CGRect(x: 8, y: 0, width: 24, height: 24) // Adjust the padding as needed

		// Add the right image view to the container view
		rightViewContainer.addSubview(rightImageView)

		// Add tap gesture recognizer to clear the text field when tapping on the right image view
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clearTextField))
		rightViewContainer.addGestureRecognizer(tapGesture)

		// Set the right view of the text field to the container view
		tf.rightView = rightViewContainer
		tf.rightViewMode = .always // Ensure the right view is always visible

		tf.layer.cornerRadius = 6
		tf.layer.borderWidth = 1
		tf.layer.borderColor = "#EBEDF5".hexColor().cgColor
		tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)

		return tf
	}()
    private let createDefenderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Створити картку", for: .normal)
        button.backgroundColor = "#5E42EC".hexColor()
        button.layer.cornerRadius = 8
        button.setWidth(358)
        button.setHeight(48)
        button.tintColor = .white
        return button
    }()
	@objc
    private func clearTextField() {
		searchTextField.text = "" // Clear the text field
        searchTextField.font =  .interMedium(size: 16)


	}
    init(viewModel: SearchViewControllerViewModelPro!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Livecycle
   
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureTextField()
		setupTapGesture()
		configureCollectionView()
	}
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            searchTextField.becomeFirstResponder() 
        }
	//MARK: - Functions
	private func configureUI() {
        view.backgroundColor = .black150
        view.addSubview(searchEmptyView)
		view.addSubview(closeButton)
		view.addSubview(searchTitleLabel)
		view.addSubview(searchTextField)
        view.addSubview(createDefenderButton)
		
		closeButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 12, paddingRight: 16)
		searchTitleLabel.anchor( left: view.leftAnchor, paddingLeft: 16)
		searchTitleLabel.centerY(inView: closeButton)
		searchTextField.anchor(top: searchTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 48)
		view.addSubview(collectionView)
		view.addSubview(rotatingCircleViewBG)
		view.addSubview(rotatingCircleView)
		collectionView.anchor(top: searchTextField.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 20)
		rotatingCircleView.center(inView: collectionView, yConstant: -100)
		rotatingCircleViewBG.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor, bottom: collectionView.bottomAnchor, right: collectionView.rightAnchor)
        
        searchEmptyView.center(inView: view)
        
        createDefenderButton.centerX(inView: view)
        createDefenderButton.anchor(bottom: view.bottomAnchor, paddingBottom: 20)
        
        // Observe keyboard notifications
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
	}
	private func configureTextField() {
		searchTextField.rightView?.isHidden = searchTextField.text?.isEmpty ?? true
		searchTextField.delegate = self
	}
	private func setupTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tapGesture)
	}
	private func configureCollectionView() {
		collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
		collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
		collectionView.dataSource = self
		collectionView.delegate = self
	}
    private func updateTheDefenders() {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        viewModel.defenders = []
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            collectionView.reloadData()
        }
    }
    private func applyMask(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = "XXX XX XX"
        
        for char in mask {
            if index >= cleanedText.endIndex {
                break
            }
            if char == "X" {
                result.append(cleanedText[index])
                index = cleanedText.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    private func removeSpaces(from text: String) -> String {
        return text.replacingOccurrences(of: " ", with: "")
    }
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CollectionHeaderView
            headerView.titleLabel.text = viewModel.defenders.isEmpty ? "" : "Результат"
			// Customize headerView further if needed
			return headerView
		}
		fatalError("Unexpected kind")
	}
	@objc
	private func handleTap() {
		view.endEditing(true)
        searchTextField.font =  .interMedium(size: 16)

	}

	@objc 
	private func closeButtonDidTouch() {
		delegate?.closeDidTouch()
        updateTheDefenders()
        handleTap()
        rotatingCircleView.stopAnimating()
	}
    @objc 
    func textChanged(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        textField.font = .interBold(size: 24)

        if let text = textField.text {
               textField.text = applyMask(to: text)
           }
        rotatingCircleView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now()+1)  { [weak self] in

                self?.updateDefender(with: text)
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
              UIView.animate(withDuration: 0.3) {
                  self.createDefenderButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 20)
                  self.searchEmptyView.transform = CGAffineTransform(translationX: 0, y: -150)
              }
          }
      }
      
      @objc func keyboardWillHide(notification: NSNotification) {
          UIView.animate(withDuration: 0.3) {
              self.createDefenderButton.transform = .identity
              self.searchEmptyView.transform = .identity
          }
      }
      
      deinit {
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }

}



 //MARK: - CollectionView

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let text = searchTextField.text {
            searchEmptyView.alpha = text.count > 0 && viewModel.defenders.isEmpty ? 1 : 0
        }
        return viewModel.defenders.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.configureCell(viewModel: viewModel.defenders[indexPath.item])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.frame.width, height: 56)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as needed
	}
    
   

}


 //MARK: - delegate textfield

extension SearchViewController: UITextFieldDelegate {
 

    // Asynchronous function to fetch defender
    func updateDefender(with searchText: String) {
        if searchText == "" {
            //Clear collection if array is empty
            viewModel.defenders = []
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.rotatingCircleView.stopAnimating()

            }
            return
        } else {
            viewModel.fetchDefender(with: removeSpaces(from: searchText)) {[weak self]_ in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.rotatingCircleView.stopAnimating()

                    self.collectionView.reloadData()
                }
            }

        }
       
    }


	// MARK: - UITextFieldDelegate
	func textFieldDidChangeSelection(_ textField: UITextField) {
		textField.rightView?.isHidden = textField.text?.isEmpty ?? true
	}
}

extension SearchViewController: RotatingCircleViewDelegate {
	func startAction() {
        DispatchQueue.main.async { [weak self] in
            self?.rotatingCircleViewBG.alpha = 1
        }
	}
	
	func stopAction() {
        DispatchQueue.main.async { [weak self] in
            self?.rotatingCircleViewBG.alpha = 0
        }
	}
	
	
}


//MARK: - hide placeholder
extension SearchViewController {
    // UITextFieldDelegate method called when the text field begins editing
      func textFieldDidBeginEditing(_ textField: UITextField) {
          textField.placeholder = nil // Hide the placeholder text when editing begins
      }
      
      // UITextFieldDelegate method called when the text field ends editing
      func textFieldDidEndEditing(_ textField: UITextField) {
          if textField.text?.isEmpty ?? true {
              textField.placeholder = "Введіть ID пораненого" // Show the placeholder text if the text field is empty
          }
      }
}
