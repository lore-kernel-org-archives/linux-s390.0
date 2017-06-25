From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] net/iucv: improve endianness handling
Date: Sun, 25 Jun 2017 11:43:11 -0400 (EDT)
Message-ID: <20170625.114311.1334785519251494698.davem@davemloft.net>
References: <20170623173228.70128-1-jwi@linux.vnet.ibm.com>
        <20170623173228.70128-2-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170623173228.70128-2-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 19:32:27 +0200

> From: Hans Wippel <hwippel@linux.vnet.ibm.com>
> 
> Use proper endianness conversion for an skb protocol assignment. Given
> that IUCV is only available on big endian systems (s390), this simply
> avoids an endianness warning reported by sparse.
> 
> Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
> Reviewed-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Applied.
