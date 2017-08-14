//
//  BaseAlertViewComponent.swift
//  AlertViewDemo
//
//  Created by leecong on 2017/8/9.
//  Copyright © 2017年 leecong. All rights reserved.
//

import UIKit
/**
 * 视图组件协议
 */
@objc protocol BaseAlertViewComponent {
    @objc optional func initComponent()
}

// MARK: 头部组件
class BaseAlertViewComponentHeader: UIView, BaseAlertViewComponent {
    lazy var labTitle : UILabel = UILabel()
    
}
// MARK: 内容组件
class BaseAlertViewComponentContent: UIView,BaseAlertViewComponent {
    
}
// MARK: 底部组件
class BaseAlertViewComponentFooter: UIView,BaseAlertViewComponent {
    
}

// MARK: alertViewAction
class AlertAction: NSObject {
    typealias action = () -> Void
    /**
     * alert按钮的样式
     */
    enum Style {
        case normal,cancle,destructive,custom(color:UIColor)
        /** 样式的颜色*/
        func styleColor()-> UIColor{
            switch self {
            case .normal:
                return .blue
            case .cancle:
                return .red
            case .destructive:
                return .gray
            case let .custom(color):
                return color
            default:
                return .blue
            }
        }
    }
    var style : Style = .normal
    var title : String?
    var action : action?
    fileprivate var actionSequence : Int = 0
    lazy fileprivate var button : UIButton = UIButton()
    
    
    override init() {
        super.init()
    }
    
    convenience init(style: Style,title: String,action : @escaping action) {
        self.init()
        self.style = style
        self.title = title
        self.action = action
    }
    
    
    func exportButton() -> UIButton{
        button.setTitle(title ?? String.init(format: "按钮%d", actionSequence), for: .normal)
        button.setTitleColor(style.styleColor(), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }
    
    @objc fileprivate func buttonAction()-> Void{
        if self.action != nil {
            self.action!()
        }
    }
}


/**
 * 弹出视图容器
 *
 */
enum AlertViewShowPosition {
    case top,mid,bottom
}
/** 按钮排列方式*/
enum AlertViewActionsAlign {
    case vertical,horizontal
}
/** alertView protocol*/
protocol BaseAlertViewProtocol :BaseAlertViewComponent {
    var header : BaseAlertViewComponentHeader?{get set}
    var content : BaseAlertViewComponentContent?{get set}
    var footer  : BaseAlertViewComponentFooter?{get set}
    var actions : [AlertAction]?{get set}
    
    //-------------------------------------------//
    /** 视图位置*/
    var position : AlertViewShowPosition{get set}
    /** 点击背景关闭*/
    var isCanTouchBack : Bool{get set}
    /** 显示的window*/
    var showWindow : UIWindow?{get set}
    /** 右上角显示关闭按钮*/
    var isRightTopCloseBtnAviliable : Bool{get set}
    /** 自动关闭*/
    var timeToClose : CGFloat{get set}
    /** 按钮对齐方式*/
    var actionAlign : AlertViewActionsAlign?{get set}
    
    // MARK: 0.0
    func add(acs:[AlertAction]) -> Void
    func loadComponents() -> Void
    func show(window : UIWindow) -> Void
    
}











