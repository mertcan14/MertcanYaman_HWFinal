//
//  DictionaryService.swift
//
//
//  Created by mertcan YAMAN on 26.05.2023.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case emptyDataError
    case operationFailed
    case connectionError
    case invalidChar
    case error(Error)
    
    public var message: String? {
        switch self {
        case .operationFailed:
            return "We encountered an unexpected error"
        case .connectionError:
            return "You do not have an internet connection"
        case .error(let error):
            return error.localizedDescription
        case .emptyDataError:
            return "We couldn't find the result you were looking for"
        case .invalidChar:
            return "You entered an invalid character"
        }
    }
}

public protocol MusicServiceProtocol: AnyObject {
    func fetchMusic<T: Decodable>(_ url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class MusicService: MusicServiceProtocol {
    
    public static let shared = MusicService()
    
    public init() {}
    
    public func fetchMusic<T: Decodable>(
        _ url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void)
    {
        AF.request(url).responseData { response in
            
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.emptyDataError))
                }
            case .failure(_):
                completion(.failure(.operationFailed))
            }
        }
    }
}

// TODO: Kaldır buradan
public enum Decoders {
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
