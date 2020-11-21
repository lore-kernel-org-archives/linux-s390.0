Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgKUWuF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 21 Nov 2020 17:50:05 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/af_iucv: set correct sk_protocol for child sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160599900499.23624.16990303223238817146.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2020 22:50:04 +0000
References: <20201120100657.34407-1-jwi@linux.ibm.com>
In-Reply-To: <20201120100657.34407-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Fri, 20 Nov 2020 11:06:57 +0100 you wrote:
> Child sockets erroneously inherit their parent's sk_type (ie. SOCK_*),
> instead of the PF_IUCV protocol that the parent was created with in
> iucv_sock_create().
> 
> We're currently not using sk->sk_protocol ourselves, so this shouldn't
> have much impact (except eg. getting the output in skb_dump() right).
> 
> [...]

Here is the summary with links:
  - [net] net/af_iucv: set correct sk_protocol for child sockets
    https://git.kernel.org/netdev/net/c/c5dab0941fcd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
