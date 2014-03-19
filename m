From: frank.blaschka@de.ibm.com
Subject: [patch 0/4] s390: network patches for net-next
Date: Wed, 19 Mar 2014 07:57:58 +0100
Message-ID: <20140319065758.841490297@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 related patches for net-next

shortlog:

Ursula Braun (1)
af_iucv: recvmsg problem for SOCK_STREAM sockets

Heiko Carstens (1)
qeth: make qeth_query_card_info_cb() static

Stefan Raspl (2)
qeth: Removed unused parameter
qeth: Fix IP version detection for VLAN traffic

Thanks,
        Frank
