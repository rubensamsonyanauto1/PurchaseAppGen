import Foundation

struct BasicTemplateNamespace: Template {
    let fileNameSuffix = ""
    let content =
        """
        import Model
        import RxSwift
        import EventResponder

        enum $NAME$ {} //namespace

        extension $NAME$ {
            struct Context {
                let translator: Observable<Translator>
            }

            struct InputData {
            }

            enum Event: EventType {
            }

            enum PresentEvent: EventType {
                case present(InputData)
            }
        }

        """
}
