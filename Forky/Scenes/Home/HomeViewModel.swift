//
//  HomeViewModel.swift
//  Forky
//
//  Created by Vivek Patel on 12/01/23.
//

import Foundation

final class HomeViewModel: NSObject, ObservableObject {
    private var service: HomeService
    var dataPost: PostListModel?
    
    init(_ service: HomeService) {
        self.service = service
    }

    func getPostList(type: String?,success:@escaping () -> Void, failure:@escaping (Error) -> Void) {
        Task.detached(priority: .background) { [weak self] in
            guard let self = self else { return }
            do {
                async let _withdrawableLimit = try self.service.getPostList(type: type)
                let withdrawableLimit = try await _withdrawableLimit
                self.dataPost = withdrawableLimit
                await MainActor.run {
                    success()
                }
            } catch {
                await MainActor.run {
                    failure(error)
                }
            }
        }
    }
    
    func getSearchPostList(query: String?,success:@escaping () -> Void, failure:@escaping (Error) -> Void) {
        Task.detached(priority: .background) { [weak self] in
            guard let self = self else { return }
            do {
                async let _withdrawableLimit = try self.service.getSearchPostList(query: query)
                let withdrawableLimit = try await _withdrawableLimit
                self.dataPost = withdrawableLimit
                await MainActor.run {
                    success()
                }
            } catch {
                await MainActor.run {
                    failure(error)
                }
            }
        }
    }
}


protocol HomeServiceProtocol: AnyObject {
    func getPostList(type: String?) async throws -> PostListModel
    func getSearchPostList(query: String?) async throws -> PostListModel
}

final class HomeService: HomeServiceProtocol {
    func getPostList(type: String? = nil) async throws -> PostListModel {
        var param = [String : Any]()
        if let value = type {
            param["type"] = value
        }
        let result = await NW.request(BasicFlowBottomSheetEndPoint.getCryptoDailyWithdrawlLimit(param).configuration)
        switch result {
        case .success(let data):
            if let response = data.decode(PostListModel.self) {
                return response
            } else {
                throw AppError.parsingError
            }
        case .failure(let error):
            throw error
        }
    }
    
    func getSearchPostList(query: String? = nil) async throws -> PostListModel {
        var param = [String : Any]()
        if let value = query {
            param["q"] = value
        }
        let result = await NW.request(BasicFlowBottomSheetEndPoint.getCryptoDailyWithdrawlLimit(param).configuration)
        switch result {
        case .success(let data):
            if let response = data.decode(PostListModel.self) {
                return response
            } else {
                throw AppError.parsingError
            }
        case .failure(let error):
            throw error
        }
    }
}

enum BasicFlowBottomSheetEndPoint {
    case getCryptoDailyWithdrawlLimit(_ parameters: [String : Any])
    
    var configuration: URLConfiguration {
        let base = AppConfiguration.shared.baseURL.absoluteString
        
        switch self {
        case .getCryptoDailyWithdrawlLimit(let parameters):
            return URLConfiguration(endPoint: base + "v1/posts", method: .get, parameters: parameters)
        }
    }
}

class AppConfiguration {
    static let shared = AppConfiguration()

    var baseURL: URL {
        let url: URL = URL(string: "http://143.110.181.255/api/")!
        print(url)
        return url
    }
}

public enum AppError: LocalizedError {
    case parsingError
    
    public var errorDescription: String? {
        switch self {
        case .parsingError:
            return NSLocalizedString("Failed to parse response data", comment: "")
        }
    }
}

struct PostListModel: Decodable {
    let status: Bool?
    var data: PostListDataModel?
}

struct PostListDataModel: Decodable {
    var vendor_posts: [PostDataModel?]?
}

struct PostDataModel: Decodable {
    var caption, photo: String?
    var from_date,to_date : String?
    var vendor : VenderDataModel?
}

struct VenderDataModel: Decodable {
    var business_name, address_line_1,address_line_2,latitude,longitude,primary_contact,logo: String?
}
