//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService : NSObject {
    private let baseUrl = ""
    
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetails(completion : @escaping (Swift.Result<[DeviceData],Error>) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error)) // Return an empty array on network failure
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do{
                    let deviceData = try jsonDecoder.decode([DeviceData].self, from: data)
                    if (deviceData.isEmpty) {
                        completion(.failure(APIError.NoDataFound)) // Return error on data not found
                    } else {
                        APICacheManager.shared.storeCache(data: data)
                        completion(.success(deviceData)) // return data on successfull decoding
                    }
                } catch {
                    print("Decode error: \(error.localizedDescription)")
                    completion(.failure(error)) // Return error on decode fail
                }
            } else {
                print("Data error")
                completion(.failure(APIError.InvalidResponse)) // Return an empty array on network failure
            }
        }.resume()
    }
}
