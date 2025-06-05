//
//  matchLikeView.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/11/19.
//

import UIKit
import SVGAPlayer
import SnapKit

class matchLikeView: UIView {
    
    let sourceName = "matchlike"

    lazy var player: SVGAPlayer = {
        let player = SVGAPlayer()
        player.fillMode = "forward"
        player.contentMode = .scaleAspectFit
        player.loops = 1
        player.clearsAfterStop = true
        player.delegate = self
        return player
    }()
    
    lazy var svgaParser:SVGAParser = {
        let parser = SVGAParser()
        return parser
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("XMChannelMainPageHeaderView dealloc")
    }
    
    private func setupViews () -> Void {
        self.addSubview(player)
        player.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func stopSvgPlayer() -> Void {
        player.isHidden = true
    }
    
    public func svgBeginPlay() -> Void {
        player.isHidden = false
//        let bundleUrl:URL = URL(string: "https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true")!
//        svgaParser.parse(with: bundleUrl) { videoItem in
//            self.player.videoItem = videoItem
//            self.player.startAnimation()
//        } failureBlock: { error in
//            print("error ======>\(error.debugDescription)")
//        }
        
//        NSString *svgaName = @"like_big_fall_left";
//        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"LKDisplayBundle" withExtension:@"bundle"];
//        if (!bundleURL) {
//            return;
//        }
//        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
        let bundleUrl:URL? = Bundle.main.url(forResource: "LKDisplayBundle", withExtension: "bundle")
        guard let bundleSource = bundleUrl else { return }
        let bundle = Bundle(url: bundleSource)
        svgaParser.parse(withNamed: sourceName, in: bundle) { videoItem in
            self.player.videoItem = videoItem
            self.player.startAnimation()
        } failureBlock: { error in
            print("error ======>\(error.localizedDescription)")
        }

        
    }
}

extension matchLikeView:SVGAPlayerDelegate {
    func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
        self.stopSvgPlayer()
    }
}
