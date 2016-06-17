From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 00/13] s390: qeth patches
Date: Thu, 16 Jun 2016 22:16:30 -0700 (PDT)
Message-ID: <20160616.221630.1823607686769158919.davem@davemloft.net>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 16:18:50 +0200

> here are patches for the s390 qeth driver for net-next:
> 
> Patch 01 is a minor improvement for the bridgeport code in qeth.
> 
> Patches 02-07 take care about scatter/gather handling in qeth.
> 
> Patch 08 improves handling of multicast IP addresses in the qeth layer3
> discipline.
> 
> Patches 09-11 improve netdev features related functions in qeth.
> 
> Patch 12 implements an outbound queue restriction for HiperSockets.
> 
> Patch 13 fixes a wrong indentation in qeth_l3_main.c causing a warning
> with gcc-6.

Series applied, thanks.
