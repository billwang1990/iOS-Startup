//
//  Array+Random.swift
//  Pomodoro
//
//  Created by Yaqing Wang on 16/5/28.
//  Copyright © 2016年 billwang1990.github.io. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> Element {
        return self[Int(arc4random()) % self.count]
    }
}
