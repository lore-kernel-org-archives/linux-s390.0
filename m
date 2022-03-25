Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC4BC433FE
	for <linux-s390@archiver.kernel.org>; Fri, 25 Mar 2022 17:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbiCYRTz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbiCYRTs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Mar 2022 13:19:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DCFEACAC;
        Fri, 25 Mar 2022 10:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 235A6B82989;
        Fri, 25 Mar 2022 17:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E78C6C36AE5;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228683;
        bh=J5SHTUx7HbCLDFysMvr2N/lRGQ6+lBAK1iOylvgyXR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q9Fe3+Cw29OGNQviwwcD7/zd1KgnQtvZzaMhfueqABLsz0WEVDM0Hc4z/c+aOIq6V
         sQa5cBfdri9hNYGU4GaWWRCwM9j4CyTKFc79IsBZPfW4OCEuUkEqsqDKkCyI4WPncW
         vMFYsug00KJrWLw5WrEhnFhQp+6+kVe1jcDcNmLi7D8Cnx+oWfdfNgV1amEuxFmU+W
         Q3km4MpUxjoS/g+LEOFV9XRY2Ywqs9ekKZH2mD6UjyPOGM+YpXh/MIi1zPiUpQLxD8
         3WA13qpuusCUdijBtfWN1mWF2c7VDZvo0J2gXezHfab3V+/hfLF1WZ1n3fEhTBdWBo
         /+xORhphKcf3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4338E6BBCA;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.18 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01648224608-ext-2557@work.hours>
References: <your-ad-here.call-01648224608-ext-2557@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01648224608-ext-2557@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-1
X-PR-Tracked-Commit-Id: c65f677b62d6180cc174e06f953f7fe860adf6d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d710d370c4911e83da5d2bc43d4a2c3b56bd27e7
Message-Id: <164822868386.13188.3044651117362946813.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 17:18:03 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 17:10:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d710d370c4911e83da5d2bc43d4a2c3b56bd27e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
