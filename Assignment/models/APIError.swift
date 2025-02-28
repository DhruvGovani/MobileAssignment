//
//  APIError.swift
//  Assignment
//
//  Created by droadmin on 2/28/25.
//

import Foundation

enum APIError: Error{
    /// When No Data from response has received
    case NoDataFound
    /// When returned response is invalid or nil
    case InvalidResponse
}
