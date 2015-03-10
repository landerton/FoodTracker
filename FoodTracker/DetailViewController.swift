//
//  DetailViewController.swift
//  FoodTracker
//
//  Created by Landon Anderton on 3/9/15.
//  Copyright (c) 2015 Landon Anderton. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var usdaItem:USDAItem?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "usdaItemDidComplete:", name: kUSDAItemCompleted, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestAuthorizationForHealthStore()

        if self.usdaItem != nil {
            textView.attributedText = self.createAttributedString(self.usdaItem!)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func usdaItemDidComplete(notification: NSNotification) {
        println("usdaItemDidComplete in DetailViewController")
        self.usdaItem = notification.object as? USDAItem
        
        if self.isViewLoaded() && self.view.window != nil {
            self.textView.attributedText = self.createAttributedString(self.usdaItem!)
        }
    }
    
    @IBAction func eatItButtonPressed(sender: UIBarButtonItem) {
        self.saveFoodItem(self.usdaItem!)
    }
    
    func createAttributedString (usdaItem: USDAItem!) -> NSAttributedString {
        var itemAttributedString = NSMutableAttributedString()
        
        var centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = NSTextAlignment.Center
        centeredParagraphStyle.lineSpacing = 10.0
        
        var titleAttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(22.0),
            NSParagraphStyleAttributeName: centeredParagraphStyle
        ]
        
        let titleString = NSAttributedString(string: "\(usdaItem.name)\n", attributes: titleAttributesDictionary)
        itemAttributedString.appendAttributedString(titleString)
        
        var leftAllignParagraphStyle = NSMutableParagraphStyle()
        leftAllignParagraphStyle.alignment = NSTextAlignment.Left
        leftAllignParagraphStyle.lineSpacing = 20.0
        
        var styleFirstWordAttributesDictionary = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(18.0),
            NSParagraphStyleAttributeName: leftAllignParagraphStyle
        ]
        
        var style1AttributesDictionary = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(18.0),
            NSParagraphStyleAttributeName: leftAllignParagraphStyle
        ]
        
        var style2AttributesDictionary = [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(18.0),
            NSParagraphStyleAttributeName: leftAllignParagraphStyle
        ]
        
        // Calcium
        let calciumTitle = NSAttributedString(string: "Calcium ", attributes: styleFirstWordAttributesDictionary)
        let calciumBody = NSAttributedString(string: "\(usdaItem.calcium)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.appendAttributedString(calciumTitle)
        itemAttributedString.appendAttributedString(calciumBody)
        
        // Carbohydrate
        let carbTitle = NSAttributedString(string: "Carbohydrate ", attributes: styleFirstWordAttributesDictionary)
        let carbBody = NSAttributedString(string: "\(usdaItem.carbohydrate)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.appendAttributedString(carbTitle)
        itemAttributedString.appendAttributedString(carbBody)
        
        // Cholesterol
        let cholesterolTitleString = NSAttributedString(string: "Cholesterol ", attributes: styleFirstWordAttributesDictionary)
        let cholesterolBodyString = NSAttributedString(string: "\(usdaItem.cholesterol)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.appendAttributedString(cholesterolTitleString)
        itemAttributedString.appendAttributedString(cholesterolBodyString)
        
        // Energy
        let energyTitleString = NSAttributedString(string: "Energy ", attributes: styleFirstWordAttributesDictionary)
        let energyBodyString = NSAttributedString(string: "\(usdaItem.energy)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.appendAttributedString(energyTitleString)
        itemAttributedString.appendAttributedString(energyBodyString)
        
        // Fat Total
        let fatTotalTitleString = NSAttributedString(string: "FatTotal ", attributes: styleFirstWordAttributesDictionary)
        let fatTotalBodyString = NSAttributedString(string: "\(usdaItem.fatTotal)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.appendAttributedString(fatTotalTitleString)
        itemAttributedString.appendAttributedString(fatTotalBodyString)
        
        // Protein
        let proteinTitleString = NSAttributedString(string: "Protein ", attributes: styleFirstWordAttributesDictionary)
        let proteinBodyString = NSAttributedString(string: "\(usdaItem.protein)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.appendAttributedString(proteinTitleString)
        itemAttributedString.appendAttributedString(proteinBodyString)
        
        // Sugar
        let sugarTitleString = NSAttributedString(string: "Sugar ", attributes: styleFirstWordAttributesDictionary)
        let sugarBodyString = NSAttributedString(string: "\(usdaItem.sugar)% \n", attributes: style1AttributesDictionary)
        itemAttributedString.appendAttributedString(sugarTitleString)
        itemAttributedString.appendAttributedString(sugarBodyString)
        
        // Vitamin C
        let vitaminCTitleString = NSAttributedString(string: "Vitamin C ", attributes: styleFirstWordAttributesDictionary)
        let vitaminCBodyString = NSAttributedString(string: "\(usdaItem.vitaminC)% \n", attributes: style2AttributesDictionary)
        itemAttributedString.appendAttributedString(vitaminCTitleString)
        itemAttributedString.appendAttributedString(vitaminCBodyString)
        
        return itemAttributedString
    }
    
    func requestAuthorizationForHealthStore() {
        let dataTypesToWrite = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        let dataTypesToRead = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        var store:HealthStoreConstant = HealthStoreConstant()
        store.healthStore?.requestAuthorizationToShareTypes(NSSet(array: dataTypesToWrite), readTypes: NSSet(array: dataTypesToRead), completion: { (success, error) -> Void in
            if success {
                println("User completed authorization request.")
            }
            else {
                println("User canceled the request \(error)")
            }
        })
    }
    
    func saveFoodItem(foodItem: USDAItem) {
        if HKHealthStore.isHealthDataAvailable() {
            let timeFoodWasEntered = NSDate()
            let foodMetaData = [
                HKMetadataKeyFoodType: foodItem.name,
                "HKBrandName": "USDAItem",
                "HKFoodTypeID": foodItem.idValue
            ]
            
            let energyUnit = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: (foodItem.energy as NSString).doubleValue)
            let calories = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed), quantity: energyUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let calciumUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.calcium as NSString).doubleValue)
            let calcium = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium), quantity: calciumUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let carbohydrateUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.carbohydrate as NSString).doubleValue)
            let carbohydrates = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates), quantity: carbohydrateUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let fatTotalUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.fatTotal as NSString).doubleValue)
            let fatTotal = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal), quantity: fatTotalUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let proteinUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.protein as NSString).doubleValue)
            let protein = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein), quantity: proteinUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let sugarUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.sugar as NSString).doubleValue)
            let sugar = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar), quantity: sugarUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let vitaminCUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.vitaminC as NSString).doubleValue)
            let vitaminC = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC), quantity: vitaminCUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let cholesterolUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.cholesterol as NSString).doubleValue)
            let cholesterol = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol), quantity: cholesterolUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let foodDataSet = NSSet(array: [calories, calcium, carbohydrates, fatTotal, protein, sugar, vitaminC])
            let foodCoorelation = HKCorrelation(type: HKCorrelationType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood), startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, objects: foodDataSet, metadata: foodMetaData)
            
            var store:HealthStoreConstant = HealthStoreConstant()
            store.healthStore?.saveObject(foodCoorelation, withCompletion: { (success, error) -> Void in
                if success {
                    println("Saved successfully")
                }
                else {
                    println("Error Occured: \(error)")
                }
            })
        }
    }
}
