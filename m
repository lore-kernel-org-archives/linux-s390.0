From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/2] remove header_ops bug in qeth driver (part 2)
Date: Mon, 22 Oct 2007 16:16:13 +0200
Message-ID: <20071022141613.957690000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: frank.blaschka@de.ibm.com, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, apw@shadowen.org, kamalesh@linux.vnet.ibm.com, kaber@trash.net, shemminger@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Jeff,

another patch in include/linux/netdevice.h is necessary
to solve the qeth bug of 2.6.23-git

And an update of the MAINTAINERS file is appended.

Regards,   Ursula Braun
