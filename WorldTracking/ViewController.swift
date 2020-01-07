//
//  ViewController.swift
//  WorldTracking
//
//  Created by Edward O'Neill on 1/6/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    let randomColor: [UIColor] = [.black, .blue, .green]
    let randomNumber: [CGFloat] = [0.1, 0.2, 0.3, 0.4, 0.5, 0, -0.1, -0.2, -0.3, -0.4, -0.5]
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = randomColor.randomElement()!
        node.position = SCNVector3(randomNumber.randomElement()!, randomNumber.randomElement()!, randomNumber.randomElement()!)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}
