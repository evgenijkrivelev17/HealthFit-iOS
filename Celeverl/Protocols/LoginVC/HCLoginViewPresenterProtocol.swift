//
//  HCLoginViewPresenterProtocol.swift
//  HappyChild (mobile)
//
//  Created by Anna on 03.12.2019.
//  Copyright © 2019 oberon. All rights reserved.
//

import Foundation

protocol HCLoginViewPresenterProtocol {
    func update(phoneNumber: String)
    func sendButtonDidTouchUpInside()
    func update(code: String)
}
