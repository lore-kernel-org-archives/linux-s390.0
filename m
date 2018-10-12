From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/4] s390/qeth: updates 2018-10-12
Date: Fri, 12 Oct 2018 17:27:11 +0200
Message-ID: <20181012152715.6153-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one more patchset for net-next. This extends the TSO support
in qeth.

Thanks,
Julian


Julian Wiedmann (4):
  s390/qeth: make TSO controls protocol-agnostic
  s390/qeth: enhance TSO control sequence
  s390/qeth: add support for IPv6 TSO
  s390/qeth: add TSO support for L2 devices

 drivers/s390/net/qeth_core.h      |   5 +-
 drivers/s390/net/qeth_core_main.c | 159 ++++++++++++++++++++++++++++++++------
 drivers/s390/net/qeth_core_mpc.h  |  26 +++++++
 drivers/s390/net/qeth_l2_main.c   |  30 +++++--
 drivers/s390/net/qeth_l3_main.c   |  47 +++++------
 5 files changed, 210 insertions(+), 57 deletions(-)

-- 
2.16.4
