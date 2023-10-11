Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC23CD6E53
	for <linux-s390@archiver.kernel.org>; Wed, 11 Oct 2023 09:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjJKJk3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 Oct 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjJKJk2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Oct 2023 05:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61578A7
        for <linux-s390@vger.kernel.org>; Wed, 11 Oct 2023 02:40:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEF1AC433C9;
        Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697017227;
        bh=EEVqh0ZE/scMal1VISi9CLgOEYyaXTXceYU+wIgHpuo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cv3/k5EACOc8x9sRymmmEcMLGFEDR8IFWtKEt7i96FIbuV+ol/9cRmbIuWT+SlE6m
         uXdBfto4kAd28DxKuavZaXkPT3S6QgljOhf0We8ZprH0lraTnKvGy4fdkDQ8XcgnDN
         sBnjKs/tiCS/xVXsfMeVGc4aK6RiGYHCZuMykk/DYAyfovOsMCPc40miNgxfXVyigI
         C5U4Um4Dlkrzs91Tyn3qAn6IRmUSAOx3j+xJEn/qPTiAlrfoKrV6XRBKmXPeRowp+2
         dlM9NqBym+ZESxHKJyHzX8mUj1BVvUT5nLpwmU/KLnHuWQtDpeoGZ5oXJEGbAYib1D
         0AnR3h9TD6txg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D12D1E000BB;
        Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Fix pos miscalculation in statistics
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169701722685.1947.1054550686820287565.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 09:40:26 +0000
References: <20231009144048.73130-1-wenjia@linux.ibm.com>
In-Reply-To: <20231009144048.73130-1-wenjia@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        hca@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
        kgraul@linux.ibm.com, raspl@linux.ibm.com, gbayer@linux.ibm.com,
        twinkler@linux.ibm.com, pasic@linux.ibm.com, niho@linux.ibm.com,
        schnelle@linux.ibm.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, alibuda@linux.alibaba.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 16:40:48 +0200 you wrote:
> From: Nils Hoppmann <niho@linux.ibm.com>
> 
> SMC_STAT_PAYLOAD_SUB(_smc_stats, _tech, key, _len, _rc) will calculate
> wrong bucket positions for payloads of exactly 4096 bytes and
> (1 << (m + 12)) bytes, with m == SMC_BUF_MAX - 1.
> 
> Intended bucket distribution:
> Assume l == size of payload, m == SMC_BUF_MAX - 1.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Fix pos miscalculation in statistics
    https://git.kernel.org/netdev/net/c/a950a5921db4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


