Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4229 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732866AbgJARLx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:11:53 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/7] s390/ctcm: remove orphaned function declarations
Date: Thu,  1 Oct 2020 19:11:36 +0200
Message-Id: <20201001171136.46830-8-jwi@linux.ibm.com>
In-Reply-To: <20201001171136.46830-1-jwi@linux.ibm.com>
References: <20201001171136.46830-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

From: Vasily Gorbik <gor@linux.ibm.com>

drivers/s390/net/ctcm_fsms.h: fsm_action_nop - only declaration left
after commit 04885948b101 ("ctc: removal of the old ctc driver")

drivers/s390/net/ctcm_mpc.h: ctcmpc_open - only declaration left after
commit 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_fsms.h | 1 -
 drivers/s390/net/ctcm_mpc.h  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_fsms.h b/drivers/s390/net/ctcm_fsms.h
index 225737295cb4..d98c486724d4 100644
--- a/drivers/s390/net/ctcm_fsms.h
+++ b/drivers/s390/net/ctcm_fsms.h
@@ -159,7 +159,6 @@ extern const char *ctc_ch_state_names[];
 
 void ctcm_ccw_check_rc(struct channel *ch, int rc, char *msg);
 void ctcm_purge_skb_queue(struct sk_buff_head *q);
-void fsm_action_nop(fsm_instance *fi, int event, void *arg);
 
 /*
  * ----- non-static actions for ctcm channel statemachine -----
diff --git a/drivers/s390/net/ctcm_mpc.h b/drivers/s390/net/ctcm_mpc.h
index 441d7b211f0f..da41b26f76d1 100644
--- a/drivers/s390/net/ctcm_mpc.h
+++ b/drivers/s390/net/ctcm_mpc.h
@@ -228,7 +228,6 @@ static inline void ctcmpc_dump32(char *buf, int len)
 		ctcmpc_dumpit(buf, 32);
 }
 
-int ctcmpc_open(struct net_device *);
 void ctcm_ccw_check_rc(struct channel *, int, char *);
 void mpc_group_ready(unsigned long adev);
 void mpc_channel_action(struct channel *ch, int direction, int action);
-- 
2.17.1
