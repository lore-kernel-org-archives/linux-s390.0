From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH RESEND net-next 00/12] s390: qeth patches
Date: Thu, 12 Jan 2017 15:48:31 +0100
Message-ID: <20170112144843.33463-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

yesterday I came up with 13 qeth patches. Since you have not been
happy with the 13th patch, I want to make sure that at least the
remaining 12 qeth patches can be applied to net-next. Here is the
resend of them.

Thanks,
Ursula

Julian Wiedmann (8):
  s390/qeth: Allow reading hsuid in state DOWN
  s390/qeth: Remove QETH_IP_HEADER_SIZE
  s390/qeth: drop qeth_l2_del_all_macs() parameter
  s390/qeth: don't convert return code twice
  s390/qeth: consolidate errno translation
  s390/qeth: extract qeth_l2_remove_mac()
  s390/qeth: shuffle MAC management functions around
  s390/qeth: issue STARTLAN as first IPA command

Thomas Richter (3):
  s390/qeth: rework RX/TX checksum offload
  s390/qeth: test RX/TX checksum offload reply
  s390/qeth: display warning for OSA3 RX/TX checksum offloading

Ursula Braun (1):
  s390/qeth: fix retrieval of vipa and proxy-arp addresses

 drivers/s390/net/qeth_core.h      |   5 -
 drivers/s390/net/qeth_core_main.c | 135 ++++++++++++++++++++-------
 drivers/s390/net/qeth_core_mpc.h  |  17 ++++
 drivers/s390/net/qeth_l2_main.c   | 189 ++++++++++++++++----------------------
 drivers/s390/net/qeth_l3_main.c   |  15 ---
 drivers/s390/net/qeth_l3_sys.c    |  33 ++++---
 6 files changed, 212 insertions(+), 182 deletions(-)

-- 
2.8.4
