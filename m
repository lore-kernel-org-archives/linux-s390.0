Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B7C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC2F61267
	for <linux-s390@archiver.kernel.org>; Fri,  1 Oct 2021 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355327AbhJAVsa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355704AbhJAVs2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 1 Oct 2021 17:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1C3C061267;
        Fri,  1 Oct 2021 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633124804;
        bh=EdQlEaqnnQAVYg2naAAtKcOY9BSQ2xsRfic/DpOSbZ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DUoLQCcXyGOzzbHpil3tk0kYIV/TncEmGy2+WL0rXNwnPbHMnSb0qPc/fWoemS2rA
         d6pOH1J57krNE/RnXgW60ou+OKYr6g59eTNnljDfYcWeEF3WNQy3f6vsnK1jeXxe1O
         fPfdKjLX1svDfz4gD3r8nKV5RM5embXjS1NoLoT2Xp2GdinS+bBnjWeJqwuwJC4KBk
         MdkawvIm/2w92vARTXQSG0RDTuiZ5pgRwf/phgdRswwEsC+XTKpv2cTI2zpegs33OE
         JXh2oTyiwmLh4b8sYqAUF6kZT81BW6omGbcL+rr/lGVpUBZjFQoLTxEa3EalGvCM92
         9H0dJQUOq/sLg==
Subject: Re: [GIT PULL] s390 updates for 5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01633119599-ext-2970@work.hours>
References: <your-ad-here.call-01633119599-ext-2970@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01633119599-ext-2970@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-4
X-PR-Tracked-Commit-Id: 172da89ed0eaf9d9348f5decb86ad04c624b39d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53d5fc89d66a778577295020dc57bb3ccec84354
Message-Id: <163312480398.23222.13769588797351787306.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Oct 2021 21:46:43 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 1 Oct 2021 22:19:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53d5fc89d66a778577295020dc57bb3ccec84354

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
