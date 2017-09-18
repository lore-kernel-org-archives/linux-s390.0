From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/9] s390/qeth: updates 2017-09-18
Date: Mon, 18 Sep 2017 21:18:13 +0200
Message-ID: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

first batch of patches for 4.15. One larger item in there is Hans'
addition of new configuration options for flexible packet processing
('VNIC characteristics'). The patch descriptions have all the details.
Please apply.

Thanks,
Julian

Hans Wippel (3):
  s390/qeth: add basic VNICC support
  s390/qeth: add VNICC enable/disable support
  s390/qeth: add VNICC get/set timeout support

Jens Remus (1):
  s390/qeth: tidy up parameter naming for qeth_do_send_packet()

Julian Wiedmann (5):
  s390/qeth: remove unused code in qdio_establish_cq()
  s390/qeth: don't take queue lock in send_packet_fast()
  s390/qeth: simplify L3 sysfs group management
  s390/qeth: translate SETVLAN/DELVLAN errors
  s390/qeth: fold VLAN handling into l3_rebuild_skb()

 drivers/s390/net/qeth_core.h      |  22 +-
 drivers/s390/net/qeth_core_main.c |  23 +-
 drivers/s390/net/qeth_core_mpc.c  |   4 +-
 drivers/s390/net/qeth_core_mpc.h  |  72 ++++++
 drivers/s390/net/qeth_l2.h        |   6 +
 drivers/s390/net/qeth_l2_main.c   | 517 ++++++++++++++++++++++++++++++++++++--
 drivers/s390/net/qeth_l2_sys.c    | 202 +++++++++++++--
 drivers/s390/net/qeth_l3_main.c   |  31 +--
 drivers/s390/net/qeth_l3_sys.c    |  45 +---
 9 files changed, 819 insertions(+), 103 deletions(-)

-- 
2.13.5
