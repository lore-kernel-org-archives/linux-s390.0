From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 00/15] s390/net: updates 2017-12-20
Date: Wed, 20 Dec 2017 20:10:54 +0100
Message-ID: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

Please apply the following patch series for 4.16.
Nothing too exciting, mostly just beating the qeth L3 code into shape.

Thanks & happy holidays,
Julian


Elena Reshetova (2):
  net: convert lcs_reply.refcnt from atomic_t to refcount_t
  qeth: convert qeth_reply.refcnt from atomic_t to refcount_t

Julian Wiedmann (13):
  s390/qeth: use ip*_eth_mc_map helpers
  s390/qeth: drop CONFIG_QETH_IPV6
  s390/qeth: don't keep track of MAC address's cast type
  s390/qeth: consolidate qeth MAC address helpers
  s390/qeth: use ether_addr_* helpers
  s390/qeth: align L2 and L3 set_rx_mode() implementations
  s390/qeth: robustify qeth_get_ip_version()
  s390/qeth: clean up l3_get_cast_type()
  s390/qeth: recognize non-IP multicast on L3 transmit
  s390/qeth: unionize next-hop field in qeth L3 header
  s390/qeth: streamline l3_fill_header()
  s390/qeth: pass full data length to l3_fill_header()
  s390/qeth: replace open-coded in*_pton()

 drivers/s390/net/Kconfig          |   3 -
 drivers/s390/net/lcs.c            |  10 +-
 drivers/s390/net/lcs.h            |   3 +-
 drivers/s390/net/qeth_core.h      |  42 ++--
 drivers/s390/net/qeth_core_main.c |  19 +-
 drivers/s390/net/qeth_core_mpc.h  |  13 +-
 drivers/s390/net/qeth_l2.h        |   3 +-
 drivers/s390/net/qeth_l2_main.c   |  92 +++-----
 drivers/s390/net/qeth_l3.h        |   3 +-
 drivers/s390/net/qeth_l3_main.c   | 474 +++++++++++---------------------------
 drivers/s390/net/qeth_l3_sys.c    |  12 +
 11 files changed, 234 insertions(+), 440 deletions(-)

-- 
2.13.5
