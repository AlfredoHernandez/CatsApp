//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

extension Data {
    func decode<Item>(type _: Item.Type) throws -> Item where Item: Decodable {
        try JSONDecoder().decode(Item.self, from: self)
    }
}
