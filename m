Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC9C38A02
	for <linux-s390@archiver.kernel.org>; Sat, 29 Oct 2022 00:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJ2APg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Oct 2022 20:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ2APe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Oct 2022 20:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8835766A53;
        Fri, 28 Oct 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55EF562B35;
        Sat, 29 Oct 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B42AFC433C1;
        Sat, 29 Oct 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667002527;
        bh=DT39x58SA98DxPQuDM8lZRU/NhAMZ/UEZGxOyCwD18k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z9YsM0ttjROBafXYbEsov+V/sjbfg9SEarMgarIFUkuEMtgA0DEC7kbxDA/C8Qr3Z
         4y7AtfOE9TT3wgAvW9wIeE59jb9MCIXbqOThyUAzKQ6AGgN0ZCSbEmE5o7kBBf6XOs
         EPBE1epkkmpPKIVxV6qpgn303pFswtui5vMqt4OtTnkYirqFRxhW2LaGfpcOsoDXRx
         ybmn6EGUAh4nTsI6CfcR8ebL8WtkpCyrX/N3du01FgyBkFz7vgeAtJfK17vUH9+eTK
         rSg439zhwlDRnIcgbiv6Vv9l8N0zYI1wiqj/j5uqPEs+cRfAPikDyPWmxFa92CUL+x
         OoB6DDQ4CR6uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FF9BC41676;
        Sat, 29 Oct 2022 00:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01666989278-ext-6142@work.hours>
References: <your-ad-here.call-01666989278-ext-6142@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01666989278-ext-6142@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-3
X-PR-Tracked-Commit-Id: e38de4804421b064a9c73c5a9b7f3df96b863e4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 576e61cea1e4b66f52f164dee0edbe4b1c999997
Message-Id: <166700252765.12440.3406754733571646460.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Oct 2022 00:15:27 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 22:34:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/576e61cea1e4b66f52f164dee0edbe4b1c999997

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
