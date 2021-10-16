Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF1AC433F5
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92B261027
	for <linux-s390@archiver.kernel.org>; Sat, 16 Oct 2021 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhJPQZa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 16 Oct 2021 12:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240696AbhJPQZ3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Oct 2021 12:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6EF4C61152;
        Sat, 16 Oct 2021 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634401401;
        bh=r7t503gxFj1xxHG0CUwtoN42IAhX9Uv6FPI7M0caQJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EtUnt4cD53ulVvioGm+dSUEbVHcweVU0zmm8sutNLYK1qP7sxR5weN4UqQeOtXRQe
         8u0JwRDQTLslhXHA8Ldy2IImAwcL1k5aFwv46ou7cdZbao1XcLRJ+9FwUpJ7/QErro
         7tQuis40nBrHqT1C0gz3pXLi0TnmWFKyuz4d/YsFa+/ZS7T4E9ULK6w/X8MdWSaCWC
         9Q0RdAEEhNKAn8CrqI4JL+tUteZbOzaN7JTeqU35nwwei+n/BJVMf9sT7rE4NsTmD+
         gdLuWUYXtjdrBUin4wAP+OOW8GzTbV97+2pwT67ljFnUykf51vOLOpAZMXEb4NUoUm
         0UMEy3PbGI9fw==
Subject: Re: [GIT PULL] s390 updates for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01634376368-ext-7035@work.hours>
References: <your-ad-here.call-01634376368-ext-7035@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01634376368-ext-7035@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-6
X-PR-Tracked-Commit-Id: 8b7216439e2e2128f6f1a19ad4b6be94d8b0e23d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 304040fb4909f7771caf6f8e8c61dbe51c93505a
Message-Id: <163440140141.26929.4763962049869951934.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 16:23:21 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 16 Oct 2021 11:26:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/304040fb4909f7771caf6f8e8c61dbe51c93505a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
