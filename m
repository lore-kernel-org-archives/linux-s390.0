From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/7] s390 patches for net-next
Date: Wed,  5 Apr 2017 10:40:08 +0200
Message-ID: <20170405084015.35772-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some cleanup patches for drivers/s390/net.

Thanks, Ursula

Hans Wippel (3):
  s390/qeth: improve endianness handling
  s390/ctcm: improve endianness handling
  s390/netiucv: improve endianness handling

Julian Wiedmann (4):
  s390/qeth: use QDIO_*_QFMT defines
  s390/qeth: fix up ssqd tracing
  s390/qeth: remove unused return value
  s390/qeth: Remove unused code

 drivers/s390/net/ctcm_fsms.c      |  2 +-
 drivers/s390/net/ctcm_main.c      | 12 +++++-----
 drivers/s390/net/netiucv.c        |  2 +-
 drivers/s390/net/qeth_core.h      | 16 ++-----------
 drivers/s390/net/qeth_core_main.c | 35 +++++++++++++--------------
 drivers/s390/net/qeth_core_mpc.h  | 17 -------------
 drivers/s390/net/qeth_l2_main.c   |  1 -
 drivers/s390/net/qeth_l2_sys.c    |  3 ---
 drivers/s390/net/qeth_l3_main.c   | 50 ++++++++++++++++++---------------------
 drivers/s390/net/qeth_l3_sys.c    |  4 ++--
 10 files changed, 51 insertions(+), 91 deletions(-)

-- 
2.10.2
