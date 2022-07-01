Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FEC43334
	for <linux-s390@archiver.kernel.org>; Fri,  1 Jul 2022 18:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGAS1t (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAS1s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 14:27:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342027CCB;
        Fri,  1 Jul 2022 11:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA5EB82CF1;
        Fri,  1 Jul 2022 18:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86A9FC341C6;
        Fri,  1 Jul 2022 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656700065;
        bh=8sIslhGMBS7d+Sc6M22c+J6/dd4vq7cVgAEcf1sWHcs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ubCn8XgzNt/qPkU16WmZROOfjmB/AbJnbAC9p6VfUhhPkfNKwT/oDi/7lFUlthURM
         kJ7dZVUp5zofSRTV7VVz451hv4KrYeQc+DyGr+yHZ8wbeS8JFdc39peLndWdK2JTXb
         eq8n9hc1NVS3QZtAupZPNmG8UTUF4VH5TlHEV59I2F3NWmqUbtHIUMTs4xlOwP+m7G
         REjr8rrvUijPxJutMzWN7STnfuR4kP/BYR2JLdj27pTE+tefznfL4zwPU8otgRUnUQ
         wZPLQzxold312yFbKR+U2PM7VpLtudZ9qwJ+BRssrWDTINPeDp9TKcEnM3GHDVbUlj
         Lj4cjcZ24J0mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72C65E49BB8;
        Fri,  1 Jul 2022 18:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yr69Mr39dc2xRygV@tuxmaker.boeblingen.de.ibm.com>
References: <Yr69Mr39dc2xRygV@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yr69Mr39dc2xRygV@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-5
X-PR-Tracked-Commit-Id: d7d488f41b41a1b7a1df3c74f2f65eb4585f5d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cec84e7547d3f95b3fa4ded1618cb43d5d98a76a
Message-Id: <165670006546.28259.10677158995220436426.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:27:45 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 11:24:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cec84e7547d3f95b3fa4ded1618cb43d5d98a76a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
