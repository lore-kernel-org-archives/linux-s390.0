From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: add SMC rendezvous protocol
Date: Wed, 11 Oct 2017 14:06:52 -0700 (PDT)
Message-ID: <20171011.140652.272274136617199385.davem@davemloft.net>
References: <20171010141419.88190-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171010141419.88190-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, hwippel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:14:19 +0200

> The goal of this patch is to leave common TCP code unmodified. Thus,
> it uses netfilter hooks to intercept TCP SYN and SYN/ACK
> packets. For outgoing packets originating from SMC sockets, the
> experimental option is added. For inbound packets destined for SMC
> sockets, the experimental option is checked.

I think this really isn't going to pass.

It's a user experience nightmare when the kernel inserts and
deletes filtering rules outside of what the user configures
on their system.

This approach was also considerd for ipv6 ILA, and the same
pushback was given.

Why not add support for these new options as a normal TCP
socket option based feature?  Then normal userspace as well
as the SMC stack can make use of it.
