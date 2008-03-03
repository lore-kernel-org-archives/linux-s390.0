From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/1] [IUCV] patch for net-2.6.25
Date: Mon, 03 Mar 2008 14:16:10 +0100
Message-ID: <20080303131610.405835000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

this patch is intended for 2.6.25.
It enables compilation of net/iucv/iucv.c with !CONFIG_SMP.
Thanks to Jeff Sipek and Heiko Carstens.

Regards,
Ursula Braun
