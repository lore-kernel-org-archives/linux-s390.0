Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2019-04-17
Date: Wed, 17 Apr 2019 18:17:27 +0200
Message-Id: <20190417161735.69637-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply some additional qeth patches to net-next. This patchset converts
the driver to use the kernel's multiqueue model.

Thanks,
Julian


Julian Wiedmann (8):
  s390/qeth: clarify naming for some QDIO helpers
  s390/qeth: handle error from qeth_update_from_chp_desc()
  s390/qeth: don't bother updating the last-tx time
  s390/qeth: don't keep statistics for tx timeout
  s390/qeth: add TX multiqueue support for IQD devices
  s390/qeth: add TX multiqueue support for OSA devices
  s390/qeth: simplify QoS code
  s390/qeth: stop/wake TX queues based on their fill level

 drivers/s390/net/qeth_core.h      |  36 +++---
 drivers/s390/net/qeth_core_main.c | 234 ++++++++++++++++++++++----------------
 drivers/s390/net/qeth_core_sys.c  |   7 +-
 drivers/s390/net/qeth_ethtool.c   |  17 +++
 drivers/s390/net/qeth_l2_main.c   |  38 ++++---
 drivers/s390/net/qeth_l3_main.c   |  53 +++++----
 6 files changed, 233 insertions(+), 152 deletions(-)

-- 
2.16.4
