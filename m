From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2 net 1/1] net/ipv4: disable SMC TCP option with SYN
 Cookies
Date: Sun, 25 Mar 2018 20:54:20 -0400 (EDT)
Message-ID: <20180325.205420.1975422732296767038.davem@davemloft.net>
References: <20180323100545.78607-1-ubraun@linux.vnet.ibm.com>
        <20180323100545.78607-2-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180323100545.78607-2-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, hwippel@linux.vnet.ibm.com, eric.dumazet@gmail.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 11:05:45 +0100

> From: Hans Wippel <hwippel@linux.vnet.ibm.com>
> 
> Currently, the SMC experimental TCP option in a SYN packet is lost on
> the server side when SYN Cookies are active. However, the corresponding
> SYNACK sent back to the client contains the SMC option. This causes an
> inconsistent view of the SMC capabilities on the client and server.
> 
> This patch disables the SMC option in the SYNACK when SYN Cookies are
> active to avoid this issue.
> 
> Fixes: 60e2a7780793b ("tcp: TCP experimental option for SMC")
> Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

Applied, thank you.
