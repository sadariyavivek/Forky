//
//  SearchViewModel.swift
//  Forky
//
//  Created by Vivek Patel on 26/12/22.
//

import Foundation

struct SearchSectionModel:Decodable
{
    var section:[TypeSection] = [.search, .nearby]
    
    enum TypeSection: String,Decodable{
        case search
        case nearby
    }
}

final class SearchViewModel: NSObject, ObservableObject {
    var data:SearchSectionModel = SearchSectionModel()
    private var service: SearchService
    var dataPost: PostListModel?
    
    init(_ service: SearchService) {
        self.service = service
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


protocol SearchServiceProtocol: AnyObject {
    func getSearchPostList(query: String?) async throws -> PostListModel
}

final class SearchService: SearchServiceProtocol {
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
