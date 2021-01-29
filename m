Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhA2Euz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 23:50:55 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/iucv: updates 2021-01-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161189581342.32508.4406500317410182987.git-patchwork-notify@kernel.org>
Date: Fri, 29 Jan 2021 04:50:13 +0000
References: <20210128114108.39409-1-jwi@linux.ibm.com>
In-Reply-To: <20210128114108.39409-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 28 Jan 2021 12:41:03 +0100 you wrote:
> Hi Dave & Jakub,
> 
> please apply the following patch series for iucv to netdev's net-next tree.
> 
> This reworks & simplifies the TX notification path in af_iucv, so that we
> can send out SG skbs over TRANS_HIPER sockets. Also remove a noisy
> WARN_ONCE() in the RX path.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/af_iucv: remove WARN_ONCE on malformed RX packets
    https://git.kernel.org/netdev/net-next/c/27e9c1de5299
  - [net-next,2/5] net/af_iucv: don't lookup the socket on TX notification
    https://git.kernel.org/netdev/net-next/c/c464444fa2ca
  - [net-next,3/5] net/af_iucv: count packets in the xmit path
    https://git.kernel.org/netdev/net-next/c/ef6af7bdb9e6
  - [net-next,4/5] net/af_iucv: don't track individual TX skbs for TRANS_HIPER sockets
    https://git.kernel.org/netdev/net-next/c/80bc97aa0aaa
  - [net-next,5/5] net/af_iucv: build SG skbs for TRANS_HIPER sockets
    https://git.kernel.org/netdev/net-next/c/2c3b4456c812

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
