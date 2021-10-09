Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F765C433EF
	for <linux-s390@archiver.kernel.org>; Sat,  9 Oct 2021 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C4360F22
	for <linux-s390@archiver.kernel.org>; Sat,  9 Oct 2021 16:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhJIQNY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 9 Oct 2021 12:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhJIQNW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 9 Oct 2021 12:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E8E7F60F22;
        Sat,  9 Oct 2021 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633795885;
        bh=5Xg7lRWZ6AIBKIBUhXKXWn5Pz4tIZkltjsgQlkz9fII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dMWivXKdJLKt27/H/CaBafdWtWjSv7h9UezwDaxiIRSIldbTyrnojmddLSrXRTxDD
         FLJbycI8TsdXoQPzhfBbh1bhUEqojc4oy63G1SkOD9ccLUdNtBrZzyGNlVIG6NkT9p
         QxH8swZUhV1ShUm4VMIY0LMQTPuspemJAoIKu2qkiei2SQXEU6OwORa1LR5QHQapoa
         X8BBz066wBo5wOaL02OaFjNcyk1CPY9UTX3pXTknzAjYELrj4pbAPlJoFncaIK771y
         FWVqmFiH6uv9B8E7Zq9QB8/npVZjFaML0EJKSCeeMeZiFNFo9J7eSNPfiS1nacwwtq
         eHJzoqLEKNKqA==
Subject: Re: [GIT PULL] s390 updates for 5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01633735195-ext-0881@work.hours>
References: <your-ad-here.call-01633735195-ext-0881@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01633735195-ext-0881@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-5
X-PR-Tracked-Commit-Id: a46044a92add6a400f4dada7b943b30221f7cc80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f84fc4e36cd816d2d5dff0541f32fed411b0355f
Message-Id: <163379588582.23991.11047088438145748760.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Oct 2021 16:11:25 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 9 Oct 2021 01:19:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f84fc4e36cd816d2d5dff0541f32fed411b0355f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
