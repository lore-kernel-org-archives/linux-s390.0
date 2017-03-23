From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/3] s390/qeth patches for net
Date: Thu, 23 Mar 2017 14:55:07 +0100
Message-ID: <20170323135510.98972-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are 2 s390/qeth patches built for net fixing a problem with AF_IUCV
traffic through HiperSockets.
And we come up with an update for the MAINTAINERS file to establish
Julian as Co-Maintainer for drivers/s390/net and net/iucv.

Thanks, Ursula

Julian Wiedmann (2):
  s390/qeth: size calculation outbound buffers
  s390/qeth: no ETH header for outbound AF_IUCV

Ursula Braun (1):
  MAINTAINERS: add Julian Wiedmann

 MAINTAINERS                       |  2 ++
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c |  5 +++--
 drivers/s390/net/qeth_l2_main.c   |  5 +++--
 drivers/s390/net/qeth_l3_main.c   | 20 +++++++-------------
 5 files changed, 17 insertions(+), 18 deletions(-)
