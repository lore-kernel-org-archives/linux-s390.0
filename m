Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 2/2] s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its function
Date: Sat, 8 Sep 2018 18:26:28 +0800
Message-ID: <1536402388-23872-3-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jwi@linux.ibm.com, ubraun@linux.ibm.com, jdelvare@suse.de
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

ARRAY_SIZE has implemented its function. we prefer to use the function
rather than the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/net/qeth_core_mpc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index 5bcb8da..e8263de 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -222,8 +222,7 @@ struct ipa_rc_msg {
 char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
 {
 	int x = 0;
-	qeth_ipa_rc_msg[sizeof(qeth_ipa_rc_msg) /
-			sizeof(struct ipa_rc_msg) - 1].rc = rc;
+	qeth_ipa_rc_msg[ARRAY_SIZE(qeth_ipa_rc_msg) - 1].rc = rc;
 	while (qeth_ipa_rc_msg[x].rc != rc)
 		x++;
 	return qeth_ipa_rc_msg[x].msg;
@@ -270,9 +269,7 @@ struct ipa_cmd_names {
 char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd)
 {
 	int x = 0;
-	qeth_ipa_cmd_names[
-		sizeof(qeth_ipa_cmd_names) /
-			sizeof(struct ipa_cmd_names)-1].cmd = cmd;
+	qeth_ipa_cmd_names[ARRAY_SIZE(qeth_ipa_cmd_names) - 1].cmd = cmd;
 	while (qeth_ipa_cmd_names[x].cmd != cmd)
 		x++;
 	return qeth_ipa_cmd_names[x].name;
-- 
1.7.12.4
