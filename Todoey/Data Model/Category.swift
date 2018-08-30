//
//  Category.swift
//  Todoey
//
//  Created by JERUEL DE CASTRO on 29/08/2018.
//  Copyright © 2018 iHasMore. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
