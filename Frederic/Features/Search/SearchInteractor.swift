//
//  SearchInteractor.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func doSomething(request: Search.Something.Request)
}

protocol SearchDataStore {
  //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  var presenter: SearchPresentationLogic?
  var worker: SearchWorker?
  //var name: String = ""

  // MARK: Do something

  func doSomething(request: Search.Something.Request) {
    worker = SearchWorker()
    worker?.doSomeWork()

    let response = Search.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
