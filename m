From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: [PATCH 0/6 resend] s390: network patches for net-next
Date: Wed, 22 Oct 2014 12:18:01 +0200
Message-ID: <1413973087-18740-1-git-send-email-blaschka@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Frank Blaschka <blaschka@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

looks like there was a problem with my previous posting. Hope this time
it will work. Sorry for any inconvenience. The patches are mostly
cleanups and small enhancements for net-next

Thanks,
        Frank

Thomas Richter (6):
  qeth: qeth_core_main make local functions static
  qeth: fix some trace formating issues
  qeth: make local functions static in qeth_l3 module
  qeth: s390 ethernet device driver dependency
  lcs: replace sscanf by kstrto function
  ctcm: replace sscanf by kstrto function

 drivers/s390/net/Kconfig          |  2 +-
 drivers/s390/net/ctcm_sysfs.c     |  8 ++++----
 drivers/s390/net/lcs.c            | 11 ++++++-----
 drivers/s390/net/qeth_core.h      | 16 ----------------
 drivers/s390/net/qeth_core_main.c | 24 ++++++++++++++++++------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3.h        |  4 ----
 drivers/s390/net/qeth_l3_main.c   | 10 +++++-----
 8 files changed, 35 insertions(+), 42 deletions(-)

-- 
1.8.5.5
