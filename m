From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/6] s390/qeth: fixes 2018-11-02
Date: Fri,  2 Nov 2018 19:04:07 +0100
Message-ID: <20181102180413.53020-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one round of qeth fixes for -net.

Patch 1 is rather large and removes a use-after-free hazard from many of our
debug trace entries.
Patch 2 is yet another fix-up for the L3 subdriver's new IP address management
code.
Patch 3 and 4 resolve some fallout from the recent changes wrt how/when qeth
allocates its net_device.
Patch 5 makes sure we don't set reserved bits when building HW commands from
user-provided data.
And finally, patch 6 allows ethtool to play nice with new HW.

Thanks,
Julian


Julian Wiedmann (6):
  s390/qeth: sanitize strings in debug messages
  s390/qeth: fix HiperSockets sniffer
  s390/qeth: unregister netdevice only when registered
  s390/qeth: fix initial operstate
  s390/qeth: sanitize ARP requests
  s390/qeth: report 25Gbit link speed

 drivers/s390/net/qeth_core.h      |  27 +++--
 drivers/s390/net/qeth_core_main.c | 172 ++++++++++++++++---------------
 drivers/s390/net/qeth_core_mpc.h  |   4 +-
 drivers/s390/net/qeth_l2_main.c   |  39 +++----
 drivers/s390/net/qeth_l3_main.c   | 207 +++++++++++++-------------------------
 5 files changed, 207 insertions(+), 242 deletions(-)

-- 
2.16.4
