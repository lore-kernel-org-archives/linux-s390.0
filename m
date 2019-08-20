Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/9] s390/net: updates 2019-08-20
Date: Tue, 20 Aug 2019 16:46:34 +0200
Message-Id: <20190820144643.64041-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patches to net-next. This series brings a mix
of cleanups and small improvements for various parts of qeth's control
path. Also, a minor cleanup for ctcm and lcs.

Thanks,
Julian


Julian Wiedmann (9):
  s390/qeth: use node_descriptor struct
  s390/qeth: propagate length of processed cmd IO data to callback
  s390/qeth: use correct length field in SNMP cmd callback
  s390/qeth: keep cmd alive after IO completion
  s390/qeth: merge qeth_reply struct into qeth_cmd_buffer
  s390/qeth: get vnicc sub-cmd type from reply data
  s390/qeth: streamline control code for promisc mode
  s390/ctcm: don't use intparm for channel IO
  s390/lcs: don't use intparm for channel IO

 drivers/s390/net/ctcm_fsms.c      |  42 ++---
 drivers/s390/net/ctcm_main.c      |   6 +-
 drivers/s390/net/ctcm_mpc.c       |   6 +-
 drivers/s390/net/lcs.c            |   6 +-
 drivers/s390/net/qeth_core.h      |  36 ++---
 drivers/s390/net/qeth_core_main.c | 261 ++++++++++++++----------------
 drivers/s390/net/qeth_core_mpc.h  |   1 -
 drivers/s390/net/qeth_l2_main.c   |  62 +++----
 drivers/s390/net/qeth_l3_main.c   |  24 +--
 9 files changed, 197 insertions(+), 247 deletions(-)

-- 
2.17.1
