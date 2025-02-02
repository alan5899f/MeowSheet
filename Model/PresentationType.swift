//
//  PresentationType.swift
//  Pods
//
//  Created by 陳韋綸 on 2025/1/26.
//

extension PresentationController {
    public enum PresentationType {
        
        // MARK: - Percentage
        /// Screen height percentage.  max: 1, min: 0
        /// Example: Half the height is percentage 0.5.
        case percentage(Double)
        
        // MARK: - Fixed
        /// Screen height fixed.
        /// Example: Height is 230 px, fixed 230.
        case fixed(Double)
    }
}
