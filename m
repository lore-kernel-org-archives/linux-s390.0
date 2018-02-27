Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/6] s390/qeth: fixes 2018-02-27 
Date: Tue, 27 Feb 2018 18:58:11 +0100
Message-Id: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply some more qeth patches for -net and stable.

One patch fixes a performance bug in the TSO path. Then there's several
more fixes for IP management on L3 devices - including a revert, so that
the subsequent fix cleanly applies to earlier kernels.
The final patch takes care of a race in the control IO code that causes
qeth to miss the cmd response, and subsequently trigger device recovery.

Thanks,
Julian


Julian Wiedmann (6):
  s390/qeth: fix overestimated count of buffer elements
  s390/qeth: fix IP removal on offline cards
  s390/qeth: fix double-free on IP add/remove race
  Revert "s390/qeth: fix using of ref counter for rxip addresses"
  s390/qeth: fix IP address lookup for L3 devices
  s390/qeth: fix IPA command submission race

 drivers/s390/net/qeth_core_main.c |  29 +++++----
 drivers/s390/net/qeth_l3.h        |  34 ++++++++++-
 drivers/s390/net/qeth_l3_main.c   | 123 ++++++++++++++++----------------------
 3 files changed, 102 insertions(+), 84 deletions(-)

-- 
2.13.5
