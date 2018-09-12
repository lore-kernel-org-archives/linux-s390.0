From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/4] s390/qeth: fixes 2018-09-12
Date: Wed, 12 Sep 2018 13:13:16 -0700 (PDT)
Message-ID: <20180912.131316.1889118317549376909.davem@davemloft.net>
References: <20180912133135.12335-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180912133135.12335-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed, 12 Sep 2018 15:31:31 +0200

> please apply the following qeth fixes for -net.
> 
> Patch 1 resolves a regression in an error path, while patch 2 enables
> the SG support by default that was newly introduced with 4.19.
> Patch 3 takes care of a longstanding problem with large-order
> allocations, and patch 4 fixes a potential out-of-bounds access.

Series applied, thanks Julian.
