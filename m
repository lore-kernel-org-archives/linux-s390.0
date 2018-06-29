From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/5] s390/qeth: fixes 2018-06-29
Date: Fri, 29 Jun 2018 19:45:49 +0200
Message-ID: <20180629174554.53718-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply a few qeth fixes for -net and your 4.17 stable queue.

Patches 1-3 fix several issues wrt to MAC address management that were
introduced during the 4.17 cycle.
Patch 4 tackles a long-standing issue with busy multi-connection workloads
on devices in af_iucv mode.
Patch 5 makes sure to re-enable all active HW offloads, after a card was
previously set offline and thus lost its HW context.

Thanks,
Julian


Julian Wiedmann (4):
  Revert "s390/qeth: use Read device to query hypervisor for MAC"
  s390/qeth: fix race when setting MAC address
  s390/qeth: don't clobber buffer on async TX completion
  s390/qeth: consistently re-enable device features

Vasily Gorbik (1):
  s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]

 drivers/s390/net/qeth_core.h      | 13 ++++++++++-
 drivers/s390/net/qeth_core_main.c | 47 +++++++++++++++++++++++----------------
 drivers/s390/net/qeth_l2_main.c   | 24 ++++++++++++--------
 drivers/s390/net/qeth_l3_main.c   |  3 ++-
 4 files changed, 57 insertions(+), 30 deletions(-)

-- 
2.16.4
