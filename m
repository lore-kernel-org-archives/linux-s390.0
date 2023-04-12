Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31649C7619A
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 09:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDLJkY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjDLJkW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Apr 2023 05:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3F6A6E;
        Wed, 12 Apr 2023 02:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC33562B00;
        Wed, 12 Apr 2023 09:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 246A5C433D2;
        Wed, 12 Apr 2023 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292419;
        bh=JWwdcoPtNJtiV5P9F/d0zKiBlO6bj32QgEfNbggSY4w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=utGN1eAjVzTqi04dqTg6oHK0IJpzvmHCYg1pAEu17yWsBu4Ycn8hJ3d9m0vUyM7KZ
         8wml97q2B9Q+lXYA4UXuu50xQrSKXQj1Rf48k96m9ekTCqj03y0H/F+aHNjflFmRNd
         9qJVSsIBXL7CRczFFHH02WDDZLgkp+0OakmMcIR2rV7DTbD0Z3yI5/BmcpQISCHd7x
         afCbqsoNduGgv0T+f1dveQVkxKIHsw+BjFaPFK5A6saR7U2Pwqqi2fV72A5DY2QoP7
         paEvqAWF15usHgpWoColAKrNmCjKGBvUtF/bqe4Rjr3UDhmbEwy3O39ChnAH2bHW6O
         BtWxnWOhX/7Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00FC2E5244C;
        Wed, 12 Apr 2023 09:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] smc: Fix use-after-free in tcp_write_timer_handler().
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168129241899.17951.14025215756359259434.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Apr 2023 09:40:18 +0000
References: <20230408184943.48136-1-kuniyu@amazon.com>
In-Reply-To: <20230408184943.48136-1-kuniyu@amazon.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, kuni1840@gmail.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org,
        syzbot+7e1e1bdb852961150198@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 8 Apr 2023 11:49:43 -0700 you wrote:
> With Eric's ref tracker, syzbot finally found a repro for
> use-after-free in tcp_write_timer_handler() by kernel TCP
> sockets. [0]
> 
> If SMC creates a kernel socket in __smc_create(), the kernel
> socket is supposed to be freed in smc_clcsock_release() by
> calling sock_release() when we close() the parent SMC socket.
> 
> [...]

Here is the summary with links:
  - [v1,net] smc: Fix use-after-free in tcp_write_timer_handler().
    https://git.kernel.org/netdev/net/c/9744d2bf1976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


