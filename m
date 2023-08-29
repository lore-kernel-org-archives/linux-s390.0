Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E6C83F13
	for <linux-s390@archiver.kernel.org>; Tue, 29 Aug 2023 00:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjH2AqL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Aug 2023 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjH2AqF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Aug 2023 20:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70450DF;
        Mon, 28 Aug 2023 17:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05F28617F1;
        Tue, 29 Aug 2023 00:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DACEC433C7;
        Tue, 29 Aug 2023 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693269961;
        bh=9mivrV705YGeKPaLtBhvFUSi7qoTXpcJ2aF7cLdR9dE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RTcV3A1gNiYf1II0ckKJ66GmU5DJKujgEBtcOwBzv1bErmvwz4wA8QEJ4S7ptyxVk
         zkGbMiM5M9TSHTFulX4sUiPtB78ALDmYXbZH7RNPiMCY3nzV4ejZSKtD8Bpzkkdauq
         O4cc7aPtTPna7S/PbblTfLho1ggv8Ud/fO4OOOIO4pvpcSrc+fc9jGmr6KVPZZtRK8
         rTBNr2bJjEb8cdkjJSdUl3SIzd3zZqZEoXODRvaAx0KWZAMM64kGgGJFyA/iTHCMxE
         LDKBbcFTyytnvDfNLBqgJqe4SHbsMb4Gm2lS9JV4psU93HMCKVLa28eRN0rqTZhRxB
         PLW7gYjV6P77g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BEFAC3274C;
        Tue, 29 Aug 2023 00:46:01 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.6 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230827203058.5559-A-hca@linux.ibm.com>
References: <20230827203058.5559-A-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230827203058.5559-A-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-1
X-PR-Tracked-Commit-Id: dedf98dd1cfb61cfc74be9248b90a49b42c6dead
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5b7ca09e9aa4d483ab84c5f2ba88f0cc7c66540
Message-Id: <169326996137.22794.8832134670034941690.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:46:01 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 22:30:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5b7ca09e9aa4d483ab84c5f2ba88f0cc7c66540

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
