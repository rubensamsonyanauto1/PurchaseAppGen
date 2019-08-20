import Foundation

struct BasicTemplateViewController: Template {
    let fileNameSuffix = "ViewController"
    let content =
        """
        import UIKit
        import RxSwift
        import RxCocoa

        extension $NAME$ {
            struct ViewEvents {
                let enabled: Observable<Bool>
            }
        }

        final class $NAME$ViewController: UIViewController {

            private let disposeBag = DisposeBag()
            private var viewModel: $NAME$ViewModel!
            private var makeViewModel: $NAME$.ViewModelFactory!
            private var events: $NAME$.ViewEvents {
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

            func set(makeViewModel: @escaping $NAME$.ViewModelFactory) {
                self.makeViewModel = makeViewModel
            }

            private func setupViewModel() {
                viewModel = makeViewModel(events)
                viewModel.viewState.drive(rx.state).disposed(by: disposeBag)
            }
        }

        extension $NAME$ViewController: Setupable {
            func setup(with state: $NAME$.ViewState) {
                title = state.title
            }
        }

        """
}
