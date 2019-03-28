Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/10] s390/qeth: updates 2019-03-28
Date: Thu, 28 Mar 2019 16:39:18 +0100
Message-Id: <20190328153928.87692-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply the following patchset to net-next. This reworks the control
IO code in qeth so that we no longer need to poll for cmd completion,
and refactors the IDX setup code to also use this improved IO path.

Thanks,
Julian


Julian Wiedmann (10):
  s390/qeth: defer RX modesetting
  s390/qeth: remove locking for RX modeset cache
  s390/qeth: add wrapper for IP table access
  s390/qeth: defer IPv6 address notifier events
  s390/qeth: convert IP table spinlock to mutex
  s390/qeth: don't poll for cmd IO completion
  s390/qeth: clarify default cmd callback
  s390/qeth: let qeth_notify_reply() set the notify reason
  s390/qeth: use callback to finalize cmd
  s390/qeth: send IDX cmds via qeth_send_control_data()

 drivers/s390/net/qeth_core.h      |  21 +-
 drivers/s390/net/qeth_core_main.c | 567 +++++++++++++++++++-------------------
 drivers/s390/net/qeth_l2_main.c   |  36 ++-
 drivers/s390/net/qeth_l3_main.c   | 167 +++++++----
 drivers/s390/net/qeth_l3_sys.c    |  20 +-
 5 files changed, 440 insertions(+), 371 deletions(-)

-- 
2.16.4
