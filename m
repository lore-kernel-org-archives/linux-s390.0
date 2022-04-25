Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F2C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 25 Apr 2022 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiDYKX2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiDYKXT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Apr 2022 06:23:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864714E3BD;
        Mon, 25 Apr 2022 03:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF4DACE1280;
        Mon, 25 Apr 2022 10:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B812C385AB;
        Mon, 25 Apr 2022 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650882011;
        bh=rb3VKiZtMW7GNR57XP26aVP9HD27dKwGNnRfLeQmH3I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uyPBtOrXByQdvmtA74nqywMg0256FX9pFUxUqxET+nLZwnYUB5gz2kVhEADT8h95Q
         QDdBHs8YaskmUjyuET4wCgw7rHtOJ97B56OczFjA2yo5WUuiDjbtt1uK/jSpJvk3zL
         uvJNwfZVCmZf61l96Qe/5fKiYVCx9ESkAtYngZtmqUsygasLTWUPpOR8cVwvdaVlgl
         5UPHEwWX6CyJi4IOgNlZumPq2V1EJgVceWzeccd+7+e8eiZ2nmT6J43dmm9sfFJ4jF
         lQeor2slgqt8I/AyDbttbGYKAissV3Gsm2FX2XiEgkAcgAH0s2+ZUg6ulGV4Rn0DWU
         ST5MWjk2emP9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02499E85D90;
        Mon, 25 Apr 2022 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: sync err code when tcp connection was refused
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165088201100.28755.12445423825500453173.git-patchwork-notify@kernel.org>
Date:   Mon, 25 Apr 2022 10:20:11 +0000
References: <20220421094027.683992-1-liuyacan@corp.netease.com>
In-Reply-To: <20220421094027.683992-1-liuyacan@corp.netease.com>
To:     None <liuyacan@corp.netease.com>
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tonylu@linux.alibaba.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Apr 2022 17:40:27 +0800 you wrote:
> From: liuyacan <liuyacan@corp.netease.com>
> 
> In the current implementation, when TCP initiates a connection
> to an unavailable [ip,port], ECONNREFUSED will be stored in the
> TCP socket, but SMC will not. However, some apps (like curl) use
> getsockopt(,,SO_ERROR,,) to get the error information, which makes
> them miss the error message and behave strangely.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: sync err code when tcp connection was refused
    https://git.kernel.org/netdev/net/c/4e2e65e2e56c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


