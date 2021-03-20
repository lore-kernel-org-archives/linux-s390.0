Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B50C433E0
	for <linux-s390@archiver.kernel.org>; Sat, 20 Mar 2021 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1401A61986
	for <linux-s390@archiver.kernel.org>; Sat, 20 Mar 2021 00:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCTAJi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTAJV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E041F6198B;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198960;
        bh=kYfmnH5SjVc8fAC/BUvrGryxHOoTPkOeOjgYKsN4IWg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f0bg7TFEfNvg0epPib6Q0itNW6XXiFALLomLa5QzFV/TE5CruS3K2mo+qDh2OS4bw
         +Sd4+15DZho6LI/ocgKrcHP0AKmfp77Q8T6BsRBdfMTYgYJjaYy6M6WtA96+xQN+Ju
         4D2y7+eDozW3tl8InSzsU75lvYey/iR1KkyAlwI+N9jyImuFgQq3N1H6H9WGgHD0fq
         MNu++nS7Kl0h61LhbThFq0nLB7JvL1SxInNR/XXEwtZbpIMhak/gnbOHol5pIMeiAo
         kWbU+daTC0ngOdR0N7Fpwl9+mS36dDVZdihxHBnZbBuxzVGoC3LqqEIBQ175jye4Rb
         bq5cKWOdTRF9g==
Subject: Re: [GIT PULL] s390 updates for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YFTvvrxm7BxAPIP5@osiris>
References: <YFTvvrxm7BxAPIP5@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFTvvrxm7BxAPIP5@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-4
X-PR-Tracked-Commit-Id: 0b13525c20febcfecccf6fc1db5969727401317d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bfea141b3d26898705704efd18401d91afcbb0a
Message-Id: <161619896086.24257.10163938151058929673.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:20 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 19:38:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bfea141b3d26898705704efd18401d91afcbb0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
