Return-Path: <SRS0=el7m=UC=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2019-06-03
Date: Mon,  3 Jun 2019 17:04:42 +0200
Message-Id: <20190603150446.23351-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following set of qeth fixes to -net.

- The first two patches fix issues in the L3 driver's cast type
  selection for transmitted skbs.
- Alexandra adds a sanity check when retrieving VLAN information from
  neighbour address events.
- The last patch adds some missing error handling for qeth's new
  multiqueue code.

Thanks,
Julian


Alexandra Winter (1):
  s390/qeth: fix VLAN attribute in bridge_hostnotify udev event

Julian Wiedmann (3):
  s390/qeth: handle limited IPv4 broadcast in L3 TX path
  s390/qeth: don't use obsolete dst entry
  s390/qeth: handle error when updating TX queue count

 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 22 ++++++++----
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 59 +++++++++++++++++++------------
 4 files changed, 55 insertions(+), 30 deletions(-)

-- 
2.17.1
