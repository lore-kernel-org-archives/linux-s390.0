From: frank.blaschka@de.ibm.com
Subject: [patch 0/4] s390: qeth patches for net-next
Date: Fri, 26 Nov 2010 13:41:16 +0100
Message-ID: <20101126124116.123736494@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some patches for net-next.
The set contains also the patch from Sachin Sant to fix the s390 build.

shortlog:
Ursula Braun (1)
qeth: enable interface setup if LAN is offline

Joe Perches (1)
drivers/s390/net: Remove unnecessary semicolons

Sachin Sant (1)
qeth lcs: convert mc rwlock to RCU

Frank Blaschka (1)
qeth: l3 fix len in tso hdr

Thanks,
        Frank
