//
//  APIService.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case serverError(error: String)
}

struct APIService {
    static var shared = APIService()
    
    func getClients(url: String, completion: @escaping (Result<[Client], APIError>) -> Void) {
        if url == "" {
            let clientList = [
                Client(id: "1", name: "Influencer One", contactInformation: ContactInformation(email: "test@test.com", phoneNumber: "7864475555", webUrl: "url", logoUrl: "logoUrl")),
                Client(id: "2", name: "Influencer Two", contactInformation: ContactInformation(email: "test2@test.com", phoneNumber: "7864475555", webUrl: "url2", logoUrl: "logoUrl2")),
                Client(id: "3", name: "Influencer Three", contactInformation: ContactInformation(email: "test3@test.com", phoneNumber: "7864475555", webUrl: "url3", logoUrl: "logoUrl3"))]
            completion(.success(clientList))
        } else {
            if let url = URL(string: url) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        completion(.failure(.serverError(error: error.debugDescription)))
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let clientList = try decoder.decode([Client].self, from: data)
                        completion(.success(clientList))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }
                task.resume()
                
            } else {
                completion(.failure(APIError.invalidURL))
            }
        }
    }    
    
    func getSponsors(url: String, clientID: String,completion: @escaping (Result<[Sponsor], APIError>) -> Void) {
        if url == "" {
            let sponsorsList = [
                Sponsor(id: "1", name: "Google", description: "Focusing on online advertising, search engine technology, cloud computing.", contactInformation: ContactInformation(email: "info@gmail.com", phoneNumber: "7864475555", webUrl: "url", logoUrl: "googleIcon")),
                Sponsor(id: "2", name: "Meta", description: "Meta builds technologies that help people connect, find communities and grow businesses.", contactInformation: ContactInformation(email: "info2@meta.com", phoneNumber: "7864475556", webUrl: "url2", logoUrl: "metaIcon")),
                Sponsor(id: "3", name: "Tesla", description: "It designs, develops, manufactures, sells, and leases electric vehicles, energy generation, and storage systems.", contactInformation: ContactInformation(email: "info@tesla.com", phoneNumber: "7864475557", webUrl: "url3", logoUrl: "teslaIcon"))]
            completion(.success(sponsorsList))
        } else {
            if let url = URL(string: url) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        completion(.failure(.serverError(error: error.debugDescription)))
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let sponsorsList = try decoder.decode([Sponsor].self, from: data)
                        completion(.success(sponsorsList))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }
                task.resume()
                
            } else {
                completion(.failure(APIError.invalidURL))
            }
        }
    }
}
