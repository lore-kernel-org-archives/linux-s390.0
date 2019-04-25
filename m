Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2019-04-25
Date: Thu, 25 Apr 2019 18:25:53 +0200
Message-Id: <20190425162601.91997-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one more patch series for qeth to net-next. Nothing special,
just a bunch of cleanups.

Thanks,
Julian

Arnd Bergmann (1):
  s390: qeth: address type mismatch warning

Julian Wiedmann (7):
  s390/qeth: remove RX seqno in skb->cb
  s390/qeth: clean up stale buffer state documentation
  s390/qeth: use IS_* helpers for checking device type
  s390/qeth: don't clear Output buffers on every queue init
  s390/qeth: cache max number of available buffer elements
  s390/qeth: extract helper to determine L2 cast type
  s390/qeth: trust non-IP cast type in qeth_l3_fill_header()

 drivers/s390/net/qeth_core.h      |  74 +++++++++++------------
 drivers/s390/net/qeth_core_main.c | 122 ++++++++++++++++----------------------
 drivers/s390/net/qeth_core_mpc.h  |   2 +-
 drivers/s390/net/qeth_core_sys.c  |   3 +-
 drivers/s390/net/qeth_l2_main.c   |  33 ++++-------
 drivers/s390/net/qeth_l3_main.c   |  43 +++++---------
 drivers/s390/net/qeth_l3_sys.c    |   6 +-
 7 files changed, 115 insertions(+), 168 deletions(-)

-- 
2.16.4
