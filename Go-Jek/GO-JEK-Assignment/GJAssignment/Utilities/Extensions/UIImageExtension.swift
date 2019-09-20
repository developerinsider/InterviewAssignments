//
//  UIImageExtension.swift
//  GJAssignment
//
//  Created by Anonymous on 17/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    struct Contact {
        static let placeHolder = #imageLiteral(resourceName: "PlaceholderPhoto")
        static let showFavorite = #imageLiteral(resourceName: "HomeFavourite")
    }
    
    struct Action {
        static let call = #imageLiteral(resourceName: "CallButton")
        static let mail = #imageLiteral(resourceName: "EmailButton")
        static let message = #imageLiteral(resourceName: "MessageButton")
        static let favorite = #imageLiteral(resourceName: "FavouriteButton")
        static let favoriteSelected = #imageLiteral(resourceName: "FavouriteButtonSelected")
        static let takePhoto = #imageLiteral(resourceName: "CameraButton")
    }
}
