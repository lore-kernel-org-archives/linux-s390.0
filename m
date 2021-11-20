Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FDC433EF
	for <linux-s390@archiver.kernel.org>; Sat, 20 Nov 2021 19:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKTTXV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 20 Nov 2021 14:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhKTTXU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 20 Nov 2021 14:23:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2591C60D42;
        Sat, 20 Nov 2021 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637436017;
        bh=cpLLDSqsizXcdLW6qg4VngWyCD70N3qZNdPRoy4jITI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VLuQAPICkhZGJYXYVOn5EIZbljNWvLswwmoN2ZCwBRnV/1u5ii90kIe08MV69n+sC
         BfKvyyrrZDmHQy/rY98wrZyKqIBQaLJxVQK//431sMu+Yvw4sS3VcGLqAdRPEd6qra
         8NgHMWBnl6JUtJXqZkA9dvYkmePNLN6w+Yo41AX2sSnJis/kOIrrhlQslOTgvUdNMB
         t2PsCvZD4LXZ6ufNM3YNYW6pEAm/Dtq8+AbkYIrBo1MxxnbPSVNsrYZr/Auon+krY8
         eYvBjDJ6/spQvgP071tS6QjYcZopVXC8RBzFIQxPNM+VvcwSD8Zk67SApfH0EHdAO4
         4XyC+jLesmVAw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1ECCA604EB;
        Sat, 20 Nov 2021 19:20:17 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZkKklfvwaRkxwqz@osiris>
References: <YZkKklfvwaRkxwqz@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZkKklfvwaRkxwqz@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-3
X-PR-Tracked-Commit-Id: 890e3dc8bb6ee630870560c34054692f7a45da42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b38e2fb70b6682fd8f8cd24c03597e27fec3df3
Message-Id: <163743601711.28722.10582088359602652887.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Nov 2021 19:20:17 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 20 Nov 2021 15:47:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b38e2fb70b6682fd8f8cd24c03597e27fec3df3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
