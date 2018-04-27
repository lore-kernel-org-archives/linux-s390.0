From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 0/4] fixes from 2018-04-17 - v3
Date: Fri, 27 Apr 2018 14:03:18 -0400 (EDT)
Message-ID: <20180427.140318.1821264434250683277.davem@davemloft.net>
References: <20180426151823.78967-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426151823.78967-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 26 Apr 2018 17:18:19 +0200

> Version 3 changes
>    * no deferring of setsockopts TCP_NODELAY and TCP_CORK anymore
>    * allow fallback for some sockopts eliminating SMC usage
>    * when setting TCP_NODELAY always enforce data transmission
>      (not only together with corked data)

This looks a lot better than what you were doing before.

Series applied, thanks.
