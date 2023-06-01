//
//  UITableView+Dequeueing.swift
//  Assignment
//
//  Created by kashif on 6/1/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
