Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20598 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728527AbgK3KKr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:47 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/6] s390/ctcm: updates 2020-11-30
Date: Mon, 30 Nov 2020 11:09:44 +0100
Message-Id: <20201130100950.42051-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi Jakub,

please apply the following patch series for ctcm to netdev's net-next tree.

Some rare ctcm updates by Sebastian, who cleans up all places where
in_interrupt() was used to determine the correct GFP_* mask for
allocations.
In the first three patches we can get rid of those allocations entirely,
as they just end up being copied into the skb.

Thanks,
Julian

Sebastian Andrzej Siewior (6):
  s390/ctcm: Avoid temporary allocation of struct th_header and
    th_sweep.
  s390/ctcm: Avoid temporary allocation of struct qllc.
  s390/ctcm: Avoid temporary allocation of struct pdu.
  s390/ctcm: Use explicit allocation mask in ctcmpc_unpack_skb().
  s390/ctcm: Use GFP_KERNEL in add_channel().
  s390/ctcm: Use GFP_ATOMIC in ctcmpc_tx().

 drivers/s390/net/ctcm_fsms.c | 15 +++-----
 drivers/s390/net/ctcm_main.c | 68 ++++++++----------------------------
 drivers/s390/net/ctcm_main.h |  5 ---
 drivers/s390/net/ctcm_mpc.c  | 39 ++++-----------------
 4 files changed, 24 insertions(+), 103 deletions(-)

-- 
2.17.1
