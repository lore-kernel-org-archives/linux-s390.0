Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgJaWuF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 18:50:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/smc: improve return codes for SMC-Dv2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160418460471.3842.2355856936084967249.git-patchwork-notify@kernel.org>
Date: Sat, 31 Oct 2020 22:50:04 +0000
References: <20201031181938.69903-1-kgraul@linux.ibm.com>
In-Reply-To: <20201031181938.69903-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sat, 31 Oct 2020 19:19:38 +0100 you wrote:
> To allow better problem diagnosis the return codes for SMC-Dv2 are
> improved by this patch. A few more CLC DECLINE codes are defined and
> sent to the peer when an SMC connection cannot be established.
> There are now multiple SMC variations that are offered by the client and
> the server may encounter problems to initialize all of them.
> Because only one diagnosis code can be sent to the client the decision
> was made to send the first code that was encountered. Because the server
> tries the variations in the order of importance (SMC-Dv2, SMC-D, SMC-R)
> this makes sure that the diagnosis code of the most important variation
> is sent.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/smc: improve return codes for SMC-Dv2
    https://git.kernel.org/netdev/net-next/c/3752404a68e8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
