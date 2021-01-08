//
//  ViewController.swift
//  DiceeGCSF
//
//  Created by Ta Huy Hung on 2/12/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController : UIViewController,DiceDelegate {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var imgBackgroundDeer: UIImageView!
    @IBOutlet weak var imgBackgroundCrab: UIImageView!
    @IBOutlet weak var imgBackgroundChicken: UIImageView!
    @IBOutlet weak var imgBackgroundFish: UIImageView!
    @IBOutlet weak var imgBackgroundGourd: UIImageView!
    @IBOutlet weak var imgBackgroundShrimp: UIImageView!
    @IBOutlet weak var imgDice1: UIImageView!
    @IBOutlet weak var imgDice2: UIImageView!
    @IBOutlet weak var imgDice3: UIImageView!
    @IBOutlet weak var lblShowMoney: UILabel!
    
    var money = 50000
    var moneyBet = 0
    var arrImgName = ["ic_deer","ic_crab","ic_chicken","ic_fish","ic_gourd","ic_shrimp"]
    var arrImgNameAfterRandom = [String]()
    var arrImgNameDoorIsChosen = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        showTotalMoney()
    }
    
    func showTotalMoney(){
        lblShowMoney.text = "\(money)"
    }
    
    func onMoneyReceived(_ money: String) {
        moneyBet = Int(money) ?? 0
    }
    
    
    @IBAction func onDiceRoll(_ sender: Any) {
        var imgNameAfterRandom : String?
        for _ in 0...2{
            imgNameAfterRandom = arrImgName.randomElement()!
            arrImgNameAfterRandom.append(imgNameAfterRandom!)
        }
        
        imgDice1.image = UIImage(named: arrImgNameAfterRandom[0])
        imgDice2.image = UIImage(named: arrImgNameAfterRandom[1])
        imgDice3.image = UIImage(named: arrImgNameAfterRandom[2])

        handleIsDoorMatchWithDice()
        arrImgNameAfterRandom.removeAll()
    }
    
//    let dict = ["ic_deer":imgBackgroundDeer]
    
    @IBAction func onDeerPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundDeer)
        checkItem(imgName: "ic_deer")
    }
    @IBAction func onCrabPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundCrab)
        checkItem(imgName: "ic_crab")
    }
    @IBAction func onChickenPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundChicken)
        checkItem(imgName: "ic_chicken")
    }
    @IBAction func onFishPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundFish)
        checkItem(imgName: "ic_fish")
    }
    @IBAction func onGourdPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundGourd)
        checkItem(imgName: "ic_gourd")
    }
    @IBAction func onShrimpPressed(_ sender: Any) {
        onTintColorChanged(imgView: imgBackgroundShrimp)
        checkItem(imgName: "ic_shrimp")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewPopUpController = segue.destination as? PopUpController
        viewPopUpController?.delegate = self
    }
    
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        player?.stop()
    }
    
    
    private func onTintColorChanged(imgView : UIImageView){
        imgView.image = imgView.image?.withRenderingMode(.alwaysTemplate)
        if(imgView.tintColor == UIColor.yellow){
            imgView.tintColor = UIColor.systemGray2
        }
        else{
            imgView.tintColor = UIColor.yellow
        }
    }
    
    
    private func handleIsDoorMatchWithDice(){
        var count : Int = 0
        for nameDoor in arrImgNameDoorIsChosen{
            for i in 0...2{
                if nameDoor == arrImgNameAfterRandom[i]{
                    count+=1
                }
            }
            if(count == 0){
                money = money - moneyBet
            }
            else{
                money = money + (moneyBet * count)
            }
            count = 0
        }
        showTotalMoney()
    }
    
    
    private func removeItem(_ array : [String],_ item : String) -> [String]{
        var arrayHasDeleteItem = array
        if let index = arrayHasDeleteItem.firstIndex(of: item){
            arrayHasDeleteItem.remove(at: index)
        }
        return arrayHasDeleteItem
    }
    
    
    private func checkItem(imgName : String ){
        if arrImgNameDoorIsChosen.contains(imgName) {
            arrImgNameDoorIsChosen = removeItem(arrImgNameDoorIsChosen, imgName)
        }
        else{
            arrImgNameDoorIsChosen.append(imgName)
        }
    }
    
    
    func playSound() {
        let url = Bundle.main.url(forResource: "poker_face", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
}

