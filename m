Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/12] s390/qeth: updates 2019-06-27
Date: Thu, 27 Jun 2019 17:01:21 +0200
Message-Id: <20190627150133.58746-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply another round of qeth updates for net-next.
This completes the conversion of the control path to use dynamically
allocated cmd buffers, along with some fine-tuning for the route
validation fix that recently went into -net.

Thanks,
Julian

Julian Wiedmann (12):
  s390/qeth: dynamically allocate simple IPA cmds
  s390/qeth: clarify parameter for simple assist cmds
  s390/qeth: dynamically allocate various cmds with sub-types
  s390/qeth: dynamically allocate diag cmds
  s390/qeth: dynamically allocate vnicc cmds
  s390/qeth: dynamically allocate MPC cmds
  s390/qeth: remove static cmd buffer infrastructure
  s390/qeth: streamline SNMP cmd code
  s390/qeth: consolidate pm code
  s390/qeth: consolidate skb RX processing in L3 driver
  s390/qeth: extract helper for route validation
  s390/qeth: move cast type selection into fill_header()

 drivers/s390/net/qeth_core.h      |  94 +++---
 drivers/s390/net/qeth_core_main.c | 517 +++++++++++-------------------
 drivers/s390/net/qeth_core_mpc.h  |  49 ++-
 drivers/s390/net/qeth_l2_main.c   | 201 +++++-------
 drivers/s390/net/qeth_l3_main.c   | 210 +++++-------
 5 files changed, 425 insertions(+), 646 deletions(-)

-- 
2.17.1
