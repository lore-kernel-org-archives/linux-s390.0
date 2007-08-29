From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/7] s390 - qeth patches for 2.6.23-rc3 (resend)
Date: Wed, 29 Aug 2007 11:26:51 +0200
Message-ID: <20070829092651.411517000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: frank.blaschka@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

-- 
Jeff,

this is a resend of the s390 / qeth patches sent on monday.
This time I have changed the wrong Subject line prefix of the patches
from "qeth" to "s390". Sorry!

qeth patches for 2.6.23-rc3:
- do not allow interruption of "ungroup"
- scatter gather mode: enforce rate limit
- don't return void function return values
- add tx checkumming for TSO/EDDP mode
- invoke qeth_clear_output_buffer only for allocated qdio queues.
- add specific message for exclusively used OSA-adapters
- drop ARP packets on HiperSockets

Regards,   Ursula Braun
