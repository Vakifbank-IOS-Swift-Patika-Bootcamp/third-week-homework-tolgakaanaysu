//
//  Client.swift
//  QuoteProject
//
//  Created by Tolga Kağan Aysu on 20.11.2022.
//

import Foundation

class Client {
    
    enum Endpoints {
        static let base = "https://programming-quotes-api.herokuapp.com"
        
        case quotesRandom
        
        var stringValue: String {
            switch self {
            case .quotesRandom:
                return Endpoints.base + "/Quotes/random"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responsetType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    print("data error")
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                 
                    print(responseObject)
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    print("data parse error")
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getQuotes(completion: @escaping (QuotesModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.quotesRandom.url, responsetType: QuotesModel.self) { response, error in
            if let response = response {
                
                completion(response, nil)
            } else {
                completion(nil, error)
                print("response error")
            }
        }
    }
}

struct BaseResponse: Codable {
    let status: Int
    let error: String
}

extension BaseResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
