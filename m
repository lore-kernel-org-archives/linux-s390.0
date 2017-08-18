From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/7] s390/net: more updates for 4.14
Date: Fri, 18 Aug 2017 10:19:03 +0200
Message-ID: <20170818081910.48869-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply another batch of qeth patches for net-next.
This reworks the xmit path for L2 OSAs to use skb_cow_head() instead of
skb_realloc_headroom().

Thanks,
Julian

Julian Wiedmann (7):
  s390/qeth: split L2 xmit paths
  s390/qeth: pass full data length to l2_fill_header()
  s390/qeth: pass TSO header length to fill_buffer()
  s390/qeth: pass TSO data offset to fill_buffer()
  s390/qeth: pass full IQD header length to fill_buffer()
  s390/qeth: unify code to build header elements
  s390/qeth: use skb_cow_head() for L2 OSA xmit

 drivers/s390/net/qeth_core.h      |   8 +-
 drivers/s390/net/qeth_core_main.c |  78 +++++++-----
 drivers/s390/net/qeth_l2_main.c   | 243 ++++++++++++++++++++++----------------
 drivers/s390/net/qeth_l3_main.c   |  18 +--
 4 files changed, 206 insertions(+), 141 deletions(-)

-- 
2.11.2
