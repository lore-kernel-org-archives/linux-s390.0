From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/3] net/iucv: fixes 2018-09-05
Date: Wed, 05 Sep 2018 22:32:49 -0700 (PDT)
Message-ID: <20180905.223249.1191243841359960925.davem@davemloft.net>
References: <20180905145512.30165-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180905145512.30165-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Wed,  5 Sep 2018 16:55:09 +0200

> please apply three straight-forward fixes for iucv. One that prevents
> leaking the skb on malformed inbound packets, one to fix the error
> handling on transmit error, and one to get rid of a compile warning.

Series applied, thank you.
