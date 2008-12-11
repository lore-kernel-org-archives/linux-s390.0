From: frank.blaschka@de.ibm.com
Subject: [patch 0/4] s390: qeth fixes 2.6.29
Date: Thu, 11 Dec 2008 14:23:09 +0100
Message-ID: <20081211132309.053505000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Jeff,

here are some fixes for 2.6.29
The patches apply to linux-next

shortlog:
Klaus Wacker (1)
qeth: HiperSockets mcl string conversion (pre z9 mach)

Ursula Braun (2)
qeth: exploit source MAC address for inbound layer3 packets
qeth: avoid crash in case of layer mismatch for VSWITCH

Frank Blaschka (1)
qeth: do not spin for SETIP ip assist command

Thanks,
        Frank

-- 
