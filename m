From: frank.blaschka@de.ibm.com
Subject: [patch 0/4] s390: network patches for net-next
Date: Tue, 27 May 2014 11:13:41 +0200
Message-ID: <20140527091341.417448231@de.ibm.com>
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

Philipp Hachtmann (1)
af_iucv: Add automatic (source) iucv_name to bind

Ursula Braun (2)
af_iucv: correct cleanup if listen backlog is full
s390/net: fix format string mismatches

Rickard Strandqvist (1)
qeth: Fix for possible null pointer dereference

Thanks,
        Frank
