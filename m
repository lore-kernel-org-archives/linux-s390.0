Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/smc: fix out of bound access in netlink interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161051220881.5581.17205976954559864201.git-patchwork-notify@kernel.org>
Date: Wed, 13 Jan 2021 04:30:08 +0000
References: <20210112162122.26832-1-kgraul@linux.ibm.com>
In-Reply-To: <20210112162122.26832-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Karsten Graul <kgraul@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Tue, 12 Jan 2021 17:21:20 +0100 you wrote:
> Please apply the following patch for smc to netdev's net tree.
> 
> Both patches fix possible out-of-bounds reads. The original code expected
> that snprintf() reads len-1 bytes from source and appends the terminating
> null, but actually snprintf() first copies len bytes and finally overwrites
> the last byte with a null.
> Fix this by using memcpy() and terminating the string afterwards.
> 
> [...]

Here is the summary with links:
  - [net,1/2] smc: fix out of bound access in smc_nl_get_sys_info()
    https://git.kernel.org/netdev/net/c/25fe2c9c4cd2
  - [net,2/2] net/smc: use memcpy instead of snprintf to avoid out of bounds read
    https://git.kernel.org/netdev/net/c/8a4465368964

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html
