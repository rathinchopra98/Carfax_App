//
//  CarTableViewCell.swift
//  Carfax_App
//
//  Created by Rathin Chopra on 2022-01-06.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dealerPhoneBtn: UIButton!
    var actionBlock: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func dealerPhoneBtnClick(_ sender: Any) {
        actionBlock?()
    }
}
