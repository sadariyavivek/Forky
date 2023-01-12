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
    
    var callbackDataFetched: (() -> Void)?
    init(_ service: HomeService) {
        self.service = service
    }

    func getPostList(success:@escaping () -> Void, failure:@escaping (Error) -> Void) {
        Task.detached(priority: .background) { [weak self] in
            guard let self = self else { return }
            do {
                async let _withdrawableLimit = try self.service.getPostList()
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
    func getPostList() async throws -> PostListModel
}

final class HomeService: HomeServiceProtocol {
    func getPostList() async throws -> PostListModel {
        let result = await NW.request(BasicFlowBottomSheetEndPoint.getCryptoDailyWithdrawlLimit.configuration)
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
    case getCryptoDailyWithdrawlLimit
    
    var configuration: URLConfiguration {
        let base = AppConfiguration.shared.baseURL.absoluteString
        
        switch self {
        case .getCryptoDailyWithdrawlLimit:
            return URLConfiguration(endPoint: base + "v1/posts", method: .get)
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
}

