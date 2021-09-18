Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194BCC433F5
	for <linux-s390@archiver.kernel.org>; Sat, 18 Sep 2021 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62FD61051
	for <linux-s390@archiver.kernel.org>; Sat, 18 Sep 2021 19:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhIRTyF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 18 Sep 2021 15:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238842AbhIRTyE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Sep 2021 15:54:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D1CF2610A5;
        Sat, 18 Sep 2021 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631994760;
        bh=pw1JqnSHLWuvVx5pWr5i7hCgQQQ09ZiPklcTLOV9vxo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Djv/RM0ULpLANUSgxw9VxmHwGlgo/8ke/sEnXTx5NBc+LRO9P2oFwgQ9YY5uEatUi
         XwIG+qKk3DlJYD6zrmLayX2OoXPQQAPuoEnWzzNua/yS24OH/gBCHNuXheTJFwkr3r
         j4tTY5hddfg7SCJlkgJYCSwMZtUBcKxMXWynIjPa41GgOJr5NmojDitvREy3tW10Aa
         zZmkmPLt+SOu4ILkHxJ3jGKKtClbM7lBNBWEbd0u5BnUfwzcRA8V0ycBDYAFV+7p++
         c1Wf58UF5nkuYFiNwCnOoFxHDwhcJa454aNnQA/4DvCf60rQGabsoxrxBoI89EikmP
         nDKZIymgvbyUQ==
Subject: Re: [GIT PULL] s390 updates for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01631958563-ext-0235@work.hours>
References: <your-ad-here.call-01631958563-ext-0235@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01631958563-ext-0235@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-3
X-PR-Tracked-Commit-Id: f5711f9df9242446feccf2bdb6fdc06a72ca1010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93ff9f13be91c5f36bb3e5d23237702155deae74
Message-Id: <163199476080.362.16314800399703535644.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Sep 2021 19:52:40 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 18 Sep 2021 11:49:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93ff9f13be91c5f36bb3e5d23237702155deae74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
