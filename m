Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgGNOXU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:23:20 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 00/10] s390/qeth: updates 2020-07-14
Date: Tue, 14 Jul 2020 16:22:55 +0200
Message-Id: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net-next tree.

This brings a mix of cleanups for various parts of the control code.

Thanks,
Julian

Julian Wiedmann (10):
  s390/qeth: reject unsupported link type earlier
  s390/qeth: fine-tune errno when cmds are cancelled
  s390/qeth: only init the isolation mode when necessary
  s390/qeth: don't clear the configured isolation mode
  s390/qeth: clean up error handling for isolation mode cmds
  s390/qeth: use u64_to_user_ptr() in the OAT code
  s390/qeth: clean up a magic number in the OAT callback
  s390/qeth: cleanup OAT code
  s390/qeth: unify RX-mode hashtables
  s390/qeth: constify the MPC initialization data

 drivers/s390/net/qeth_core.h      |   8 +-
 drivers/s390/net/qeth_core_main.c | 193 +++++++++++++-----------------
 drivers/s390/net/qeth_core_mpc.c  |  16 +--
 drivers/s390/net/qeth_core_mpc.h  |  17 ++-
 drivers/s390/net/qeth_core_sys.c  |  20 ++--
 drivers/s390/net/qeth_l2_main.c   |   9 +-
 drivers/s390/net/qeth_l3_main.c   |  19 +--
 7 files changed, 120 insertions(+), 162 deletions(-)

-- 
2.17.1
