//
//  RankView.swift
//  FinalMid
//
//  Created by 小同同 on 4/11/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var ans = [String]()
    var result = [String]()
    var newarray = [String]()
    var array = [String]()
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        if(defaultss.array(forKey: "newarray") != nil) {
            newarray = defaultss.array(forKey: "newarray") as! [String]
        }
        
        print("\(newarray) rank")
        var subArray = [String]()
        if(defaultss.array(forKey: "newarray") != nil) {
            array = (defaultss.array(forKey: "newarray") as? [String])!
        }
        if(defaultss.array(forKey: "rankArray") != nil) {
            result = defaultss.array(forKey: "rankArray") as! [String]
        }
        
        

        }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.backgroundColor = UIColor.black
        cell.textLabel?.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundView?.alpha = 0
        cell.textLabel?.alpha = 1
        cell.textLabel?.text = self.result[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
class RankView: SKScene{
    var gameTableView = GameTableView()
    private var label : SKLabelNode?
    var mainMenu: SystemButtonNode!
    var activeRec: CGRect!
    override func didMove(to view: SKView) {
                
        let background = SKSpriteNode(imageNamed: "black")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let titleLabel = SKLabelNode(fontNamed: "Chalkduster")
        titleLabel.text = "High Scores"
        titleLabel.fontColor = SKColor.white
        titleLabel.fontSize = 80
        titleLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.9)
        titleLabel.zPosition = 1
        self.addChild(titleLabel)
        
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        // Table setup
        gameTableView.backgroundView?.alpha = 0
        gameTableView.backgroundColor = UIColor.black
        gameTableView.alpha = 1
        gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame=CGRect(x:30,y:100,width:315,height: 400)
        self.scene?.view?.addSubview(gameTableView)
        gameTableView.reloadData()
        
        activeRec = CGRect(origin: self.frame.origin, size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        
        mainMenu = SystemButtonNode(in: self.activeRec, image: "mainButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.mainMenu)
        self.addChild(mainMenu)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let myTransition = SKTransition.fade(withDuration: 0.5)
            var sceneToMoveTo: SKScene
            if mainMenu.contains(pointOfTouch){
                gameTableView.removeFromSuperview()
                sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                self.scene?.view?.reloadInputViews()
            }
        }
    }
}
