From: frank.blaschka@de.ibm.com
Subject: [patch 0/6] s390: qeth fixes 2.6.29
Date: Fri, 02 Jan 2009 16:01:39 +0100
Message-ID: <20090102150139.830998000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Jeff,

here are some qeth fixes for 2.6.29

shortlog:
Klaus Wacker (2)
qeth: HiperSockets mcl string conversion (pre z9 mach)
qeth: No large send using EDDP for HiperSockets.

Ursula Braun (2)
qeth: exploit source MAC address for inbound layer3 packets
qeth: avoid crash in case of layer mismatch for VSWITCH

Frank Blaschka (1)
qeth: do not spin for SETIP ip assist command

Heiko Carstens (1)
qeth: get rid of extra argument after printk to dev_* conversion

Thanks,
        Frank

-- 
