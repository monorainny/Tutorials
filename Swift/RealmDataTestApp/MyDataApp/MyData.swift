//
//  MyData.swift
//  MyDataApp
//
//  Created by Seong Hoon Jeong on 2016. 1. 10..
//  Copyright © 2016년 Seong Hoon Jeong. All rights reserved.
//

import Foundation
import RealmSwift

// MyData model
class MyData: Object {
    dynamic var name = ""
    dynamic var photo_name = ""
    dynamic var rating = 0
    dynamic var url = ""
}
