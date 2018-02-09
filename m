From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/2] s390/qeth: fixes 2018-02-09
Date: Fri,  9 Feb 2018 11:03:48 +0100
Message-ID: <20180209100350.60572-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following two qeth patches for 4.16 and stable.

One restricts a command quirk to the intended commandd type,
while the other fixes an off-by-one during data transmission
that can cause qeth to build malformed buffer descriptors.

Thanks,
Julian


Julian Wiedmann (1):
  s390/qeth: fix SETIP command handling

Ursula Braun (1):
  s390/qeth: fix underestimated count of buffer elements

 drivers/s390/net/qeth_core.h      |  7 ++++++-
 drivers/s390/net/qeth_core_main.c | 14 ++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.13.5
