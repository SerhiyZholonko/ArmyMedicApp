//
//  SetWoundingControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import Foundation

protocol SetWoundingControllerViewModelPro {
	 var typeInjuries: InjuriesInjuryTitle {get}
	 var typeWounding: WeaponCausedTheInjuryTitle {get}
}

struct SetWoundingControllerViewModel: SetWoundingControllerViewModelPro {
	var typeInjuries: InjuriesInjuryTitle
	
	var typeWounding: WeaponCausedTheInjuryTitle
	
	
	init(typeInjuries: InjuriesInjuryTitle, typeWounding: WeaponCausedTheInjuryTitle) {
		self.typeWounding = typeWounding
		self.typeInjuries = typeInjuries
	}
}
