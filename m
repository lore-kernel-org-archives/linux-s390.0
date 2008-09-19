From: frank.blaschka@de.ibm.com
Subject: [patch 0/2] s390: qeth fixes 2.6.27-rc6
Date: Fri, 19 Sep 2008 12:56:01 +0200
Message-ID: <20080919105601.986966000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Jeff,

our internal regression found 2 more qeth bugs.

shortlog:
Ursula Braun (2)
qeth: use firmware MAC-address for layer2 hsi-devices
qeth: avoid qeth recovery problems

Thanks,
        Frank
-- 
