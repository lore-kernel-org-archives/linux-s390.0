From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 00/10] net/smc: enhancements 2018/05/15
Date: Wed, 16 May 2018 11:51:16 -0400 (EDT)
Message-ID: <20180516.115116.1559448275234246427.davem@davemloft.net>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 15 May 2018 17:04:53 +0200

> here are smc patches for net-next. The first one is a fix for net-next
> commit 01d2f7e2cdd3 "net/smc: sockopts TCP_NODELAY and TCP_CORK".
> Patch 7 improves Connection Layer Control error handling, patch 10
> improves abnormal termination of link groups. The remaining patches
> from Karsten improve Link Layer Control code.

Series applied, thank you.
