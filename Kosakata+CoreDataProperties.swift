//
//  Kosakata+CoreDataProperties.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 25/06/21.
//
//

import Foundation
import CoreData


extension Kosakata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kosakata> {
        return NSFetchRequest<Kosakata>(entityName: "Kosakata")
    }

    @NSManaged public var deskripsi: String?
    @NSManaged public var deskripsiVideo: String?
    @NSManaged public var kata: String?
    @NSManaged public var kategori: String?
    @NSManaged public var pathVideo: String?
    @NSManaged public var sudahDipelajari: Int16

}

extension Kosakata : Identifiable {

}
