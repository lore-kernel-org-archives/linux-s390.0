From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 00/15] s390/qeth: updates 2018-09-17
Date: Mon, 17 Sep 2018 09:10:43 -0700 (PDT)
Message-ID: <20180917.091043.1720111611079568601.davem@davemloft.net>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 17 Sep 2018 17:35:54 +0200

> please apply the following patchset to net-next. This brings more restructuring
> of qeth's transmit code (eliminating its last usage of skb_realloc_headroom()),
> and the usual mix of minor improvements & cleanups.

Series applied, thank you.
