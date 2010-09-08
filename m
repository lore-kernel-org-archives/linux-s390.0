From: frank.blaschka@de.ibm.com
Subject: [patch 0/4] s390: network patches for net-next
Date: Wed, 08 Sep 2010 09:14:38 +0200
Message-ID: <20100908071438.085729717@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 network patches for net-next.
We finally made it and converted the qeth layer 2 and layer 3
driver to NAPI (thanks to Jan Glauber who did the QDIO part).

shortlog:
Jan Glauber (1)
qdio: extend API to allow polling

Joe Perches (1)
qeth: Use %pI6

Mike Frysinger (1)
Kconfig: have CCWGROUP depend on CLAW

Frank Blaschka (1)
qeth: NAPI support for l2 and l3 discipline

Thanks,
        Frank
