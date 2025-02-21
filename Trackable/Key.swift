//
//  Key.swift
//  Trackable
//
//  Created by Vojta Stavik (vojtastavik.com) on 06/12/15.
//  Copyright © 2015 Vojta Stavik. All rights reserved.
//

import Foundation

public protocol Key: CustomStringConvertible { }

/**
    Specify a prefix which sould be removed from all keys. Usually you use this to remove project and/or module name.
*/
public var keyPrefixToRemove: String? = nil

/**
    
*/
public var smartKeyComposingEnabled = true

public extension Key where Self : RawRepresentable {
    /**
        String representation of Event object.
     */
    var description: String {
        var rawDescription = String(reflecting: type(of: self)) + "." + "\(self.rawValue)"
        if let
            prefixToRemove = keyPrefixToRemove,
            let range = rawDescription.range(of: prefixToRemove) {
            rawDescription.removeSubrange(range)
        }
        
        return rawDescription
    }
}

public extension Key {
    /**
        Removes common prefix for both keys
     */
    func composeKeyWith(_ key: Key) -> String {
        guard smartKeyComposingEnabled else {
            return description + "." + key.description
        }
        
        let myKey = description
        let otherKey = key.description
        
        var finalKey = myKey
        
        for i in 1...otherKey.count {
            let prefix = String(otherKey.prefix(i))
            if myKey.hasPrefix(prefix) == false {
                finalKey = finalKey + "." + String(otherKey.suffix(otherKey.count - i + 1))
                break
            }
        }
        
        let keyWithoutRepeatingParts = removeRepeatingParts(finalKey)
        return keyWithoutRepeatingParts
    }
    
    /**
        Removes repeating parts of the key
     */
    func removeRepeatingParts(_ keyDescription: String) -> String {
        let separator = "."
        let elements = keyDescription.components(separatedBy: separator)
        
        let first = elements.first! // ->> should never be nil
        return elements.reduce(first, { (result, element) -> String in
            if result.components(separatedBy: separator).last == element {
                return result
            } else {
                return result + "." + element
            }
        })
    }
}

extension String : Key {
    public var description: String {
        return self
    }
}
