Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58167C43334
	for <linux-s390@archiver.kernel.org>; Fri,  3 Jun 2022 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349704AbiFCVtj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349607AbiFCVtg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jun 2022 17:49:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE9580E7;
        Fri,  3 Jun 2022 14:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C512B824BE;
        Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED27C385A9;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292964;
        bh=GbjaqLwB/l8n2edBxibsU+qAI61ShRc68CHMHjAJgeU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ca5NEB8Fc133djVe97AI6MJ7b+eTBuXr3aCaU+PTWWO61PiNcSVBWd7+JCIGVw5Gt
         yrRCN5Bx/AdughD8B/z3kluzo7HL/JIA8KuJHN8pfOnBM3MMJiZycJ6s8czmRy5XoN
         LYrRhdZ87Eu3PV3i9Nl+IsiyCGEZNlpuieoFAb+N4bP2CDQr5LYBYtfISDvwYj2uzK
         hlB+xAEq/TX+/PwjEt/VelF6u+ivPWQ3yWIahE76bKTNZva9WKLrg1mYZIGgj9QqNg
         uatmZ2uBSWDlkrU2+NAq7IE9TEqC9+Iwa2E+gwIG+PmGWRci2bYtlLAHWMsPTybXlf
         fIVS+BAnD5uLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A9F1F03950;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 5.19 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypnj/R48mToD7WZL@osiris>
References: <Ypnj/R48mToD7WZL@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypnj/R48mToD7WZL@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-2
X-PR-Tracked-Commit-Id: e0ffcf3fe18e0310221461c08969edec2cc7628c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ab6cfc4ad9f867a107b0ef029088dd4c0a8f83c
Message-Id: <165429296417.7657.7816254028391708797.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:24 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:35:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ab6cfc4ad9f867a107b0ef029088dd4c0a8f83c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
