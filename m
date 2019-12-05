Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2019-12-05
Date: Thu,  5 Dec 2019 14:33:01 +0100
Message-Id: <20191205133304.58895-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following fixes to your net tree.

The first two patches target the RX data path, the third fixes a memory
leak when shutting down a qeth device.

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: guard against runt packets
  s390/qeth: ensure linear access to packet headers
  s390/qeth: fix dangling IO buffers after halt/clear

 drivers/s390/net/qeth_core.h      |   4 +
 drivers/s390/net/qeth_core_main.c | 158 +++++++++++++++++++-----------
 drivers/s390/net/qeth_core_mpc.h  |  14 ---
 drivers/s390/net/qeth_ethtool.c   |   1 +
 drivers/s390/net/qeth_l2_main.c   |  12 +--
 drivers/s390/net/qeth_l3_main.c   |  13 +--
 6 files changed, 119 insertions(+), 83 deletions(-)

-- 
2.17.1
