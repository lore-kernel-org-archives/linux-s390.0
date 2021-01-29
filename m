Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhA2Euz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 23:50:55 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] s390/qeth: updates 2021-01-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161189581335.32508.16613001486603059232.git-patchwork-notify@kernel.org>
Date: Fri, 29 Jan 2021 04:50:13 +0000
References: <20210128112551.18780-1-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, kgraul@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 28 Jan 2021 12:25:46 +0100 you wrote:
> Hi Dave & Jakub,
> 
> please apply the following patch series for qeth to netdev's net-next tree.
> 
> Nothing special, mostly fine-tuning and follow-on cleanups for earlier fixes.
> 
> Thanks,
> Julian
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] s390/qeth: clean up load/remove code for disciplines
    https://git.kernel.org/netdev/net-next/c/ea12f1b3c828
  - [net-next,2/5] s390/qeth: remove qeth_get_ip_version()
    https://git.kernel.org/netdev/net-next/c/17f3a8b5f5c9
  - [net-next,3/5] s390/qeth: pass proto to qeth_l3_get_cast_type()
    https://git.kernel.org/netdev/net-next/c/c61dff3c1ef7
  - [net-next,4/5] s390/qeth: make cast type selection for af_iucv skbs robust
    https://git.kernel.org/netdev/net-next/c/a667fee181b2
  - [net-next,5/5] s390/qeth: don't fake a TX completion interrupt after TX error
    https://git.kernel.org/netdev/net-next/c/d6e515031517

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
