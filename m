Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC71C433EF
	for <linux-s390@archiver.kernel.org>; Sat,  6 Nov 2021 21:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287FF611EE
	for <linux-s390@archiver.kernel.org>; Sat,  6 Nov 2021 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKFV6x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhKFV6w (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 6 Nov 2021 17:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C62161186;
        Sat,  6 Nov 2021 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636235771;
        bh=SbghJxsut4y7wxbpeK0pkhzFgveP+m59ZMhsAw6F7Tg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Auxf3cf5MNlSvSBXQqzZMZ7T2VR9cPZu7vnBE7kiVXimur2N+VPHBM+8bL2URsN4b
         a8RgugnvhD/eheXQyz7vwLVB9DAupXwXeaX8sOnxqCshTMA6Gc+WttXCrOz33QmpHH
         Q/1EJ9TfSyJ2JZ746BeHnG8MQB7rM6sMFfVGmjrjHmgN4aLNeypx+JAf2RsoR5QkKn
         /TrKfPWbt6VIKTX8ZmHABAUlCUc+fZKJYuxUzj1l6V47IVp0lS/Jlwa9BXP+uPzG3Z
         gZojqSM9iDkfGRgeTxm0DpwbdXT+0HZ03uOyI8UbMQvpJaI3XL+3TVwtwF/k5t460F
         pMAj0PfCZsxwg==
Subject: Re: [GIT PULL] s390 patches for the 5.16 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01636137270-ext-1192@work.hours>
References: <your-ad-here.call-01636137270-ext-1192@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01636137270-ext-1192@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-1
X-PR-Tracked-Commit-Id: 622021cd6c560ce7aaaf7294a732177a30c9d65f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b707e572a1955b892dfcb32e7b573fab78767d9
Message-Id: <163623577097.13044.15615632888402720329.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Nov 2021 21:56:10 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 19:34:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b707e572a1955b892dfcb32e7b573fab78767d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
