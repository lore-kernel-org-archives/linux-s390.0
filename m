From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/4] net/smc: handle sockopt TCP_NODELAY
Date: Fri, 20 Apr 2018 11:31:57 -0400 (EDT)
Message-ID: <20180420.113157.1651430973265400043.davem@davemloft.net>
References: <20180419135655.3058-1-ubraun@linux.ibm.com>
        <20180419135655.3058-3-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419135655.3058-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 19 Apr 2018 15:56:53 +0200

> @@ -1412,6 +1523,10 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
>  		sk_common_release(sk);
>  		goto out;
>  	}
> +	/* clc handshake should run with disabled Nagle algorithm */
> +	rc = kernel_setsockopt(smc->clcsock, SOL_TCP, TCP_NODELAY, (char *)&val,
> +			       sizeof(val));
> +	smc->deferred_nodelay_reset = 1; /* TCP_NODELAY is not the default */
>  	smc->sk.sk_sndbuf = max(smc->clcsock->sk->sk_sndbuf, SMC_BUF_MIN_SIZE);
>  	smc->sk.sk_rcvbuf = max(smc->clcsock->sk->sk_rcvbuf, SMC_BUF_MIN_SIZE);

This is not what I asked for.

If the user asked for the socket option, you are unconditionally returning success
to the original user.

If it fails here during the smc create, it's too late to handle the error properly.

This is the problem you must solve before I can take these changes properly.

You aren't even really failing the smc_create() here, because if you were you
would kill and free up the clcsock and release 'sk'.

As it stands now you are returning an error, and not releasing resources, if
the kernel_setsockopt() fails.

But more fundamentally these semantics are terrible.  You must not ever create
a situation where you tell the user his setsockopt succeeded by in the end
not honoring that reqeust fully.  That is what your current changes allow to
happen.
