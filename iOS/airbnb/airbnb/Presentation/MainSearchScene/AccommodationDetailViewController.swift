//
//  AccommodationDetailViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/08.
//

import UIKit
import LinkPresentation

class AccommodationDetailViewController: UIViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var accommodationImageStackView: UIStackView!
    @IBOutlet weak var accommodationImageView: UIImageView!
    @IBOutlet weak var accommodationDetailView: AccommodationDetailView!
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    var shareURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccommodationDetailViewController()
        setupImageViews()
    }
    
    static func create() -> AccommodationDetailViewController {
        let stroyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = stroyboard.instantiateViewController(identifier: "AccommodationDetailViewController") as?
                AccommodationDetailViewController else {
            return AccommodationDetailViewController()
        }
        return viewController
    }
    
    private func setupAccommodationDetailViewController() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupImageViews() {
        self.accommodationImageView.image = UIImage(named: "background.png")
        self.accommodationImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.accommodationImageView.translatesAutoresizingMaskIntoConstraints = false
        self.accommodationImageStackView.addArrangedSubview(accommodationImageView)

        let view = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: self.accommodationImageView.frame.width, height: self.accommodationImageView.frame.height)))

        view.image = UIImage(named: "thumbnail.png")
        view.translatesAutoresizingMaskIntoConstraints = false
        accommodationImageStackView.addArrangedSubview(view)
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
    @IBAction func shareButtonTouched(_ sender: UIButton) {
        shareURL = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FkO2H7%2Fbtqz7KIU5pu%2FspCicSk0r44I5i5Fu7mRt1%2Fimg.jpg")
        let activityViewController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension AccommodationDetailViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage()
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return shareURL
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        
        metadata.title = "Spacious and Comfortable cozy" // 숙소이름 넣어줘야한다.
        metadata.originalURL = shareURL
        metadata.url = shareURL
        metadata.imageProvider = NSItemProvider(contentsOf: shareURL)
        metadata.iconProvider = NSItemProvider(contentsOf: urlInTemporaryDirForSharePreviewImage(shareURL))
        return metadata
    }
    
    func urlInTemporaryDirForSharePreviewImage(_ url: URL?) -> URL? {
        if let imageURL = url,
           let data = try? Data(contentsOf: imageURL),
           let image = UIImage(data: data) {

            let applicationTemporaryDirectoryURL = FileManager.default.temporaryDirectory
            let sharePreviewURL = applicationTemporaryDirectoryURL.appendingPathComponent("sharePreview.png")

            let resizedOpaqueImage = image.adjustedForShareSheetPreviewIconProvider()

            if let data = resizedOpaqueImage.pngData() {
                do {
                    try data.write(to: sharePreviewURL)
                    return sharePreviewURL
                } catch {
                    print ("Error: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
    
}

extension AccommodationDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        307 - 224 = 83
        let topHeaderViewHeight: CGFloat = 112
        let scrollViewOffset = 307 - (topHeaderViewHeight*2) // 83
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > scrollViewOffset {
            if scrollView.contentOffset.y > topHeaderViewHeight + scrollViewOffset {
                self.topHeaderView.alpha = 1
            } else {
                self.topHeaderView.alpha = (scrollView.contentOffset.y - topHeaderViewHeight) / scrollViewOffset
            }
        } else {
            self.topHeaderView.alpha = 0
        }
    }
}

extension UIImage {
    func adjustedForShareSheetPreviewIconProvider() -> UIImage {
        let replaceTransparencyWithColor = UIColor.black // change as required
        let minimumSize: CGFloat = 40.0  // points

        let format = UIGraphicsImageRendererFormat.init()
        format.opaque = true
        format.scale = self.scale

        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let imageSmallestDimension = max(imageWidth, imageHeight)
        let deviceScale = UIScreen.main.scale
        let resizeFactor = minimumSize * deviceScale  / (imageSmallestDimension * self.scale)

        let size = resizeFactor > 1.0
            ? CGSize(width: imageWidth * resizeFactor, height: imageHeight * resizeFactor)
            : self.size

        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            let size = context.format.bounds.size
            replaceTransparencyWithColor.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
