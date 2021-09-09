Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5137C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 20:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01C96113E
	for <linux-s390@archiver.kernel.org>; Thu,  9 Sep 2021 20:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIIUFF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233316AbhIIUFF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 9 Sep 2021 16:05:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 795226115B;
        Thu,  9 Sep 2021 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631217835;
        bh=tTeShPZNcQpLw3rDTtHBrAJoKpz1lAI4gsU1dYx0alI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QRUlnlQWBcp1f/kfLyhPzVp21FfXes3/u2giiyckcF/xGC3bRKMNKALTyC1S2pcUJ
         AUtvWc+jJLAkAH6IdF2J6m18z+AkMoUB3hsPJW1Dlw0CU4YSwml1VDEAN5cReFbIxS
         iFUsWAQQKyshMXGqJVGERbKSgWs0Tr3k+1S/kjP9D+sTb1kMiyknctMJSmDqc2yOGe
         iDetrHyzchpkpooHOxei/rA6uAzOwsjZSt9nr8w7WzTWkNsycuHnLmPvYaPQIauU30
         OGqgC1TZ16+3+Fi6ZwYPjT9zTeF/GP9vbPDibr8gM5GMGLRrhvF+q0XKzuhVbWPChu
         k2L+w25U+A68g==
Subject: Re: [GIT PULL] second batch of s390 updates for 5.15 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YToCkrOYXKNTXqar@osiris>
References: <YToCkrOYXKNTXqar@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YToCkrOYXKNTXqar@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-2
X-PR-Tracked-Commit-Id: bb9c14ad267d25dd77ceccbcfd69804bdb7240f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f154c806676ad7153c6e161f30c53a44855329d6
Message-Id: <163121783535.16320.12896534656135963682.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:03:55 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 14:48:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f154c806676ad7153c6e161f30c53a44855329d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
