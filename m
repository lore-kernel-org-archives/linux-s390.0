Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/9] s390/qeth: updates 2019-02-28
Date: Thu, 28 Feb 2019 18:59:35 +0100
Message-Id: <20190228175944.24718-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,
please apply one more qeth patch series for net-next. This eliminates some of
the quirks in our reset code, and slims down the internal state machine.

Thanks,
Julian

Julian Wiedmann (9):
  s390/qeth: remove RECOVER state
  s390/qeth: enable/disable the HW trap a little earlier
  s390/qeth: unconditionally clear MAC_REGISTERED flag
  s390/qeth: call dev_close() during recovery
  s390/qeth: remove a redundant check for card->dev
  s390/qeth: don't defer close_dev work during recovery
  s390/qeth: remove driver-wide workqueue
  s390/qeth: don't special-case HW trap during suspend
  s390/qeth: drop redundant state checking

 drivers/s390/net/qeth_core.h      |  11 ++--
 drivers/s390/net/qeth_core_main.c |  47 ++---------------
 drivers/s390/net/qeth_core_sys.c  |  23 +++-----
 drivers/s390/net/qeth_l2_main.c   | 107 ++++++++++++--------------------------
 drivers/s390/net/qeth_l3_main.c   |  92 +++++++++-----------------------
 drivers/s390/net/qeth_l3_sys.c    |  12 ++---
 6 files changed, 80 insertions(+), 212 deletions(-)

-- 
2.16.4
