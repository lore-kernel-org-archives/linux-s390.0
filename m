From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/4] net/smc: handle sockopt TCP_NODELAY
Date: Tue, 17 Apr 2018 15:23:08 -0400 (EDT)
Message-ID: <20180417.152308.2158598560471437905.davem@davemloft.net>
References: <20180417151815.77191-1-ubraun@linux.ibm.com>
        <20180417151815.77191-3-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180417151815.77191-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 17 Apr 2018 17:18:13 +0200

> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> 
> TCP sockopts must not interfere with the CLC handshake on the
> CLC socket. Therefore, we defer some of them till the CLC
> handshake has completed, like resetting TCP_NODELAY.
> 
> While touching setsockopt, the TCP_FASTOPEN sockopts are
> ignored, since SMC-connection setup is based on the TCP
> three-way-handshake.
> 
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

Especially with fast-open, if you don't support the socket option
you should signal an error.

Also, the deferral mechanism means you'll never properly propagate
any errors back to the user.  The kernel_setsockopt() return value
isn't validated at all.

Color me not impressed at all with this change.

These kind of things have to have clear and proper semantics, plus
full error processing with proper propagation back to the user.
