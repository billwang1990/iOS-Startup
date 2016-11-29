import RxSwift
import Alamofire


public struct NetworkAccessor {
    
    static let baseURLString = "Your base url"
    
    enum Router: URLRequestConvertible {
        typealias MyURLRequest = (path: String, parameters: [String: AnyObject])
        
        var method: Alamofire.HTTPMethod {
            switch self {
            default:
                return .get // .post
            }
        }
        
        var path : String {
            switch self {
                
            default:
                return ""
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let URL = Foundation.URL(string: NetworkAccessor.baseURLString)!
            var urlRequest = URLRequest(url: URL.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = 60
            urlRequest.allHTTPHeaderFields = ["Content-Type" : "application/json"]
            
            var json: [String: Any] = [:]
            
            switch self {
            default:
                break
            }
            print(">>>>>>\n 请求接口: \(path) \n 参数: \(json) >>>>>>\n")
            
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: [:])
        }
        
        func updateParameter(_ parameters: inout [String: AnyObject], key: String, value: AnyObject?) {
            if let v = value {
                parameters.updateValue(v, forKey: key)
            }
        }
    }
    
    static let NetworkManager: SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            baseURLString: .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        
        let manager = SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return manager
    }()
    
    static func request(_ url: URLRequestConvertible, shouldAutoHandleLogout: Bool = true) -> DataRequest {

        let acceptableStatusCodes = 200..<300

        return NetworkManager.request(url).validate { _, response, _ in
            if acceptableStatusCodes.contains(response.statusCode) {
                return .success
            } else {
                
                let failureReason = "\n Http status code error : \(response.statusCode)"
                if case 400...500 = response.statusCode {
                    //TODO: 
                }
                return .failure(NetworkAccessor.error(failureReason: failureReason))
            }
        }
    }
        
    static func cancelBackgroundTaskWhenTerminal() {
        NetworkManager.session.invalidateAndCancel()
    }
}

public extension NetworkAccessor {
    public static let Domain = "com.financeNetwork.error"
    public enum Code: Int {
        case genericError                    = -5000
        case objectMapError                  = -5001
    }
    
    static func error(_ domain: String, code: Int = NetworkAccessor.Code.genericError.rawValue, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
    
    static func error(_ code: Int = NetworkAccessor.Code.genericError.rawValue, failureReason: String) -> NSError {
        return error(NetworkAccessor.Domain, code: code, failureReason: failureReason)
    }
}
