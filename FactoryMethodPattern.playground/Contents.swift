/*:
 
 # Definition
 
 Factory method is a creational design pattern, i.e., related to object creation. In Factory method pattern, we create object without exposing the creation logic to client and the client use the same common interface to create new type of object. Used to decouple client from the hassle of selection of type for object creation.
 
 ## Things to keep in mind
 1. We can use either a super class or a **protocol** to define some set of rules that will be used by sub classes.
 2. In sub classes conform to protocol and implement the protocol methods.
 3. An **enum** would be handy to determine which type of object is expected from factory class.
 4. We can use either static method or make the factory class **singleton** to access it's method for object creation.
 5. Finally use the factory method according to the requirement of type of object.
 
 ### Summary
 
 This way we decouple the dependencies of client from the logic of how the object is created.
*/

protocol Plan {
    var rate: Float { get }
    
    func getRate()
    func calculateBill(unit: Int) -> String
}

extension Plan {
    func calculateBill(unit: Int) -> String {
        return String(Float(unit) * rate)
    }
}

class DomesticPlan: Plan {
    var rate: Float = 0.0
    
    func getRate() {
        rate = 3.50
    }
}

class CommercialPlan: Plan {
    var rate: Float = 0.0
    
    func getRate() {
        rate = 7.50
    }
}

class InstitutionalPlan: Plan {
    var rate: Float = 0.0
    
    func getRate() {
        rate = 5.50
    }
}

enum TypeOfPlan: String {
    case Domestic
    case Commercial
    case Institutional
}

class GetPlanFactory {
    
    private static let sharedPlanFactory = GetPlanFactory()
    
    class func shared() -> GetPlanFactory {
        return sharedPlanFactory
    }
    
    func getPlan(planType: TypeOfPlan) -> Plan {
        switch planType {
        case .Commercial:
            return CommercialPlan()
            
        case .Domestic:
            return DomesticPlan()
            
        case .Institutional:
            return InstitutionalPlan()
        }
    }
}

struct PlanDetails{
    var unit: Int
    var planType: TypeOfPlan
}

var arrayOfUnit = [PlanDetails]()

arrayOfUnit.append(PlanDetails(unit: 98, planType: .Domestic))
arrayOfUnit.append(PlanDetails(unit: 204, planType: .Commercial))
arrayOfUnit.append(PlanDetails(unit: 465, planType: .Institutional))

for unitDetails in arrayOfUnit {
    let plan = GetPlanFactory.shared().getPlan(planType: unitDetails.planType)
    plan.getRate()
    let bill = plan.calculateBill(unit: unitDetails.unit)
    print("Bill for your \(unitDetails.planType.rawValue) plan with \(unitDetails.unit) unit(s) consumed is Rs. \(bill)")
}
