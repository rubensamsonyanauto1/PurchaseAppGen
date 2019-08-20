import UIKit
import RxSwift
import RxCocoa

extension PhotoCamera {
    struct ViewEvents {
        let enabled: Observable<Bool>
    }
}

final class PhotoCameraViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var viewModel: PhotoCameraViewModel!
    private var makeViewModel: PhotoCamera.ViewModelFactory!
    private var events: PhotoCamera.ViewEvents {
        return .init(
            enabled: rx.visible.asObservable()
        )
    }

    private lazy var mainView: UIView = {
        UIView {
            $0.style(backgroundColor: .white)
        }
    }()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    func set(makeViewModel: @escaping PhotoCamera.ViewModelFactory) {
        self.makeViewModel = makeViewModel
    }

    private func setupViewModel() {
        viewModel = makeViewModel(events)
        viewModel.viewState.drive(rx.state).disposed(by: disposeBag)
    }
}

extension PhotoCameraViewController: Setupable {
    func setup(with state: PhotoCamera.ViewState) {
        title = state.title
    }
}