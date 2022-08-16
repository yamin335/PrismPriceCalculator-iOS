//
//  Extensions.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/11/22.
//

import Foundation
import SwiftUI

func loadLocalJsonFile<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
    func toShortForm() -> String {
        var result = "N/A"
        if self.isEmpty {
            return result
        }
        
        let words = self.components(separatedBy: " ")
        
        if words.count > 0 {
            result = ""
            
            for word in words {
                guard !word.isEmpty else {
                    continue
                }
                
                let firstLetterString = String(word[word.startIndex])
                let firstLetterTrimmed = firstLetterString.trimmingCharacters(in: .whitespacesAndNewlines)
                if firstLetterString ~= "[A-Za-z]"  {
                    result += firstLetterTrimmed
                }
            }
        } else {
            return result
        }
        
        return result
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(in value: String) -> Bool {
        let range = NSRange(location: 0, length: value.utf16.count)
        return firstMatch(in: value, options: [], range: range) != nil
    }
}
