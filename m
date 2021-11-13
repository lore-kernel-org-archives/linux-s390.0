Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D447C433EF
	for <linux-s390@archiver.kernel.org>; Sat, 13 Nov 2021 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0226C60462
	for <linux-s390@archiver.kernel.org>; Sat, 13 Nov 2021 19:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhKMTSM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 13 Nov 2021 14:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236067AbhKMTSK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8C8A961212;
        Sat, 13 Nov 2021 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636830917;
        bh=JzR3pVK7LZYBBHWydczhhSiaC67QWH23BHog+2FNuXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CboHqiwY9d2A+GwqTjpn+/f8oqEBcFzgsud9RkprLMX5q8CxFlvTQcU0m/NXgFfdO
         Hk3gINzAyiyXdJwk0IVUEcBBrptbWlV6FjxyawTSavIuuT8IdR4hf1jrrN/tOg6erS
         5ilq42Elf7QgQfppaqxoqIfNF2QgGmFMwQ3M63neot8pNewp0+SaH0JNSrinEgT3Fb
         P4+RL6Eur4VzvPUfDkOQtta6pqdlN8tfOMYo+Kkci+eAgiF6mH5SbxevCne6lZCUud
         QYKTPJ410QHQkUneXe+lNX7wg9k6ALHm4EhOhJDS53ZnlK/JHVYv2hQDqdpzH7lq25
         i5Mqdu8QJA7GQ==
Subject: Re: [GIT PULL] s390 patches for the 5.16 merge window #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01636811772-ext-9507@work.hours>
References: <your-ad-here.call-01636811772-ext-9507@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01636811772-ext-9507@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-2
X-PR-Tracked-Commit-Id: a4751f157c194431fae9e9c493f456df8272b871
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be427a88a3dc2de30688b08d078f4f4c1bb035d6
Message-Id: <163683091754.10343.7064421671859878721.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:15:17 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 13 Nov 2021 14:56:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be427a88a3dc2de30688b08d078f4f4c1bb035d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
