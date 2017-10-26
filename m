From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V3 net-next 0/3] TCP experimental option for SMC
 rendezvous
Date: Thu, 26 Oct 2017 18:00:49 +0900 (KST)
Message-ID: <20171026.180049.2232993331478555056.davem@davemloft.net>
References: <20171025090146.83471-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171025090146.83471-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 11:01:43 +0200

> SMC-capability is to be negotiated with a TCP experimental option.
> As requested during code review of our previous approach using
> netfilter hooks, here's a new version. It touches tcp-code in the
> first patch and exploits the new tcp flag in the smc-code.

Series applied.
