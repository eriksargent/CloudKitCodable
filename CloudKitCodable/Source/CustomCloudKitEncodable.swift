//
//  CustomCloudKitEncodable.swift
//  CloudKitCodable
//
//  Created by Guilherme Rambo on 11/05/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import Foundation
import CloudKit

internal let _CKSystemFieldsKeyName = "cloudKitSystemFields"
internal let _CKIdentifierKeyName = "cloudKitIdentifier"

public protocol CloudKitRecordRepresentable {
    var cloudKitSystemFields: Data? { get }
    var cloudKitRecordType: String { get }
    var cloudKitIdentifier: String { get }
}

extension CloudKitRecordRepresentable {
    public var cloudKitRecordType: String {
        return String(describing: type(of: self))
    }
}

public protocol CustomCloudKitEncodable: CloudKitRecordRepresentable & Encodable {

}

public protocol CustomCloudKitDecodable: CloudKitRecordRepresentable & Decodable {

}

public protocol CustomCloudKitCodable: CustomCloudKitEncodable & CustomCloudKitDecodable { }


struct CKReferenceCoder: Codable {
	var recordName: String
	
	init(with name: String) {
		recordName = name
	}
	
	init(from reference: CKRecord.Reference) {
		recordName = reference.recordID.recordName
	}
	
	func id(in zone: CKRecordZone.ID) -> CKRecord.ID {
		return CKRecord.ID(recordName: recordName, zoneID: zone)
	}
}
