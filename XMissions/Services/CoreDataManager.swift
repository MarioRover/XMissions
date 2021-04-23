//
//  CoreDataManager.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    private func saveDB() {
        do {
            try self.moc.save()
        } catch {
            PrintError(error: error as NSError)
        }
    }
    
    private func PrintError(error: NSError) {
        print("🚫 \(error.localizedDescription)")
    }
    
    func saveCompanyInfo(companyData: CompanyStruct) {
        let data = Company(context: self.moc)
        
        data.ceo = companyData.ceo
        data.cto = companyData.cto
        data.coo = companyData.coo
        data.cto_propulsion = companyData.cto_propulsion
        data.employees = Int16(companyData.employees)
        data.founded = Int16(companyData.founded)
        data.founder = companyData.founder
        data.valuation = companyData.valuation
        data.city = companyData.headquarters.city
        data.state = companyData.headquarters.state
        data.address = companyData.headquarters.address
        data.summary = companyData.summary
        data.flickr = companyData.links.flickr
        data.twitter = companyData.links.twitter
        data.twitter = companyData.links.twitter
        data.website = companyData.links.website
        
        saveDB()
    }
    
    func fetchCompanyInfo(completion: @escaping (Company?) -> ()) {
        var companies = [Company]()
        
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        
        do {
            companies = try self.moc.fetch(request)
        } catch {
            PrintError(error: error as NSError)
            completion(nil)
        }
        
        completion(companies.first)
    }
}
