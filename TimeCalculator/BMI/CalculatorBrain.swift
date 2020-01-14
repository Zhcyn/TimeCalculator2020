//
//  TimeCalculator
//
//  Created by summer on 2020/1/14.
//  Copyright © 2020 Bob Development. All rights reserved.
//


import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    func getBMIValue() -> String{
    
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
            return bmiTo1DecimalPlace
    }
  mutating func calculateBMI(height: Float, weight: Float){
    let bmiValue = weight / (height * height)
    
    if bmiValue < 18.5{
        print("underweight")
        bmi = BMI(value: bmiValue, advice:"Eat more Pies", color:UIColor.blue)
    }else if bmiValue < 24.9 {
        print("normal weight")
        bmi = BMI(value: bmiValue, advice:"You Look Good" , color:UIColor.green)
    }else{
        print("overweight")
        bmi = BMI(value: bmiValue, advice:"Don't eat more pie" , color:UIColor.red)
    }
    
    
    }
    func getAdvice() -> String{
        return bmi?.advice ?? "No Advice"
    }
    func getColor() -> UIColor{
        return bmi?.color ?? UIColor.white
    }
    
    
}
