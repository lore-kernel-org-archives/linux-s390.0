Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF5EC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 28 Mar 2022 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiC1Xb5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 28 Mar 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiC1Xb4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 19:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7538181;
        Mon, 28 Mar 2022 16:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1EF260FCF;
        Mon, 28 Mar 2022 23:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37597C34111;
        Mon, 28 Mar 2022 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648510212;
        bh=AcSSt6s9DZqIxCq3CMNV8dEihdvg5HBi2xHYQpL2nOw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I+2ROWg0R4L7HsIkYAEQIJj1trKqmPitSf0VtOlWK82brUsO4Dsc4DSh6I+gMkCt5
         HquOV1uXOwLo1UnY0EaUpv8BA7TZCeOUhous45ad3HTqhumlPfvz5B+nC11lvy1zQ3
         UJBcU/UHGHDraU8c1UkJblchW5RNWJCdaB5O4BmjC1P4ZmroUhT0tPX8Cq83aebjM0
         LgW3JtxUkjnxDZEukJlPpw60EZEOyVKiIl+WRtYWTjgDE3vqPVNq4tuZE7WHHkaTQ4
         C5lhAc4bN7IYmbjSwmhxgwZglKtouEmZ2nTjlYgdhw90I2CWvToatWvv/vJU8eyRPe
         uYs+xFIdirJuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BD8FF0384A;
        Mon, 28 Mar 2022 23:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Send out the remaining data in sndbuf before
 close
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164851021204.6043.13335558443304429.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Mar 2022 23:30:12 +0000
References: <1648447836-111521-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1648447836-111521-1-git-send-email-guwen@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Mar 2022 14:10:36 +0800 you wrote:
> The current autocork algorithms will delay the data transmission
> in BH context to smc_release_cb() when sock_lock is hold by user.
> 
> So there is a possibility that when connection is being actively
> closed (sock_lock is hold by user now), some corked data still
> remains in sndbuf, waiting to be sent by smc_release_cb(). This
> will cause:
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Send out the remaining data in sndbuf before close
    https://git.kernel.org/netdev/net/c/906b3d64913c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


