From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/8] s390/qeth: updates 2018-11-08
Date: Thu,  8 Nov 2018 15:06:14 +0100
Message-ID: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following qeth patches to net-next.

The first patch allows one more device type to query the FW for a MAC address,
the others are all basically just removal of duplicated or unused code.

Thanks,
Julian


Julian Wiedmann (8):
  s390/qeth: utilize virtual MAC for Layer2 OSD devices
  s390/qeth: handle af_iucv skbs in qeth_l3_fill_header()
  s390/qeth: unify transmit code
  s390/qeth: remove card list
  s390/qeth: replace open-coded cmd setup
  s390/qeth: remove two IPA command helpers
  s390/qeth: remove unused fallback in Layer3's MAC code
  s390/qeth: don't process hsuid in qeth_l3_setup_netdev()

 drivers/s390/net/qeth_core.h      |  19 +-----
 drivers/s390/net/qeth_core_main.c | 137 ++++++++++++++++---------------------
 drivers/s390/net/qeth_core_mpc.c  |   1 -
 drivers/s390/net/qeth_core_mpc.h  |  32 +++++----
 drivers/s390/net/qeth_l2_main.c   |  45 ++++---------
 drivers/s390/net/qeth_l3_main.c   | 138 +++++++-------------------------------
 6 files changed, 113 insertions(+), 259 deletions(-)

-- 
2.16.4
