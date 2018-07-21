From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 00/11] s390/qeth: updates 2018-07-19
Date: Sat, 21 Jul 2018 10:17:04 -0700 (PDT)
Message-ID: <20180721.101704.404073397352124746.davem@davemloft.net>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 19 Jul 2018 12:43:47 +0200

> please apply one more round of qeth patches to net-next.
> This brings additional performance improvements for the transmit code,
> and some refactoring to pave the way for using netdev_priv.
> Also, two minor fixes for rare corner cases.

Series applied, thanks Julian.
