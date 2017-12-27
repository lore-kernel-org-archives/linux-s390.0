From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/4] s390/qeth: updates 2017-12-27
Date: Wed, 27 Dec 2017 17:44:27 +0100
Message-ID: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply some post-christmas leftovers for 4.16.
Two patches to improve IP address management on L3, and two that add
support to auto-config the transport mode on z/VM VNICs.
Note that one patch in the series touches arch/s390 (acked by Martin).

Thanks,
Julian


Julian Wiedmann (4):
  s390/qeth: improve error reporting on IP add/removal
  s390/qeth: use common helper to display rxip/vipa
  s390/diag: add diag26c support for VNIC info
  s390/qeth: support early setup for z/VM NICs

 arch/s390/include/asm/diag.h      |  44 +++++++++++++++-
 drivers/s390/net/qeth_core_main.c |  86 ++++++++++++++++++++++++++++----
 drivers/s390/net/qeth_l3.h        |  12 +++--
 drivers/s390/net/qeth_l3_main.c   |  36 ++++++++------
 drivers/s390/net/qeth_l3_sys.c    | 102 +++++++++++---------------------------
 5 files changed, 179 insertions(+), 101 deletions(-)

-- 
2.13.5
