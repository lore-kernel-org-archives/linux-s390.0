Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0036EB64D9
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjF0XKT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjF0XKQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Jun 2023 19:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EDC2953;
        Tue, 27 Jun 2023 16:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25ED6125F;
        Tue, 27 Jun 2023 23:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93649C433C0;
        Tue, 27 Jun 2023 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687907413;
        bh=0sbkfXa6vOLKP8i9ohrviuT/QInmDKPSu0GTM3M/+5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oo5vvgsx+VBA/5iabpP2DNuKYGyPB6s3Rd94BhV5d2IUXalSBcKJzr4cAMDr0o24K
         92Uxla11+jxkOugCQceeksoIoYB1nCNB6OBKUtRq9zScyj/RVWR0O1oszSE2KPJhMR
         Aw/e68U2EfmDB55EIiF6Wd9nHc8MmFCJ5ZU8WfHK3QD/ZU/jAanUAKjuDOnjGK7T4q
         1MtfVtZDs1O0loNiNdUdjreOnPYdyqFN6/Y1rUzDgm+K0Wq0yc+4pURtJjzjGD4DJh
         3WWrdZUc+JQMF/OCRDSWyFWhTX9W4Jpkm2B11jIPwrMAmifYmXVN7E8Bx/KhXhH4Nj
         pnQtl1nD+jwKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BE35E5380A;
        Tue, 27 Jun 2023 23:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.5 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJssjVaDEfrQgB0I@tuxmaker.boeblingen.de.ibm.com>
References: <ZJssjVaDEfrQgB0I@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJssjVaDEfrQgB0I@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-1
X-PR-Tracked-Commit-Id: 9b9cf3c77e7e090b30657b3d2c288deb58dfb4f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a46676994607a1bde51cba71c1b0d373a555f45
Message-Id: <168790741348.21322.10594067038504431159.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 23:10:13 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 20:38:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a46676994607a1bde51cba71c1b0d373a555f45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
