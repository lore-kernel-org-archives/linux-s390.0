From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/13] s390/net: updates 2018-04-26
Date: Thu, 26 Apr 2018 09:42:11 +0200
Message-ID: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following patches to net-next. There's the usual
cleanups & small improvements, and Kittipon adds HW offload support
for IPv6 checksumming.

Thanks,
Julian


Julian Wiedmann (6):
  s390/qeth: skip QDIO queue handler indirection
  s390/qeth: convert vlan spinlock to mutex
  s390/qeth: don't worry about IPs on VLAN removal
  s390/qeth: extract csum offload helpers
  s390/qeth: disregard IPv4 header for RX csum offload
  s390/qeth: improve fallback to random MAC address

Kittipon Meesompop (6):
  s390/qeth: de-indent else after return
  s390/qeth: add stats counter for RX csum offload
  s390/qeth: query IPv6 assists during hardsetup
  s390/qeth: extend Checksum Offload Assists for IPv6
  s390/qeth: add IPv6 TX checksum offload support
  s390/qeth: add IPv6 RX checksum offload support

Ursula Braun (1):
  s390/net: set HW port number in netdevice

 drivers/s390/net/lcs.c            |   3 +
 drivers/s390/net/qeth_core.h      |  61 ++++++++---
 drivers/s390/net/qeth_core_main.c | 148 +++++++++++++++++----------
 drivers/s390/net/qeth_core_mpc.h  |   2 +
 drivers/s390/net/qeth_core_sys.c  |   2 +
 drivers/s390/net/qeth_l2_main.c   |  98 ++++++++----------
 drivers/s390/net/qeth_l3_main.c   | 207 +++++++-------------------------------
 7 files changed, 229 insertions(+), 292 deletions(-)

-- 
2.13.5
