From: frank.blaschka@de.ibm.com
Subject: [patch 0/7] s390: network patches for net-next
Date: Tue, 01 Feb 2011 09:16:47 +0100
Message-ID: <20110201081647.173934635@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some patches for net-next.

shortlog:
Ursula Braun (3)
qeth: show new mac-address if its setting fails
qeth: allow HiperSockets framesize change in suspend
qeth: allow OSA CHPARM change in suspend state

Frank Blaschka (1)
qeth: add more strict MTU checking

Horst Hartmann (1)
net,s390: provide architecture specific NET_SKB_PAD

Stefan Weil (2)
s390: Fix wrong size in memcmp (netiucv)
s390: Fix possibly wrong size in strncmp (smsgiucv)

Thanks,
        Frank
