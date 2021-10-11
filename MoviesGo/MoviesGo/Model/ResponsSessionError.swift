// ResponsSessionError.swift
// Copyright © Boris. All rights reserved.

import Foundation

/// ResponsSessionError
enum ResponsSessionError: Error {
    case failure(Error)
    case notData
    case failureDecode
}
