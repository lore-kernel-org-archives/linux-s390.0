From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 00/13] s390: qeth patches
Date: Thu, 16 Jun 2016 16:18:50 +0200
Message-ID: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here are patches for the s390 qeth driver for net-next:

Patch 01 is a minor improvement for the bridgeport code in qeth.

Patches 02-07 take care about scatter/gather handling in qeth.

Patch 08 improves handling of multicast IP addresses in the qeth layer3
discipline.

Patches 09-11 improve netdev features related functions in qeth.

Patch 12 implements an outbound queue restriction for HiperSockets.

Patch 13 fixes a wrong indentation in qeth_l3_main.c causing a warning
with gcc-6.

Thanks,
Ursula


shortlog:

Eugene Crosser (7):
  qeth: Include error message for "OS Mismatch"
  qeth: refactor calculation of SBALE count
  qeth: clean up condition when tso is used
  qeth: fill netdevice->gso_* attributes accurately
  qeth: enable scatter/gather in layer 2 mode
  qeth: enable scatter/gather by default
  qeth: introduce linearization fail count to stats

Hans Wippel (3):
  qeth: add network device features for VLAN devices
  qeth: improve set_features error handling
  qeth: omit outbound queue 3 for unicast packets in Priority Queuing on
    HiperSockets

Lakhvich Dmitriy (1):
  qeth: optimize IP handling in rx_mode callback

Sebastian Ott (1):
  s390/qeth: fix indentation in qeth_l3_arp_query

Thomas Richter (1):
  qeth layer 2 and layer 3 common feature handling

 drivers/s390/net/qeth_core.h      |   45 +-
 drivers/s390/net/qeth_core_main.c |  231 ++++++---
 drivers/s390/net/qeth_core_sys.c  |    4 +
 drivers/s390/net/qeth_l2.h        |    7 +
 drivers/s390/net/qeth_l2_main.c   |  105 ++--
 drivers/s390/net/qeth_l3.h        |   31 +-
 drivers/s390/net/qeth_l3_main.c   | 1024 +++++++++++++++++--------------------
 drivers/s390/net/qeth_l3_sys.c    |   78 ++-
 8 files changed, 800 insertions(+), 725 deletions(-)

-- 
2.6.6
