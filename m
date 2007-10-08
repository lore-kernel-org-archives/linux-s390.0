From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/1] [8021q] qeth-related patch for net-2.6.24
Date: Mon, 08 Oct 2007 17:05:04 +0200
Message-ID: <20071008150504.855164000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

the following patch is intended for 2.6.24.
It adds the capability to create unique ipv6-addresses for vlan devices
based on shared network cards (for example: s390/net/qeth devices).

Regards, Ursula
