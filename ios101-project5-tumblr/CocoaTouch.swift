//
//  CocoaTouch.swift
//  ios101-project5-tumblr
//

import UIKit
import Nuke
import NukeExtensions

class CocoaTouch: UITableViewCell {
    
    // UI elements from main storyboard
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        // clear content
        posterImageView?.image = nil
        titleLabel?.text = nil
        subtitleLabel?.text = nil
        
        if let imageView = posterImageView {
            NukeExtensions.cancelRequest(for: imageView)
        }
    }
    
    private func configureUI() {
        // image view properties
        posterImageView?.contentMode = .scaleAspectFill
        posterImageView?.clipsToBounds = true
        posterImageView?.layer.cornerRadius = 8
        
        // title lable
        titleLabel?.numberOfLines = 10
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel?.textColor = UIColor.label
        
        // subtitle lable
        subtitleLabel?.numberOfLines = 10
        subtitleLabel?.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel?.textColor = UIColor.secondaryLabel
        
        // spacing
        self.backgroundColor = UIColor.systemBackground
        self.selectionStyle = .none
    }
    
    func configure(with post: Post) {
        print("🔧 Configuring cell with summary: \(post.summary)")
        print("🔧 titleLabel is: \(titleLabel != nil ? "connected" : "nil")")
        print("🔧 posterImageView is: \(posterImageView != nil ? "connected" : "nil")")
        
        titleLabel?.text = post.summary
        titleLabel?.textColor = .label
        titleLabel?.backgroundColor = .systemYellow
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel?.numberOfLines = 0
        
        subtitleLabel?.text = post.caption
        subtitleLabel?.textColor = .secondaryLabel
        subtitleLabel?.backgroundColor = .systemBlue
        
        posterImageView?.image = UIImage(systemName: "photo.fill")
        posterImageView?.backgroundColor = .systemGreen
        
        if let photo = post.photos.first, let imageView = posterImageView {
            let request = ImageRequest(url: photo.originalSize.url)
            NukeExtensions.loadImage(with: request, into: imageView)
        }
        
        print("🔧 titleLabel text set to: \(titleLabel?.text ?? "nil")")
        print("🔧 titleLabel frame: \(titleLabel?.frame ?? CGRect.zero)")
    }
}
