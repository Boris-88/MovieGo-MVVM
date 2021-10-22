// DataState.swift
// Copyright © Boris Zverik. All rights reserved.

import Foundation

/// ViewData
enum DataState<Model> {
    // Загрузка
    case reLoading
    // Есть данные
    case data(_ model: Model)
    // Ошибка
    case error(_ error: ResponsSessionError)
}
