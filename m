Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C49C433E6
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E7864FC4
	for <linux-s390@archiver.kernel.org>; Wed, 10 Mar 2021 21:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCJVVo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhCJVVQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Mar 2021 16:21:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D98E64FD3;
        Wed, 10 Mar 2021 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615411276;
        bh=egGkqIekPSt0sQ5Ru1IACgnjffEou36wOZGzyxf+EGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hetQoQnWXSzCINyXcsZbfEJJLvBDHmzfgc5uIf+g4cfv2z0+X230LsVKZWqkg6hul
         dgjm2/IEoDjUHJesQPQqNS9kaOBd43biVmEN2KknmlMXMkPNOLaoa0u5qXbqBLo76o
         bq6rmiOhHcaAt4hSDEk4bVolasm8wKQkNKR9Gr4ChERsS8BGoya2Ma3N/OLC0JYMnk
         0V+W6joLyWXqKLGfrgL9ZCn3ZJAC8EKNKq0IfhZl3Yam/EW3WF3QDyK5P++vZZSoMi
         rmjuqlpG8q5s4IRBwg2cGx481xEzc5raNHE5Q1i0oU8bttnycJcNIlDKwTb2DLZmlC
         3frXlk8p5I8Og==
Subject: Re: [GIT PULL] s390 updates for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEkgvDUmkCkbTe5O@osiris>
References: <YEkgvDUmkCkbTe5O@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEkgvDUmkCkbTe5O@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-3
X-PR-Tracked-Commit-Id: 78c7cccaab9d5f9ead44579d79dd7d13a05aec7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a74e6a014c9d4d4161061f770c9b4f98372ac778
Message-Id: <161541127610.14179.6629831801471725055.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Mar 2021 21:21:16 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Wed, 10 Mar 2021 20:40:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a74e6a014c9d4d4161061f770c9b4f98372ac778

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
