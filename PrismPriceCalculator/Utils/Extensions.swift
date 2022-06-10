//
//  Extensions.swift
//  PrismPriceCalculator
//
//  Created by Md. Yamin on 6/11/22.
//

import Foundation

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
