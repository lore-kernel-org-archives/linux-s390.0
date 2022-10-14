Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0760C43217
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 19:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNTNw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiJNTNv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 15:13:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603F190E78;
        Fri, 14 Oct 2022 12:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F7CBB81BE1;
        Fri, 14 Oct 2022 19:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB92BC433D7;
        Fri, 14 Oct 2022 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665774827;
        bh=hlFMWjvsQ24VDh+KDkWAPzANh0Se0fZXQ4fRsPLBKEE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SKhW9MUvL44o4VI7U7uQ0U4SuLfCa8mTW59zsdb683K/5OhXpt+GLthGTZd6a7aPf
         HlKscmz+Mh7edaUoXcEzmSsbnhpXYz8Nx1VC2zGuq5GI4mVBT5RcbxyJNY3Im3vQ6+
         j+rAEEk3Iu7wXs5b8J4aLbbxQYygg1cg6SGUz9jZm/C/lE8FP4vNCvO+xo/AhbMcnN
         z3pzSaDoABo99YFvARvd2rNXgq4iE3c0AlvkADp3wOzJSCkQJ0VHtSMs8uSk6ksYx/
         ljY7arPcHFt8Q8pTlfFRo/bwdUa5IvoiDP+/OJOxOYZ5Rozf1L1FuJ0LP41/XXG8xl
         cd0UNZzjA8uEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7B12E4D00A;
        Fri, 14 Oct 2022 19:13:47 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 6.1 merge window #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01665770095-ext-6515@work.hours>
References: <your-ad-here.call-01665770095-ext-6515@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01665770095-ext-6515@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-2
X-PR-Tracked-Commit-Id: bf18140d30541c2c1e5c0f57879634f3d0d04912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebdca8ecc31b07385cd83200532522bd5d95f02c
Message-Id: <166577482780.24477.6052260993991246261.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:13:47 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 19:54:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebdca8ecc31b07385cd83200532522bd5d95f02c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
