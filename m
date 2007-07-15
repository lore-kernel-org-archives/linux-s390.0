From: David Miller <davem@davemloft.net>
Subject: Re: [patch 3/3] s390: af_iucv: add lock when updating accept_q
Date: Sat, 14 Jul 2007 19:05:25 -0700 (PDT)
Message-ID: <20070714.190525.102575313.davem@davemloft.net>
References: <20070713085053.530802000@linux.vnet.ibm.com>
	<20070713085246.022609000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070713085246.022609000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: braunu@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, fpavlic@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>
Date: Fri, 13 Jul 2007 10:50:56 +0200

> From: Ursula Braun <braunu@de.ibm.com>
> 
> The accept_queue of an af_iucv socket will be corrupted, if
> adding and deleting of entries in this queue occurs at the
> same time (connect request from one client, while accept call
> is processed for another client).
> Solution: add locking when updating accept_q
> 
> Signed-off-by: Ursula Braun <braunu@de.ibm.com>
> Acked-by: Frank Pavlic <fpavlic@de.ibm.com>

Also applied, thanks.

In the future please us consistent formatting of your
changelog header lines.  I have to edit them by hand
and I'd like to stop having to do that.

Use something like:

[AF_IUCV]: Blah blah blah.

Thanks :)
