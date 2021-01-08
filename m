Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbhAHDAt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Jan 2021 22:00:49 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] s390/qeth: fixes 2021-01-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161007480886.26739.12705141595571763670.git-patchwork-notify@kernel.org>
Date: Fri, 08 Jan 2021 03:00:08 +0000
References: <20210107172442.1737-1-jwi@linux.ibm.com>
In-Reply-To: <20210107172442.1737-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu,  7 Jan 2021 18:24:39 +0100 you wrote:
> Hi Dave & Jakub,
> 
> please apply the following patch series to netdev's net tree.
> 
> This brings two locking fixes for the device control path.
> Also one fix for a path where our .ndo_features_check() attempts to
> access a non-existent L2 header.
> 
> [...]

Here is the summary with links:
  - [net,1/3] s390/qeth: fix deadlock during recovery
    https://git.kernel.org/netdev/net/c/0b9902c1fcc5
  - [net,2/3] s390/qeth: fix locking for discipline setup / removal
    https://git.kernel.org/netdev/net/c/b41b554c1ee7
  - [net,3/3] s390/qeth: fix L2 header access in qeth_l3_osa_features_check()
    https://git.kernel.org/netdev/net/c/f9c4845385c8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
