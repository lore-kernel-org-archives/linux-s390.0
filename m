From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/15] s390/net: updates 2018-09-26
Date: Wed, 26 Sep 2018 18:29:01 +0200
Message-ID: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one more series of cleanups and small improvements for qeth
to net-next. Note that one patch needs to touch both af_iucv and qeth, in
order to untangle their receive paths.

Thanks,
Julian


Julian Wiedmann (15):
  s390/qeth: convert layer attribute to enum
  s390/qeth: use DEFINE_MUTEX for qeth_mod_mutex
  s390/qeth: fix discipline unload after setup error
  s390/qeth: on gdev release, reset drvdata
  net/af_iucv: locate IUCV header via skb_network_header()
  s390/qeth: replace open-coded skb_queue_walk()
  s390/qeth: remove additional skb refcount
  s390/qeth: re-use qeth_notify_skbs()
  s390/qeth: pass card pointer in iob callback
  s390/qeth: remove CARD_FROM_CDEV helper
  s390/qeth: remove various redundant code
  s390/qeth: consume local address events
  s390/qeth: re-indent qeth_check_ipa_data()
  s390/qeth: clean up drop conditions for received cmds
  s390/qeth: remove duplicated carrier state tracking

 drivers/s390/net/qeth_core.h      |  21 ++-
 drivers/s390/net/qeth_core_main.c | 373 ++++++++++++++++----------------------
 drivers/s390/net/qeth_core_sys.c  |  15 +-
 drivers/s390/net/qeth_l2_main.c   |  12 +-
 drivers/s390/net/qeth_l3_main.c   |  24 +--
 include/net/iucv/af_iucv.h        |   5 +
 net/iucv/af_iucv.c                |  42 ++---
 7 files changed, 200 insertions(+), 292 deletions(-)

-- 
2.16.4
