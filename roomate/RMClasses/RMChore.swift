//
//  RMChore.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
public struct RMChore {
    var objectId: String // Also known as unique identifier
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var owner: String // Who did the chore
    var description: String // AKA additional notes
    var beforePhoto: String // Base64
    var afterPhoto: String
    var completionHistory: [String: String] // <username : Time of completion>
    var commentHistory: [String: String] // <username: comment>

}
