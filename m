From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/4] s390/net updates, part 2 (v2)
Date: Tue, 20 Jun 2017 16:00:30 +0200
Message-ID: <20170620140034.89661-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

thanks for the feedback. Here's an updated patchset that honours
the reverse christmas tree and drops the __packed attribute. Please apply.

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
