//
//  MapRouletteLayerView.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/14/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import UIKit

@objc protocol LayerViewDelegate: class {
    func isLayerVisible(_ layerView: LayerView) -> Bool
    var screenLongitudeLatitude: OSMRect { get }

    @objc(screenPointFromMapPoint:birdsEye:)
    func screenPoint(from mapPoint: OSMPoint, birdsEye: Bool) -> CGPoint

    func layerDidEncounterError(_ error: Error)
}

@objc protocol LayerView: class {
    var delegate: LayerViewDelegate? { get set }
    func layout()
    
    /// Tells the layer to update its dynamic content (e. g. by downloading information from a web server)
    func updateDynamicContent()
}

@objcMembers class MapRouletteLayerView: UIView, LayerView {
    
    // MARK: Private properties
    
    private let apiClient: MapRouletteClientProtocol = MapRouletteClient.shared
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: LayerView
    
    weak var delegate: LayerViewDelegate?
    
    func layout() {
        /// TODO: Implement me.
    }
    
    func updateDynamicContent() {
        guard let boundingBox = delegate?.screenLongitudeLatitude else { return }
        
        apiClient.tasks(in: boundingBox) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.delegate?.layerDidEncounterError(error)
            case let .success(tasks):
                self?.processTasks(tasks)
            }
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        /// Implement me
    }
    
    private func processTasks(_ tasksToProcess: [MapRouletteTask]) {
    }
}
