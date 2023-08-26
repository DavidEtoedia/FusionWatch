//
//  Service.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation

@propertyWrapper
struct Service<Service> {

    var service: Service

    init(type: ServiceType = .singleton) {
        guard let service = ServiceContainer.resolve(type, Service.self) else {
            let serviceName = String(describing: Service.self)
            fatalError("No service of type \(serviceName) registered!")
        }

        self.service = service
    }

    var wrappedValue: Service {
        get { self.service }
    }
}
