Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B510C433ED
	for <linux-s390@archiver.kernel.org>; Thu,  6 May 2021 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFED601FE
	for <linux-s390@archiver.kernel.org>; Thu,  6 May 2021 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEFVmd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 May 2021 17:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEFVmb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 6 May 2021 17:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CE5C66121F;
        Thu,  6 May 2021 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620337290;
        bh=aon5tyciRmnhlrPwOR4xGGYVPi+d1ZywjVgHtx+qSt8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=chqFsth23oSpPpYMpIqOkcV/5/XiXwVyPQpz/jixUOYXTHOS/P6u7ytDU2tKx68jK
         aU4bFL3MBjjXAveeKtr5lIpjD/Xl7sWWcWeQ1eqkL8/wJWpbi0fqubi4RzIhpDCNOC
         AzZ+B8MfhgFMlUH0ampHT/4zHmI7hkoR62tlR4kE7rMFDuw/Rv8i8HyayaUFSUWjOV
         E50yaVvyc+IwuAay6vCHZrFV6/Dx5+A4RNU7CJGswDrDIX4NJhQw78r+8q3Jmdroe8
         OR1QLZvsTl+024jI7b7FXkNTNDNmlYhcuUG0FHe2jbn3gRuQ1yY8WIm9pQ81BzXXRe
         qdOyFnOjob3HA==
Subject: Re: [GIT PULL] more s390 updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJRNygc8ryOitlmO@osiris>
References: <YJRNygc8ryOitlmO@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJRNygc8ryOitlmO@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-2
X-PR-Tracked-Commit-Id: b208108638c4bd3215792415944467c36f5dfd97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e48661230cc35b3d0f4367eddfc19f86463ab917
Message-Id: <162033729070.2467.16681464767107026046.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 21:41:30 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Thu, 6 May 2021 22:12:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e48661230cc35b3d0f4367eddfc19f86463ab917

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
