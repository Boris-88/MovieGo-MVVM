// ViewState.swift
// Copyright © Boris. All rights reserved.

import Foundation

/// ViewData
enum ViewState<Model> {
    // Инициализация
    case initial
    // Загрузка
    case loading
    // Есть данные
    case data(_ model: Model)
    // Ошибка
    case error(_ error: ResponsSessionError)
}
