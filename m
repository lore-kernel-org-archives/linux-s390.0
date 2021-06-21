Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A5C48BC2
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 19:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C961356
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 19:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFUTWW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhFUTWT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 15:22:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 186ED6135D;
        Mon, 21 Jun 2021 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624303205;
        bh=l9FBgRorjyY0WGNvcNv/KLuTbN+PP2BdonCV1ZyXiu0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BnyRcUF5e+9KJFXDZuleziIYRlhNPC81SpT3MZT8xiScTJLYtP/pbDpYIgeHMwrsa
         ypwPs6o42wH4wU0zmSd44PpkCExZNPzITRK1ciGLJwqgEHHmEBDBGKyCd/1kmpCfQ1
         uvuXjHbGd90G734KcJwtVP+BDS1Cpf6BNgM93Gq/9ABWhBjbcyt5FXAAOlRoS3NnYu
         7JWINqnDyEOMwkYfoWpom2UWKh0cEmngHvcRqsuGl17myKoWKeOf58w3uzQfwKzERT
         b3sXeFUWNUSNC3TKT/elSFLmuu8JEjpYkTg+4Olx+OBTSTWp2h63H2G9ERdEdkxY2I
         dQbFzZrUX2cSg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: Fix ENODATA tests in
 smc_nl_get_fback_stats()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162430320503.6988.10664396793932851537.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Jun 2021 19:20:05 +0000
References: <YM32HV7psa+PrmbV@mwanda>
In-Reply-To: <YM32HV7psa+PrmbV@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kgraul@linux.ibm.com, guvenc@linux.ibm.com, davem@davemloft.net,
        kuba@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sat, 19 Jun 2021 16:50:21 +0300 you wrote:
> These functions return negative ENODATA but the minus sign was left out
> in the tests.
> 
> Fixes: f0dd7bf5e330 ("net/smc: Add netlink support for SMC fallback statistics")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/smc/smc_stats.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: Fix ENODATA tests in smc_nl_get_fback_stats()
    https://git.kernel.org/netdev/net-next/c/1a1100d53f12

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


