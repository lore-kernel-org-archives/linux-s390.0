Return-Path: <SRS0=ZPcH=QL=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2019-02-04
Date: Mon,  4 Feb 2019 17:40:05 +0100
Message-Id: <20190204164009.7245-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following four fixes to -net.

Patch 1 takes care of a common resource leak in various error paths, while the
second patch fixes a misordered kfree when cleaning up after an error.
The other two patches ensure that there's no stale work dangling on workqueues
when the qeth device has already been offlined and/or removed.

Thanks,
Julian


Julian Wiedmann (4):
  s390/qeth: release cmd buffer in error paths
  s390/qeth: fix use-after-free in error path
  s390/qeth: cancel close_dev work before removing a card
  s390/qeth: conclude all event processing before offlining a card

 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 31 ++++++++++++++++++++-----------
 drivers/s390/net/qeth_l2_main.c   |  8 ++++++--
 drivers/s390/net/qeth_l3_main.c   |  3 +++
 4 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.16.4
