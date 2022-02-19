Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B46C433EF
	for <linux-s390@archiver.kernel.org>; Sat, 19 Feb 2022 19:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiBSTAk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 19 Feb 2022 14:00:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiBSTAd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 19 Feb 2022 14:00:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9551D5A583;
        Sat, 19 Feb 2022 11:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A457BB80C95;
        Sat, 19 Feb 2022 19:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB7AC340F5;
        Sat, 19 Feb 2022 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645297210;
        bh=qJ6WlgnJjTcuVZkpjpXRlBugN/OcRulAHR5OFHKXnuk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lQYgdcvAzfOR4NAp6avN+9VEiifztKFdgngQmmwToSvHGGHVtwfkIqM4A6MbEIJUJ
         bLSt56Bgez5iki/9CU1QAJu45IKm4ySu6N2f3dtePSkfvlo36eFc5dSWA0o8ZXWL+T
         IJp68USShLPd4hytcmvZSWzBzXUET1HkpIa0wSS7wpQdhqjzcN9HVV+M0KfJVMwpbR
         fJWi7CDwDSXYBxGuzy2gBKAbdbnK/0OoC8DXlgmQW4AKYU83SNdEvsd4iHVw1VBrHF
         U4hmfBUBkvNK0xGkfFV4DbTlMR7H4ACEcpzYJSaJQoWiL7LpDCpOx/OAM+GS+6MtL/
         NdMsztbe1Pwsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2128DE7BB18;
        Sat, 19 Feb 2022 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: unlock on error paths in __smc_setsockopt()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164529721013.31615.8936632841443065426.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Feb 2022 19:00:10 +0000
References: <20220218153259.GA4392@kili>
In-Reply-To: <20220218153259.GA4392@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kgraul@linux.ibm.com, alibuda@linux.alibaba.com,
        davem@davemloft.net, kuba@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Feb 2022 18:32:59 +0300 you wrote:
> These two error paths need to release_sock(sk) before returning.
> 
> Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/smc/af_smc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: unlock on error paths in __smc_setsockopt()
    https://git.kernel.org/netdev/net-next/c/7a11455f376d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


