// ResponsSessionError.swift
// Copyright © Boris. All rights reserved.

import Foundation

// Описание ошибок
enum ResponsSessionError: Error {
    case failure(Error)
    case notData
    case failureDecode
}
