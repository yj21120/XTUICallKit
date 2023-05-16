//
//  LottieManager.swift
//  XTUICallKit
//
//  Created by Yuj on 2023/5/15.
//

import Foundation
import ZipArchive
import Moya
import Lottie

@objcMembers public class LottieManager:NSObject {
    let filepath = NSHomeDirectory() + "/Documents/LottieFile"
    public static let shared = LottieManager()
    override init() {
        super.init()
        if FileManager.default.fileExists(atPath: filepath) {
            print("礼物 目录存在")
        }
        else{
            try! FileManager.default.createDirectory(atPath: filepath,
                                                     withIntermediateDirectories: true, attributes: nil)
        }
        print(filepath)
    }
  public func loadLocalAnimationView(name:String)->AnimationView{
    let view = AnimationView(name: name)
    view.loopMode = .loop
    view.play()
    return view
  }
  public func loadAnimationView(jsonPath:String,searchPath:String?) -> AnimationView{
    let view = AnimationView(filePath: jsonPath)
    if let path = searchPath{
      view.imageProvider = BundleImageProvider(bundle: .main, searchPath: path)
    }
    return view
  }
  public func playLottieView(view:AnimationView,completion:@escaping ((_ b:Bool)->Void)){
    view.play { bool in
      completion(bool)
    }
  }
    /// 加载lottie特效
    /// - Parameters:
    ///   - giftId: 特效id
    ///   - downloadurl: 特效下载地址
    ///   - animationresult: 特效 images目录
  public func loadBundleProvider(name:String , downloadurl:String ,animationresult:@escaping ( _ jsonfullpath:String?,_ searchPath:String?) -> Void ) {
        let fullpath = filepath + "/\(name)/data.json"
        let imgprovider = filepath + "/\(name)/images"
        var jsonpath:String?=nil
        if FileManager.default.fileExists(atPath: fullpath) {
            jsonpath = fullpath
            if  FileManager.default.fileExists(atPath: imgprovider)
            {
                animationresult(jsonpath,imgprovider)
            }else{
                animationresult(jsonpath,nil)
            }
        }
            //网络下载 并解压
        else{
            let  giftpath = filepath + "/\(name)"
            let assetName =  "\(name)"
            jsonpath = giftpath + "/data.json"
            let  urladdress  = downloadurl
            //通过Moya进行下载
            MyServiceProvider.request(.downloadGiftLottie(downloadurl:urladdress,giftDirectoryName: assetName)) { result in
                switch result {
                case .success:
                    let localLocation: URL = DefaultDownloadDir.appendingPathComponent(assetName)
                    print("下载完毕！保存地址：\(localLocation)")
                    if  urladdress.contains(".zip") {
                        let  urlpath = URL.init(fileURLWithPath: self.filepath + "/\(name).zip" )
                        do {

                            try       FileManager.default.createDirectory(atPath: self.filepath + "/\(name)", withIntermediateDirectories: true, attributes: nil)

                            let ziptool  = ZipArchive.init()
                            if  ziptool.unzipOpenFile( self.filepath + "/\(name).zip") {
                                let  res =    ziptool.unzipFile(to: giftpath, overWrite: true)
                                if !res {
                                    ziptool.unzipCloseFile()
                                }

                            }
                            //                        let  zipurl =  try Zip.unzipFile(urlpath, destination: URL.init(fileURLWithPath: giftpath), overwrite: true, password: nil)
                            //得到正确的资源包  12312/ data images
                            if  FileManager.default.fileExists(atPath: imgprovider)
                            {
                                animationresult(jsonpath,imgprovider)
                            }else{
                                animationresult(jsonpath,nil)
                            }

                            //                        print(zipurl)
                        } catch (let err) {
                            print("解压失败")
                            animationresult(nil,nil)

                        }
                    }

                    else if urladdress.contains(".json") {
                        do {

                            try       FileManager.default.createDirectory(atPath: self.filepath + "/\(name)", withIntermediateDirectories: true, attributes: nil)
                            try  FileManager.default.moveItem(atPath: self.filepath + "/data.json", toPath: giftpath + "/data.json")

                            animationresult(jsonpath,nil)


                            //                        print(zipurl)
                        } catch (let err) {
                            debugPrint("文件出错\(err)")
                            animationresult(nil,nil)

                        }

                    }


                case let .failure(error):
                    print(error)
                    animationresult(nil,nil)
                }
            }
        }
    }


}

//MARK:单独组件处理下载


//初始化请求的provider
let MyServiceProvider = MoyaProvider<DownLoadService>()

//请求分类
public enum DownLoadService {
    case downloadGiftLottie(downloadurl:String,giftDirectoryName:String) //下载文件
}

//请求配置
extension DownLoadService: TargetType {
    public var path: String {
        return ""
    }
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .downloadGiftLottie(let  url , _ ):
            return URL.init(string: url)!
            
        default:
            return URL(string: "http://www.baidu.com")!
        }
    }
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .downloadGiftLottie(let  downloadurl ,let saveName):
            var localLocation: URL!
            if downloadurl.contains(".zip") {
                localLocation = DefaultDownloadDir.appendingPathComponent(saveName+".zip")
            }else if downloadurl.contains(".json") {
                
                localLocation = DefaultDownloadDir.appendingPathComponent("data.json")
            }
            //
            
            let downloadDestination:DownloadDestination = { _, _ in
                
                return (localLocation, .removePreviousFile) }
            return .downloadDestination(downloadDestination)
        }
        
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [.removePreviousFile])
}

//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    
    return  URL(fileURLWithPath: LottieManager.shared.filepath)
}()
