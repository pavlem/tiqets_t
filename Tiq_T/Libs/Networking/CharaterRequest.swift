
import Foundation
import NetworkProvider

class CharaterRequest {
    let page: Int?
    let search: String?
    
    init(page: Int?) {
        self.page = page
        self.search = nil
    }
    
    init(search: String) {
        self.page = nil
        self.search = search
    }
}

extension CharaterRequest {
    
    func body() -> NetworkService.JSON {
        var params = [String: Any]()
        if let searchChar = self.search {
            params["search"] = searchChar
            return params
        }
        if let page = self.page { params["page"] = page }
        return params
    }
}
