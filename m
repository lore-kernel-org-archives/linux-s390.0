Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728690AbgGNOXV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:23:21 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/10] s390/qeth: use u64_to_user_ptr() in the OAT code
Date: Tue, 14 Jul 2020 16:23:01 +0200
Message-Id: <20200714142305.29297-7-jwi@linux.ibm.com>
In-Reply-To: <20200714142305.29297-1-jwi@linux.ibm.com>
References: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Use the correct helper for casting to a user pointer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bd6489d87ede..31fa9ffc7cf4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4907,10 +4907,8 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 	rc = qeth_send_ipa_cmd(card, iob, qeth_setadpparms_query_oat_cb,
 			       &priv);
 	if (!rc) {
-		if (is_compat_task())
-			tmp = compat_ptr(oat_data.ptr);
-		else
-			tmp = (void __user *)(unsigned long)oat_data.ptr;
+		tmp = is_compat_task() ? compat_ptr(oat_data.ptr) :
+					 u64_to_user_ptr(oat_data.ptr);
 
 		if (copy_to_user(tmp, priv.buffer,
 		    priv.response_len)) {
-- 
2.17.1
