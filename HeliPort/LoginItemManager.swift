//
//  LoginItemManager.swift
//  HeliPort
//
//  Created by SS on 7/14/20.
//  Copyright © 2020 OpenIntelWireless. All rights reserved.
//

import Foundation
import ServiceManagement

class LoginItemManager {

    private static let launcherId = Bundle.main.bundleIdentifier! + "-Launcher"

    public class func isEnabled() -> Bool {

        guard let jobs =
            (SMCopyAllJobDictionaries(kSMDomainUserLaunchd).takeRetainedValue() as? [[String: AnyObject]])
            else {
                return false
            }

        let job = jobs.first { $0["Label"] as? String? == launcherId }

        return job?["OnDemand"] as? Bool ?? false
    }

    public class func setStatus(enabled: Bool) {
        SMLoginItemSetEnabled(launcherId as CFString, enabled)
    }
}
