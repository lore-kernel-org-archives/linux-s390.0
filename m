From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/15] s390/qeth: updates 2018-09-17
Date: Mon, 17 Sep 2018 17:35:54 +0200
Message-ID: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following patchset to net-next. This brings more restructuring
of qeth's transmit code (eliminating its last usage of skb_realloc_headroom()),
and the usual mix of minor improvements & cleanups.

Thanks,
Julian


Julian Wiedmann (15):
  s390/qeth: move L2 xmit code to core module
  s390/qeth: run non-offload L3 traffic over common xmit path
  s390/qeth: remove unused L3 xmit code
  s390/qeth: remove qeth_get_elements_no()
  s390/qeth: limit csum offload erratum to L3 devices
  s390/qeth: fix up protocol headers early
  s390/qeth: check size of required HW header cache object
  s390/qeth: prepare for copy-free TSO transmission
  s390/qeth: speed up TSO transmission
  s390/qeth: remove qeth_hdr_chk_and_bounce()
  s390/qeth: uninstall IRQ handler on device removal
  s390/qeth: invoke softirqs after napi_schedule()
  s390/qeth: fix typo in return value
  s390/qeth: fine-tune spinlocks
  s390/qeth: reduce 0-initializing when building IPA cmds

 drivers/s390/net/qeth_core.h      |  17 +-
 drivers/s390/net/qeth_core_main.c | 307 ++++++++++++++++++----------------
 drivers/s390/net/qeth_l2_main.c   | 116 +++++--------
 drivers/s390/net/qeth_l3_main.c   | 340 +++++++++++++-------------------------
 4 files changed, 334 insertions(+), 446 deletions(-)

-- 
2.16.4
