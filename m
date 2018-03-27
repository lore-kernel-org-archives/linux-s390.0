From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: use announced length in sock_recvmsg()
Date: Tue, 27 Mar 2018 12:00:13 -0400 (EDT)
Message-ID: <20180327.120013.338256766416207040.davem@davemloft.net>
References: <20180327084350.92847-1-ubraun@linux.vnet.ibm.com>
        <20180327084350.92847-2-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180327084350.92847-2-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 10:43:50 +0200

> Not every CLC proposal message needs the maximum buffer length.
> Due to the MSG_WAITALL flag, it is important to use the peeked
> real length when receiving the message.
> 
> Fixes: d63d271ce2b5ce ("smc: switch to sock_recvmsg()")
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

Applied, thank you.
