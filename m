From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: rebuild nonblocking connect
Date: Thu, 28 Jun 2018 22:04:35 +0900 (KST)
Message-ID: <20180628.220435.1811296249340213295.davem@davemloft.net>
References: <20180627155950.21153-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180627155950.21153-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, xiyou.wangcong@gmail.com, eric.dumazet@gmail.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 27 Jun 2018 17:59:50 +0200

> The recent poll change may lead to stalls for non-blocking connecting
> SMC sockets, since sock_poll_wait is no longer performed on the
> internal CLC socket, but on the outer SMC socket.  kernel_connect() on
> the internal CLC socket returns with -EINPROGRESS, but the wake up
> logic does not work in all cases. If the internal CLC socket is still
> in state TCP_SYN_SENT when polled, sock_poll_wait() from sock_poll()
> does not sleep. It is supposed to sleep till the state of the internal
> CLC socket switches to TCP_ESTABLISHED.
> 
> This problem triggered a redesign of the SMC nonblocking connect logic.
> This patch introduces a connect worker covering all connect steps
> followed by a wake up of socket waiters. It allows to get rid of all
> delays and locks in smc_poll().
> 
> Fixes: c0129a061442 ("smc: convert to ->poll_mask")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied.
