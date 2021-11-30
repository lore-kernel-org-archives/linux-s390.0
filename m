Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A86C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 30 Nov 2021 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhK3Mdg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:33:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhK3Mdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Nov 2021 07:33:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83039B819A1;
        Tue, 30 Nov 2021 12:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CCD7C53FCF;
        Tue, 30 Nov 2021 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638275410;
        bh=D4Jx5pr2GCQBpfUB5CbwXnYAfoFu8JJD965nyq/2FYk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F44qcdebI/L7PX/f1VA0DkjVaLJzGiwXYgtgZfu11LGcneCbdnTo0adNJgWtIEfw2
         imYMWuhvKzPub3OXfOihRCevJqhM6i3f7IMQ+sBUMbHhYobVtfwWGe8nKnkN//2j4d
         AkugUEY45zzH2oaPD9MxFNFo2gHiug3aDZRu955Vk5Px/mrUZ/Ec+LvwaRTLX3nkVx
         av34QTSxnDV2Bnh5VSbAKBl9uR+B0hXcgZP0lkaDfFjJxDItVFxxO2SIys/yYTfa0o
         kHQoMU4n2M77pD56RznI8KqmKCeCmdMTqUZXo4QsHuRywojFGvDfdFuNVZ8d/kYNEL
         Aw5Obempe997Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B93E60A94;
        Tue, 30 Nov 2021 12:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: s390/net: add Alexandra and Wenjia as
 maintainer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163827541010.1181.10845531566402474498.git-patchwork-notify@kernel.org>
Date:   Tue, 30 Nov 2021 12:30:10 +0000
References: <20211130073358.4079471-1-kgraul@linux.ibm.com>
In-Reply-To: <20211130073358.4079471-1-kgraul@linux.ibm.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, jwi@linux.ibm.com,
        wenjia@linux.ibm.com, wintera@linux.ibm.com
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue, 30 Nov 2021 08:33:58 +0100 you wrote:
> Add Alexandra and Wenjia as maintainers for drivers/s390/net and iucv.
> Also, remove myself as maintainer for these areas.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Acked-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: s390/net: add Alexandra and Wenjia as maintainer
    https://git.kernel.org/netdev/net/c/34d8778a9437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


