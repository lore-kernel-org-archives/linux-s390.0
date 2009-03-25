From: frank.blaschka@de.ibm.com
Subject: [patch 0/6] s390: qeth fixes for 2.6.30
Date: Wed, 25 Mar 2009 07:57:13 +0100
Message-ID: <20090325065713.054133000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are a couple of qeth fixes for 2.6.30

shortlog:
Kay Sievers (1)
qeth: struct device - replace bus_id with dev_name(), dev_set_name()

Klaus-Dieter Wacker (1)
qeth: unregister MAC addresses during recovery

Ursula Braun (1)
qeth: check for completion of a running recovery

Heiko Carstens(1)
qeth: fix wait_event_timeout handling

Frank Blaschka (2)
qeth: add statistics for tx csum
qeth: remove EDDP

Thanks,
        Frank
