Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2019-01-25
Date: Fri, 25 Jan 2019 15:44:15 +0100
Message-Id: <20190125144423.81443-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply a first batch of qeth patches for net-next, primarily touching the
net_device parts of the driver.
In addition to the usual refactoring & code consolidation, patch 7 makes use of
netif_device_detach() to let the stack know when our control plane is down. This
helps quite a bit wrt to overall locking and proper init/shutdown sequencing.

Thanks,
Julian


Julian Wiedmann (8):
  s390/qeth: streamline TX buffer management
  s390/qeth: remove bogus netif_wake_queue()
  s390/qeth: consolidate open/stop netdev ops
  s390/qeth: register MAC address earlier
  s390/qeth: remove TX disable from online path
  s390/qeth: delay netdevice registration
  s390/qeth: detach netdevice while card is offline
  s390/qeth: remove VLAN tracking for L2 devices

 drivers/s390/net/qeth_core.h      |  14 +--
 drivers/s390/net/qeth_core_main.c | 132 ++++++++++-----------
 drivers/s390/net/qeth_core_mpc.h  |   1 +
 drivers/s390/net/qeth_l2_main.c   | 244 +++++++++++---------------------------
 drivers/s390/net/qeth_l3_main.c   | 113 +++++-------------
 5 files changed, 167 insertions(+), 337 deletions(-)

-- 
2.16.4
