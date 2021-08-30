Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F799C4320E
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 20:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0657660FA0
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 20:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhH3USN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234906AbhH3USM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Aug 2021 16:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6634B60F5C;
        Mon, 30 Aug 2021 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630354638;
        bh=tvGCFnhJMg3cxiiJ9gKvROnblg0imyhobzwgizncH+U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=msm/01ACfSEU+7CDmfGgkM8rXJyBCS1dP+KR34Ac5P6uYZHw3EIyAM6LwR/5GxTJt
         Qhym0kzotbtt4KfQgZ78B9a0S3F7cZH67owBaUBgCycAYffPFbcRxG/YPpdj8xIR3w
         yZS7jlWAw5fDBVTX4UAmDXwpcqG1yMUKKJrAQ9dfv/l8S3Z4g+JoSw0y0WwOsUlOOU
         7ttrBzI9SOijXgUwFM+75Vx5rAFQLUyuuiFyYKWfNrZPESujItEWOuYjtNr5OAVOKX
         xadwSHUjzNA5YqAXbkYUNFlFe3JC5FFeF5nWxssdV46xCpbJ8PHYsi5r8FiI7ofPrk
         d9Eh0TG2VJBlQ==
Subject: Re: [GIT PULL] s390 updates for 5.15 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YSzZFgBt6nMvpVgc@osiris>
References: <YSzZFgBt6nMvpVgc@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YSzZFgBt6nMvpVgc@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-1
X-PR-Tracked-Commit-Id: 927932240aa1739ac8c92b142a5e2dcc490f36e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7a5238ef68b98130fe36716bb3fa44502f56001
Message-Id: <163035463838.13905.10411307515244164121.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:17:18 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 15:11:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7a5238ef68b98130fe36716bb3fa44502f56001

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
