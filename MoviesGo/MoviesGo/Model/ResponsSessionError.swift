// ResponsSessionError.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

/// ResponsSessionError
enum ResponsSessionError: Error {
    case failure(Error)
    case notData
    case failureDecode
}
