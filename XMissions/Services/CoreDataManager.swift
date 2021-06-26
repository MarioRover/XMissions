//
//  CoreDataManager.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
//
//    var moc: NSManagedObjectContext
//
//    private init(moc: NSManagedObjectContext) {
//        self.moc = moc
//    }
//
//    private func saveDB() {
//        do {
//            try self.moc.save()
//        } catch {
//            PrintError(error as NSError)
//        }
//    }
//
//    private func PrintError(_ error: NSError) {
//        print("🚫 \(error.localizedDescription)")
//    }
//
//    func saveInitialData(data: APIResponse) {
//        self.cleanEntity(entityName: "Company")
//
//        let companyEntity = Company(context: self.moc)
//
//        if let companyData = data.company {
//            companyEntity.ceo = companyData.ceo
//            companyEntity.cto = companyData.cto
//            companyEntity.coo = companyData.coo
//            companyEntity.cto_propulsion = companyData.cto_propulsion
//            companyEntity.employees = Int16(companyData.employees ?? 0)
//            companyEntity.founded = Int16(companyData.founded ?? 0)
//            companyEntity.founder = companyData.founder
//            companyEntity.valuation = companyData.valuation ?? 0
//            companyEntity.city = companyData.headquarters?.city
//            companyEntity.state = companyData.headquarters?.state
//            companyEntity.address = companyData.headquarters?.address
//            companyEntity.summary = companyData.summary
//            companyEntity.flickr = companyData.links?.flickr
//            companyEntity.twitter = companyData.links?.twitter
//            companyEntity.twitter = companyData.links?.twitter
//            companyEntity.website = companyData.links?.website
//        } else {
//            print("❗️There's not company")
//        }
//
//        saveDB()
//    }
//
//    func fetchCompanyInfo(completion: @escaping (Company?) -> ()) {
//        var companies = [Company]()
//
//        let request: NSFetchRequest<Company> = Company.fetchRequest()
//
//        do {
//            companies = try self.moc.fetch(request)
//        } catch {
//            PrintError(error as NSError)
//            completion(nil)
//        }
//
//        completion(companies.first)
//    }
//
//    private func cleanEntity(entityName: String) {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
//
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try self.moc.execute(batchDeleteRequest)
//        } catch {
//            PrintError(error as NSError)
//        }
//    }
//}
