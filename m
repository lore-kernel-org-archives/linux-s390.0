From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: restrict non-blocking connect finish
Date: Wed, 02 May 2018 13:28:17 -0400 (EDT)
Message-ID: <20180502.132817.1973402419020011208.davem@davemloft.net>
References: <20180502145356.32913-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180502145356.32913-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed,  2 May 2018 16:53:56 +0200

> The smc_poll code tries to finish connect() if the socket is in
> state SMC_INIT and polling of the internal CLC-socket returns with
> EPOLLOUT. This makes sense for a select/poll call following a connect
> call, but not without preceding connect().
> With this patch smc_poll starts connect logic only, if the CLC-socket
> is no longer in its initial state TCP_CLOSE.
> 
> In addition, a poll error on the internal CLC-socket is always
> propagated to the SMC socket.
> 
> With this patch the code path mentioned by syzbot
> https://syzkaller.appspot.com/bug?extid=03faa2dc16b8b64be396
> is no longer possible.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Reported-by: syzbot+03faa2dc16b8b64be396@syzkaller.appspotmail.com

Applied and queued up for -stable, thanks.
