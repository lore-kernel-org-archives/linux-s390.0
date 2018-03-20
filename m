Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2018-03-20
Date: Tue, 20 Mar 2018 07:59:11 +0100
Message-Id: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

Please apply one final set of qeth patches for 4.16.
All of these fix long-standing bugs, so please queue them up for -stable
as well.

Thank you,
Julian


Julian Wiedmann (4):
  s390/qeth: free netdevice when removing a card
  s390/qeth: when thread completes, wake up all waiters
  s390/qeth: lock read device while queueing next buffer
  s390/qeth: on channel error, reject further cmd requests

 drivers/s390/net/qeth_core_main.c | 21 +++++++++++++++------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.13.5
