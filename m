Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgH0IRS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:17:18 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: don't let HW override the configured port role
Date: Thu, 27 Aug 2020 10:17:02 +0200
Message-Id: <20200827081705.21922-6-jwi@linux.ibm.com>
In-Reply-To: <20200827081705.21922-1-jwi@linux.ibm.com>
References: <20200827081705.21922-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The only time that our Bridgeport role should change is when we change
the configuration ourselves. In which case we also adjust our internal
state tracking, no need to do it again when we receive the corresponding
event.

Removing the locked section helps a subsequent patch that needs to flush
the workqueue while under sbp_lock.

It would be nice to raise a warning here in case HW does weird things
after all, but this could end up generating false-positives when we
change the configuration ourselves.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ea966713ce7e..5a023fc499eb 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1107,12 +1107,6 @@ static void qeth_bridge_state_change_worker(struct work_struct *work)
 		NULL
 	};
 
-	/* Role should not change by itself, but if it did, */
-	/* information from the hardware is authoritative.  */
-	mutex_lock(&data->card->sbp_lock);
-	data->card->options.sbp.role = entry->role;
-	mutex_unlock(&data->card->sbp_lock);
-
 	snprintf(env_locrem, sizeof(env_locrem), "BRIDGEPORT=statechange");
 	snprintf(env_role, sizeof(env_role), "ROLE=%s",
 		(entry->role == QETH_SBP_ROLE_NONE) ? "none" :
-- 
2.17.1
