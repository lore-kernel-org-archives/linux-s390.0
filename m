From: frank.blaschka@de.ibm.com
Subject: [patch 0/3] s390: bug fixes for net
Date: Wed, 25 Jul 2012 10:34:26 +0200
Message-ID: <20120725083426.704834478@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some bug fixes for net.

shortlog:

Martin Schwidefsky (1)
net: wiznet add missing HAS_IOMEM dependency

Sebastian Ott (1)
netiucv: cleanup attribute usage

Ursula Braun (1)
qeth: repair crash in qeth_l3_vlan_rx_kill_vid()

Thanks,
        Frank
