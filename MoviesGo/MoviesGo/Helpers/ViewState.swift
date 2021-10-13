// ViewState.swift
// Copyright © Boris. All rights reserved.

import Foundation

/// ViewData
enum ViewState<Model> {
    // Загрузка
    case loading
    // Есть данные
    case data(_ model: Model)
    // Ошибка
    case error(_ error: ResponsSessionError)
}
