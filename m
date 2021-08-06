Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B2C432BE
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCB0611C9
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbhHFLUX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235696AbhHFLUV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 6 Aug 2021 07:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AA3EF60EE8;
        Fri,  6 Aug 2021 11:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628248805;
        bh=Vo0v0V1xYZEDLAn7H8GGAnL5VmwdFYgbwgnzDOTgOlo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VOw0H1xbAN84tij5TcniTek8WZPXEc2cDm44+v9nMq8BdVukBs6AFYSC03uYicjaT
         GggNHIXpzi9pLoNb6Js0TQkmuSS2YiJYkCi7yMhAVUQ1YG0WG27x31d5U6dzmMkWAt
         fJltvq5Vr3LFNcMiKLziE5c0NHkkcBgPOcVBULbSQmwR54zNy+m/SGMt+iLKfgQ3ua
         QxewzXS2L0JGHVTkQ/7wvBqDeCuEvpP1DUnvQ/QdAeDDWKFSsUAiO62n1r4XGV27vu
         zj27q3MrfJNZPN/tKC/BDjdqF3bNrUdSIt0xBsK6l1fIsyGyZLWL4LAPC9dSwXEJI/
         rMeKEPTHpc+pA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvvp2: fix short frame size on s390
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162824880563.5178.3391459131961581838.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Aug 2021 11:20:05 +0000
References: <20210806065330.23000-1-jhubbard@nvidia.com>
In-Reply-To: <20210806065330.23000-1-jhubbard@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     mw@semihalf.com, linux@armlinux.org.uk, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sven.auhagen@voleatech.de, mcroce@microsoft.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu, 5 Aug 2021 23:53:30 -0700 you wrote:
> On s390, the following build warning occurs:
> 
> drivers/net/ethernet/marvell/mvpp2/mvpp2.h:844:2: warning: overflow in
> conversion from 'long unsigned int' to 'int' changes value from
> '18446744073709551584' to '-32' [-Woverflow]
> 844 |  ((total_size) - MVPP2_SKB_HEADROOM - MVPP2_SKB_SHINFO_SIZE)
> 
> [...]

Here is the summary with links:
  - net: mvvp2: fix short frame size on s390
    https://git.kernel.org/netdev/net/c/704e624f7b3e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


