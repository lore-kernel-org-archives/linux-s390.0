Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] s390/qeth: fix a missing-check bug
Date: Sat,  6 Oct 2018 11:08:23 -0500
Message-Id: <1538842104-26018-1-git-send-email-wang6495@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:S390 NETWORK DRIVERS" <linux-s390@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

In qeth_snmp_command(), the length of the user request is firstly copied
from the user-space buffer 'udata' to the kernel variable 'req_len' and
checked to see whether it is too large. If the check fails, an error code
EINVAL is returned. Otherwise, the execution continues and the whole buffer
is copied again from 'udata' and saved to the kernel buffer 'ureq'.
However, after the second copy, no re-check is enforced on the newly-copied
request length. Given that the buffer 'udata' is in the user space, a
malicious user can race to change the request length between the two
copies. In this way, the attacker can supply malicious data to the kernel
and cause undefined behavior.

This patch adds a re-check on the request length after the second copy from
the buffer 'udata'. If the newly-copied value is different from the value
obtained in the first copy, i.e., 'req_len', an error code EINVAL will be
returned after the buffer 'ureq' is freed.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/s390/net/qeth_core_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index de82824..6199743 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4613,6 +4613,10 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		QETH_CARD_TEXT(card, 2, "snmpnome");
 		return PTR_ERR(ureq);
 	}
+	if (ureq->hdr.req_len != req_len) {
+		kfree(ureq);
+		return -EINVAL;
+	}
 	qinfo.udata_len = ureq->hdr.data_len;
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
-- 
2.7.4
