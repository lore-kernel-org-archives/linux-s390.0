Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/10] s390/qeth: updates 2019-02-12
Date: Tue, 12 Feb 2019 18:33:15 +0100
Message-Id: <20190212173325.36555-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one more round of qeth patches to net-next.
This series targets the driver's control paths. It primarily brings improvements
to the error handling for sent cmds and received responses, along with the
usual cleanup and consolidation efforts.

Thanks,
Julian


Julian Wiedmann (10):
  s390/qeth: reduce data length for ARP cache query
  s390/qeth: consolidate filling of low-level cmd length fields
  s390/qeth: enable only required csum offload features
  s390/qeth: align csum offload with TSO control logic
  s390/qeth: limit trace to valid data of command request
  s390/qeth: simplify reply object handling
  s390/qeth: cancel cmd on early error
  s390/qeth: allow cmd callbacks to return errnos
  s390/qeth: convert bridgeport callbacks
  s390/qeth: convert remaining legacy cmd callbacks

 drivers/s390/net/qeth_core.h      |   8 +-
 drivers/s390/net/qeth_core_main.c | 498 +++++++++++++++++++-------------------
 drivers/s390/net/qeth_core_mpc.c  |  23 +-
 drivers/s390/net/qeth_core_mpc.h  |  15 --
 drivers/s390/net/qeth_l2_main.c   | 150 +++++-------
 drivers/s390/net/qeth_l3_main.c   | 128 ++++++----
 6 files changed, 394 insertions(+), 428 deletions(-)

-- 
2.16.4
