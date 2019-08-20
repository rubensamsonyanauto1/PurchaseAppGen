import RxSwift
import RxCocoa
import Model
import EventResponder

protocol PhotoCameraViewModel {
    var viewState: Driver<PhotoCamera.ViewState> { get }
}

extension PhotoCamera {
    struct ViewState {
        let title: String
    }

    struct ViewModel: PhotoCameraViewModel {
        let viewState: Driver<ViewState>

        init(context: Context, viewEvents: ViewEvents, data: InputData, eventResponder: RxEventResponder) {
            let helper = Helper(context: context, viewEvents: viewEvents, data: data, eventResponder: eventResponder)

            viewState = helper.makeViewState()
            eventResponder.handle(event: helper.makeEvents())
        }

        private final class Helper {
            private let context: Context
            private let viewEvents: ViewEvents
            private let eventResponder: RxEventResponder
            private let data: InputData

            init(context: Context, viewEvents: ViewEvents, data: InputData, eventResponder: RxEventResponder) {
                self.context = context
                self.viewEvents = viewEvents
                self.eventResponder = eventResponder
                self.data = data
            }

            func makeViewState() -> Driver<ViewState> {
                return Observable.combineLatest(
                        context.translator,
                        Observable.stub(.just(()))
                    )
                    .map { translator, _ in
                        ViewState(
                            title: translator.translate("TitleKey") // TODO: Add title key here
                        )
                    }
                    .asDriver(onErrorDriveWith: .never())
            }

            func makeEvents() -> Observable<Event> {
                return .never() // Observable<Event>.merge()
            }
        }
    }

    typealias ViewModelFactory = (ViewEvents) -> PhotoCameraViewModel
}