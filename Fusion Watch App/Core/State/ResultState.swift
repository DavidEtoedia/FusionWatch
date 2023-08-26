//
//  ResultState.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


enum ResultState<T, String> {
    case loading
    case idle
    case success(T)
    case failure(String)
  
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var error: String? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isIdle: Bool {
        if case .idle = self {
            return true
        }
        return false
    }
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
    
}

