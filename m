From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net/smc: init conn.tx_work & conn.send_lock
 sooner
Date: Thu, 17 May 2018 16:25:53 -0400 (EDT)
Message-ID: <20180517.162553.678282635183871161.davem@davemloft.net>
References: <20180517105421.182397-1-edumazet@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180517105421.182397-1-edumazet@google.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: edumazet@google.com
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, ubraun@linux.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 17 May 2018 03:54:21 -0700

> syzkaller found that following program crashes the host :
> 
> {
>   int fd = socket(AF_SMC, SOCK_STREAM, 0);
>   int val = 1;
> 
>   listen(fd, 0);
>   shutdown(fd, SHUT_RDWR);
>   setsockopt(fd, 6, TCP_NODELAY, &val, 4);
> }
> 
> Simply initialize conn.tx_work & conn.send_lock at socket creation,
> rather than deeper in the stack.
 ...
> Fixes: 01d2f7e2cdd3 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ursula Braun <ubraun@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Reported-by: syzbot <syzkaller@googlegroups.com>

Applied, thanks Eric.
