Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28824CE7A89
	for <linux-s390@archiver.kernel.org>; Sat, 23 Sep 2023 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjIWSZY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 23 Sep 2023 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjIWSZX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 23 Sep 2023 14:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C915127;
        Sat, 23 Sep 2023 11:25:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECAC8C433C8;
        Sat, 23 Sep 2023 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695493517;
        bh=jR1PYwfjtifeo+aidOdDqlmhMBznbf6iGJEwLA+1+D0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AuVrabsmqx4VgV4p0SlBr8QozZK8rSFdoeEUzemqY0c3oprwSn4Fjli4Oj+KaBCo8
         6L9SXPiOVULkQ2Jr4AVatQNEleG/jzopiUxYpqcviTVGcRJ647OBsWizZp88Lmoy+9
         O2VnY2UvhjJtVHjMIt4cr0pxpMOoC/46x5LFnzlZ78v713aFRoCZGs68S+TU5UGVXB
         pYOZnxVX5VxQvdUUJ5nofgcSLBxYx0Z5/qZfbKK5u66Wj34xLj8/6Gd27Eceif+JHm
         RucD1WPq3HuZFjtso97oa5O+CellkD7zuY9LafjWG3QeSUznzd+Uhak2wR8nhTyTKP
         W9B6FGVXPe+CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAD0FC561EE;
        Sat, 23 Sep 2023 18:25:16 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01695459401-ext-1349@work.hours>
References: <your-ad-here.call-01695459401-ext-1349@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01695459401-ext-1349@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-3
X-PR-Tracked-Commit-Id: 5c95bf274665cc9f5126e4a48a9da51114f7afd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e3d39118460730ec007cc8a492e5add1c2a3cb9
Message-Id: <169549351689.14827.10011904236553550024.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Sep 2023 18:25:16 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 23 Sep 2023 10:56:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e3d39118460730ec007cc8a492e5add1c2a3cb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
