Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7579C001DE
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jul 2023 03:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjGZDKg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGZDKZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jul 2023 23:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319F2709
        for <linux-s390@vger.kernel.org>; Tue, 25 Jul 2023 20:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFD2601D6
        for <linux-s390@vger.kernel.org>; Wed, 26 Jul 2023 03:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E898C433CD;
        Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690341020;
        bh=+ajtJPlWkqiBolHDZStP+hnhkPbQ/RwAWCQlZcDPVAM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lwPAGDtEOoed9lcKOTgl7DqSZHEHUT4DdEsTqhf1X2Y481nQChozovLhFyAUgOiUR
         /xDcThWJsGahlMuIF+/tlxzXa5lNpvSHHTVeh6snuQBgqhftHbR9hhpml6dcR2xZHh
         LwEHu3qpXE/Ff1mZjU4JEehLEmZAP+UhwpmF9pynAkSoNzfLKe/4SHJsdYva4kpx0H
         UgkcTf1Ans9R7JRkqMx8Qgb8CHDnOwMUs4jU1EsRy04xVQsUFSQSuHeuD0Z/z8QuF3
         4Zd6w/iO2e3MXUT1vprlxx77774khUNPEUn5YmexQQooh3o3RU8pO4+MwnyT/qqlr9
         QOL2t81FgfAGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A670C73FE2;
        Wed, 26 Jul 2023 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/lcs: Remove FDDI option
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169034102049.18310.14252409973492346016.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Jul 2023 03:10:20 +0000
References: <20230724131546.3597001-1-wintera@linux.ibm.com>
In-Reply-To: <20230724131546.3597001-1-wintera@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        simon.horman@corigine.com, borntraeger@linux.ibm.com,
        rdunlap@infradead.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 15:15:46 +0200 you wrote:
> The last s390 machine that supported FDDI was z900 ('7th generation',
> released in 2000). The oldest machine generation currently supported by
> the Linux kernel is MARCH_Z10 (released 2008). If there is still a usecase
> for connecting a Linux on s390 instance to a LAN Channel Station (LCS), it
> can only do so via Ethernet.
> 
> Randy Dunlap[1] found that LCS over FDDI has never worked, when FDDI
> was compiled as module. Instead of fixing that, remove the FDDI option
> from the lcs driver.
> 
> [...]

Here is the summary with links:
  - [net] s390/lcs: Remove FDDI option
    https://git.kernel.org/netdev/net-next/c/8540336adadb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


