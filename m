From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/2] s390/qeth: fixes 2018-02-09
Date: Fri, 09 Feb 2018 14:30:40 -0500 (EST)
Message-ID: <20180209.143040.1223224561100538630.davem@davemloft.net>
References: <20180209100350.60572-1-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180209100350.60572-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Fri,  9 Feb 2018 11:03:48 +0100

> please apply the following two qeth patches for 4.16 and stable.
> 
> One restricts a command quirk to the intended commandd type,
> while the other fixes an off-by-one during data transmission
> that can cause qeth to build malformed buffer descriptors.

Series applied, thanks.
