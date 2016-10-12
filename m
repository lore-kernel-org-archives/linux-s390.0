From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/3] s390 network driver patches
Date: Wed, 12 Oct 2016 12:38:48 +0200
Message-ID: <cover.1476263985.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are 3 small patches for the s390 network drivers netiucv and lcs.
They are built for the net-tree.

Thanks, Ursula

Ursula Braun (2):
  s390/netiucv: get rid of one memcpy in netiucv_printuser
  s390/netiucv: improve checking of sysfs attribute buffer

Colin Ian King (1):
  s390/lcs: remove trailing space at end of dev_err message

 drivers/s390/net/lcs.c     |  2 +-
 drivers/s390/net/netiucv.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.8.4
