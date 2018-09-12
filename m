From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2018-09-12
Date: Wed, 12 Sep 2018 15:31:31 +0200
Message-ID: <20180912133135.12335-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following qeth fixes for -net.

Patch 1 resolves a regression in an error path, while patch 2 enables
the SG support by default that was newly introduced with 4.19.
Patch 3 takes care of a longstanding problem with large-order
allocations, and patch 4 fixes a potential out-of-bounds access.

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: indicate error when netdev allocation fails
  s390/qeth: switch on SG by default for IQD devices
  s390/qeth: don't dump past end of unknown HW header

Wenjia Zhang (1):
  s390/qeth: use vzalloc for QUERY OAT buffer

 drivers/s390/net/qeth_core_main.c | 11 ++++++++---
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.16.4
