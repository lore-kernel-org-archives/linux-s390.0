Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5D2C433EF
	for <linux-s390@archiver.kernel.org>; Sat,  5 Mar 2022 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiCEUOu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 5 Mar 2022 15:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiCEUOt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 5 Mar 2022 15:14:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76150B15;
        Sat,  5 Mar 2022 12:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 182CDCE09EA;
        Sat,  5 Mar 2022 20:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5412AC340EC;
        Sat,  5 Mar 2022 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646511234;
        bh=iy1cqsoOPXz4Qol71NxLMoDntWZr90U/+2tLasdsbtA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CB5y6bcB4tofV++kMy9Zj+UA4D9CQ1KrsFw4AtOTqpIY8FXE+Ba5xb46tbrHk5B/X
         bA+B46He/1/yJ5ysr2CBMf6WF+iSWCZtJfOxOcwzwXMcCZatyA2/ig3wjR/5UKWDoR
         Lw+BWls3lwTG2X9Hc6wowGLnK5hcvM4tqitxnBCVkpoMdMMWIg46qYD5mKCOzYGBTe
         fX99oIDCyXfBPwxzFOIGoIoaTFK3xKpUQdfyOlg0JxxHT/2wRlp5EKE02efpaMz/hV
         SVYRY6HsDohrBTAAscKuI1I1O4d7rqQ5kvdDcpXvMKxkWCuq0ILHMHvojsxSBgi/X6
         ASOTACJ0u1rdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 420CEE7BB18;
        Sat,  5 Mar 2022 20:13:54 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01646480222-ext-8975@work.hours>
References: <your-ad-here.call-01646480222-ext-8975@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01646480222-ext-8975@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-5
X-PR-Tracked-Commit-Id: c194dad21025dfd043210912653baab823bdff67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9026e19a44d965793d25e7a02b0d6c1bcafd8f5
Message-Id: <164651123426.11603.13575761014802884057.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Mar 2022 20:13:54 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 5 Mar 2022 12:37:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9026e19a44d965793d25e7a02b0d6c1bcafd8f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
