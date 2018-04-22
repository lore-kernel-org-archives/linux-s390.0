From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/6] s390/qeth: fixes 2018-04-19
Date: Sun, 22 Apr 2018 14:42:58 -0400 (EDT)
Message-ID: <20180422.144258.458947796346979017.davem@davemloft.net>
References: <20180419105211.83935-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419105211.83935-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Thu, 19 Apr 2018 12:52:05 +0200

> new mail address, same old me.
> 
> Please apply the following qeth fixes for 4.17. The common theme
> seems to be error handling improvements in various areas of cmd IO.
> 
> Patches 1-3 should also go back to stable.

Series applied and patches 1-3 queued up for -stable, thanks.
