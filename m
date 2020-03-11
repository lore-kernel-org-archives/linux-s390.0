Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2020-03-11
Date: Wed, 11 Mar 2020 18:07:08 +0100
Message-Id: <20200311170711.50376-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net tree.

Just one fix to get the RX buffer pool resizing right, with two
preparatory cleanups.
This is on the larger side given where we are in the -rc cycle, but a
big chunk of the delta is just refactoring to make the fix look nice.

I intentionally split these off from yesterday's series. No objections
if you'd rather punt them to net-next, the series should apply cleanly.

Thanks,
Julian

Julian Wiedmann (3):
  s390/qeth: use page pointers to manage RX buffer pool
  s390/qeth: refactor buffer pool code
  s390/qeth: implement smarter resizing of the RX buffer pool

 drivers/s390/net/qeth_core.h      |   4 +-
 drivers/s390/net/qeth_core_main.c | 161 ++++++++++++++++++++----------
 drivers/s390/net/qeth_core_sys.c  |   9 +-
 drivers/s390/net/qeth_l3_sys.c    |   9 +-
 4 files changed, 119 insertions(+), 64 deletions(-)

-- 
2.17.1
