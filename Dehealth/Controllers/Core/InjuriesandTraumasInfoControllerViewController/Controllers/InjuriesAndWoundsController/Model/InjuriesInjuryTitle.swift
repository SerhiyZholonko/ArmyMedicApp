//
//  InjuriesInjuryTitle.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit


enum InjuriesInjuryTitle: String {
	case shrapnelDamage = "Осколкове"
	case bulletWound = "Кульове"
	case contusionInjury = "Контузія"
	case amputation = "Ампутція"
	case mechanical = "Механічна"
	case burn = "Опік"
	case poisoning = "Отруєння"
	
	var color: UIColor {
		   switch self {
		   case .shrapnelDamage:
			   return UIColor(named: "ShrapnelWoundColor")!
		   case .bulletWound:
			   return UIColor(named: "GunshotWoundColor")!
		   case .contusionInjury:
			   return UIColor(named: "ContusionColor")!
		   case .amputation:
			   return UIColor.black
		   case .mechanical:
			   return UIColor(named: "MechanicalColor")!
		   case .burn:
			   return UIColor(named: "BurnsColor")!
		   case .poisoning:
			   return UIColor(named: "PoisoningColor")!
		   }
	   }}

enum WeaponCausedTheInjuryTitle: String {
	case smallArms = "Стрілецька"
	case artillery = "Артилерія"
	case rocket = "Ракета"
	case fpvDrone = "Fpv-дрон"
	case tank = "Танк"
	case aviation = "Авіація"
	case grenadeLauncher = "Гранатомет"
	case mine = "Міна"
	case flamethrower = "Вогнемет"
}
