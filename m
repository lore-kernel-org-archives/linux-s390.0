Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17CC432BE
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C461055
	for <linux-s390@archiver.kernel.org>; Mon,  9 Aug 2021 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHIJU1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Aug 2021 05:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhHIJU0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Aug 2021 05:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6682760041;
        Mon,  9 Aug 2021 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628500806;
        bh=T3oLCeB1tPopCikpPUsxfKoatEE3T0wc4XiIJej+j+M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ekw6t3pWNl5nzLUcl7TkZg3+wnPc9+4cuWzAaI/U67pznIjdkvUK0tveCOXb+Fib+
         MSbrBdIFlJZ0qIFfAMv/Q4K4klo7jAUHYlPXL462c+AGJhveZ0eyFZQC84EHgOZzD0
         2cl9wng1fgzseCmO3hHCm79gIsZI4TeKyhK+ktezo6l7dqF1RpuvOy5Z8g6cev86UY
         OOccnXoG4HQWqywFSkna6N1aj2QaQGEuET+7YLpaaTst1yJh6LgSHbGTwv2NDu6aiQ
         lH1texb3plIm039E9bQNbCBHupBro0QqHL9+iBRyNw6LzoHi7T56QYxwi4tchM80S2
         eX7ifzI7zgLpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/iucv: updates 2021-08-09
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162850080638.12236.6664484571643543885.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Aug 2021 09:20:06 +0000
References: <20210809083050.2328336-1-kgraul@linux.ibm.com>
In-Reply-To: <20210809083050.2328336-1-kgraul@linux.ibm.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, jwi@linux.ibm.com,
        bigeasy@linutronix.de
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon,  9 Aug 2021 10:30:45 +0200 you wrote:
> Please apply the following iucv patches to netdev's net-next tree.
> 
> Remove the usage of register asm statements and replace deprecated
> CPU-hotplug functions with the current version.
> Use use consume_skb() instead of kfree_skb() to avoid flooding
> dropwatch with false-positives, and 2 patches with cleanups.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/af_iucv: support drop monitoring
    https://git.kernel.org/netdev/net-next/c/10d6393dc471
  - [net-next,2/5] net/af_iucv: clean up a try_then_request_module()
    https://git.kernel.org/netdev/net-next/c/4eb9eda6ba64
  - [net-next,3/5] net/af_iucv: remove wrappers around iucv (de-)registration
    https://git.kernel.org/netdev/net-next/c/ff8424be8ce3
  - [net-next,4/5] net/iucv: get rid of register asm usage
    https://git.kernel.org/netdev/net-next/c/50348fac2921
  - [net-next,5/5] net/iucv: Replace deprecated CPU-hotplug functions.
    https://git.kernel.org/netdev/net-next/c/8c39ed4876d4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


