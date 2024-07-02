//
//  AssistanceProvidedControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 19.06.2024.
//

import Foundation

protocol AssistanceProvidedControllerViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

class AssistanceProvidedControllerViewModel {
    weak var delegate: AssistanceProvidedControllerViewModelDelegate?
    var medicineHeight: CGFloat {
        return CGFloat(medicines.count * 75)
    }
    var medicineCount: Int {
        medicines.count
    }
    var bloodLossControlString = ""
    var briefingControlString = ""
    var otherWorkString = ""
    var noteControlString = "У пораненого відкритий перелом лівої нижньої гомілкової кістки. Надали відповідну допомогу. Забинтували і зафіксували кінцівку. Треба везти обережно в лежачому положенні."
//    {
//        didSet {
//            delegate?.reloadCollectionView()
//        }
//    }
    
    
    var medicines: [Medicine] = [
//        Medicine(madeAt: "2024-06-28T05:39:59.802Z", createAt: "2024-06-28T05:39:59.802Z", name: "Aspirin", amount: 10, method: 1, customMethod: "Oral", measureType: 1, customMeasure: "mg"),
//        Medicine(madeAt: "2024-06-28T05:39:59.802Z", createAt: "2024-06-28T05:39:59.802Z", name: "Ibuprofen", amount: 20, method: 1, customMethod: "Oral", measureType: 1, customMeasure: "mg"),
//        Medicine(madeAt: "2024-06-28T05:39:59.802Z", createAt: "2024-06-28T05:39:59.802Z", name: "Paracetamol", amount: 15, method: 1, customMethod: "Oral", measureType: 1, customMeasure: "mg"),
//        Medicine(madeAt: "2024-06-28T05:39:59.802Z", createAt: "2024-06-28T05:39:59.802Z", name: "Amoxicillin", amount: 5, method: 1, customMethod: "Oral", measureType: 1, customMeasure: "mg"),
//        Medicine(madeAt: "2024-06-28T05:39:59.802Z", createAt: "2024-06-28T05:39:59.802Z", name: "Metformin", amount: 30, method: 1, customMethod: "Oral", measureType: 1, customMeasure: "mg")
    ]
    func addNewMedicine(_ medicine: Medicine) {
        self.medicines.append(medicine)
    }
    func getMedicine(by indexPath: IndexPath) -> Medicine? {
        return medicines[indexPath.row]
    }
    
}
