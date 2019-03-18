Return-Path: <SRS0=pZ4W=RV=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2019-03-18
Date: Mon, 18 Mar 2019 16:40:53 +0100
Message-Id: <20190318154056.4231-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following three patches to -net. The first two are fixes
for minor race conditions in the probe code, while the third one gets
dropwatch working (again).

Thanks,
Julian


Julian Wiedmann (3):
  s390/qeth: don't erase configuration while probing
  s390/qeth: fix race when initializing the IP address table
  s390/qeth: be drop monitor friendly

 drivers/s390/net/qeth_core_main.c | 5 ++++-
 drivers/s390/net/qeth_l2_main.c   | 7 +++----
 drivers/s390/net/qeth_l3_main.c   | 8 ++++----
 3 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.16.4
