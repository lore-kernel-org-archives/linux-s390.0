Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FA0C433FE
	for <linux-s390@archiver.kernel.org>; Thu, 14 Apr 2022 19:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiDNTXB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbiDNTWe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Apr 2022 15:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F1ECB1A;
        Thu, 14 Apr 2022 12:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4AB61D2E;
        Thu, 14 Apr 2022 19:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EFCDC385BA;
        Thu, 14 Apr 2022 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649964001;
        bh=V3fkQZjsVmv/zUnnTAb9hxt49weI+/ZdD2USNH1GJ5s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bcKDwrVj8G1+DY4hkrcJhVerBOBunsvyUjDQY0QFbmV7gX3EbfHWtJuxopsDz02ef
         VV/wktXMqJJOW1uqY+jHgPezHOQcHu0UnVxAj7Jquj0NDHfk9g6mc0aOb0VwUytYLW
         FqzjpgvLDGH2DzYUSSaAUtew1UTntnn9ThZxhFtFsKvmgH8vwyD9CrOMR4K+bJTygy
         HMnyj4RJlHfba069+8xaSwbqroe/GiToYknYFtR9B8ozj3WhcMxERPjiooyTj82yKv
         49145mz9ZN/X0N7aPz77tqGiR/Z2N5SudYIgGWV3L/zgbQBFoi16sGs1/ocmO0GO6E
         /KgsnW2ilp6rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA180E8DD69;
        Thu, 14 Apr 2022 19:20:00 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlhMA5GB1dkKyu8k@osiris>
References: <YlhMA5GB1dkKyu8k@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlhMA5GB1dkKyu8k@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-3
X-PR-Tracked-Commit-Id: c68c63429319a923a3f23db64810ba608f5d20f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115acbb56978941bb7537a97dfc303da286106c1
Message-Id: <164996400095.26481.16517230950101833203.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 19:20:00 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Thu, 14 Apr 2022 18:29:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115acbb56978941bb7537a97dfc303da286106c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
