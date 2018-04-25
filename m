From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: keep clcsock reference in
 smc_tcp_listen_work()
Date: Wed, 25 Apr 2018 14:38:37 -0400 (EDT)
Message-ID: <20180425.143837.224306225323431537.davem@davemloft.net>
References: <20180425104858.48953-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180425104858.48953-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 25 Apr 2018 12:48:58 +0200

> The internal CLC socket should exist till the SMC-socket is released.
> Function tcp_listen_worker() releases the internal CLC socket of a
> listen socket, if an smc_close_active() is called. This function
> is called for the final release(), but it is called for shutdown
> SHUT_RDWR as well. This opens a door for protection faults, if
> socket calls using the internal CLC socket are called for a
> shutdown listen socket.
> 
> With the changes of
> commit 3d502067599f ("net/smc: simplify wait when closing listen socket")
> there is no need anymore to release the internal CLC socket in
> function tcp_listen_worker((). It is sufficient to release it in
> smc_release().
> 
> Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Reported-by: syzbot+9045fc589fcd196ef522@syzkaller.appspotmail.com
> Reported-by: syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com
> Reported-by: syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com
> Reported-by: syzbot+cf9012c597c8379d535c@syzkaller.appspotmail.com

Applied and queued up for -stable.
