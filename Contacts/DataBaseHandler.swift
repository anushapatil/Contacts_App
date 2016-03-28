//
//  DataBaseHandler.swift
//  Contacts
//
//  Created by Anusha Patil on 12/03/2016.
//  Copyright © 2016 Anusha Patil. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHandler: NSObject
{
    var storedContacts:NSMutableArray?
    //MARK: Singleton class
    class var sharedInstance: DataBaseHandler
    {
        struct Static
        {
            static var onceToken: dispatch_once_t = 0;
            static var instance: DataBaseHandler? = nil
        }
        
        dispatch_once(&Static.onceToken){
            Static.instance = DataBaseHandler();
        }
        return Static.instance!;
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Contacts", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Contacts.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext ()
    {
        if managedObjectContext.hasChanges
        {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    //MARK: Update database
    
    func updateData(firstname: String, updatedData:AddContactsModel)
    {
        let fetchRequest = NSFetchRequest();
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: self.managedObjectContext);
        
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true, selector: "localizedStandardCompare:")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "firstName=%@", firstname)
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.entity = entityDescription;
        fetchRequest.predicate = predicate;
        do
        {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest);
            if result.count != 0
            {
                let managedObject = result[0]
                managedObject.setValue(updatedData.namePrefix, forKey: "namePrefix")
                managedObject.setValue(updatedData.firstName, forKey: "firstName")
                managedObject.setValue(updatedData.middleName, forKey: "middleName")
                managedObject.setValue(updatedData.surname, forKey: "surname")
                managedObject.setValue(updatedData.nameSuffix, forKey: "nameSuffix")
                managedObject.setValue(updatedData.company, forKey: "company")
                managedObject.setValue(updatedData.title, forKey: "title")
                managedObject.setValue(updatedData.phone, forKey: "phone")
                managedObject.setValue(updatedData.email, forKey: "email")
                managedObject.setValue(updatedData.address, forKey: "address")
                
                saveContext();
            }
        }
        catch
        {
            let updateError = error as NSError
            print(updateError);
        }
    }
    
    //MARK: Delete coredata support
    
    func deleteDataBaseRecord(firstname: String)
    {
        
        let fetchRequest = NSFetchRequest();
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: self.managedObjectContext);
        
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true, selector: "localizedStandardCompare:")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "firstName=%@", firstname)
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.entity = entityDescription;
        fetchRequest.predicate = predicate;
        do
        {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest);
            if result.count != 0
            {
                let contact = result[0] as! Contacts
                managedObjectContext.deleteObject(contact)
                
                saveContext();
            }
        }
        catch
        {
            let deleteError = error as NSError
            print(deleteError);
        }
    }
    
    //MARK: Core data fetch data support
    
    func fetchData ()
    {
        let fetchRequest = NSFetchRequest();
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: self.managedObjectContext);
        
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true, selector: "localizedStandardCompare:")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.entity = entityDescription;
        do
        {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest);
            storedContacts = result as! NSMutableArray
            print(result);
        }
        catch
        {
            let fetchError = error as NSError
            print(fetchError);
        }
    }
    
    //MARK: Custom methods
    
    func savingContactsWithDetails(addContactsModel:AddContactsModel)
    {
        let contact = NSEntityDescription.insertNewObjectForEntityForName("Contacts", inManagedObjectContext: self.managedObjectContext) as! Contacts
        contact.namePrefix = addContactsModel.namePrefix;
        contact.firstName = addContactsModel.firstName;
        contact.middleName = addContactsModel.middleName;
        contact.surname = addContactsModel.surname;
        contact.nameSuffix = addContactsModel.nameSuffix;
        contact.company = addContactsModel.company;
        contact.title = addContactsModel.title;
        contact.phone = addContactsModel.phone;
        contact.email = addContactsModel.email;
        contact.address = addContactsModel.address;
        contact.date = addContactsModel.date;
        contact.groupName = addContactsModel.groupName;
        contact.phoneType = addContactsModel.phoneType;
        contact.emailType = addContactsModel.emailType;
        contact.addressType = addContactsModel.addressType;
        contact.specialDatesType = addContactsModel.specialDatesType;
        
        saveContext();
    }
    
}
