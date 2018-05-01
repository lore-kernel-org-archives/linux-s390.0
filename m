From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] net/smc: fixes 2018/04/30
Date: Mon, 30 Apr 2018 21:03:51 -0400 (EDT)
Message-ID: <20180430.210351.716233311438621264.davem@davemloft.net>
References: <20180430145119.72479-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180430145119.72479-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 30 Apr 2018 16:51:15 +0200

> From: Ursula Braun <ursula.braun@linux.ibm.com>
> 
> Dave,
> 
> here are 4 smc patches for net-next covering different areas:
>    * link health check
>    * diagnostics for IPv6 smc sockets
>    * ioctl
>    * improvement for vlan determination

You say "fixes" in your Subject line but adding ipv6 smc
socket diag support is a feature not a fix.

Actually, generally speaking your patch submissions are
confusing.

You do submit really pure bug fixes, but for some odd
reason you target the net-next tree instead of net.

Maybe you have a good reason for doing this and you can
explain it to me?
