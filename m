From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/4] s390/net updates, part 2
Date: Mon, 19 Jun 2017 13:22:21 +0200
Message-ID: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

some additional qeth patches for net-next, please apply.

Note: there's one out-of-topic modification to arch/s390 that
adds a new hypervisor call, for use in qeth. Heiko acked to upstream
this via your tree.

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: fix packing buffer statistics
  s390/diag: add diag26c support
  s390/qeth: use diag26c to get MAC address on L2

Kittipon Meesompop (1):
  s390/qeth: add ipa return codes for bridgeport

 arch/s390/include/asm/diag.h      | 26 +++++++++++++
 arch/s390/kernel/diag.c           | 29 +++++++++++++++
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 78 +++++++++++++++++++++++++++++++++++----
 drivers/s390/net/qeth_core_mpc.c  | 14 +++++++
 drivers/s390/net/qeth_core_mpc.h  | 18 +++++++++
 drivers/s390/net/qeth_l2_main.c   | 50 +++++++++++++++----------
 7 files changed, 190 insertions(+), 26 deletions(-)

-- 
2.11.2
