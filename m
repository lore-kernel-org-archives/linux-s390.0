From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/2] s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its function
Date: Wed, 26 Sep 2018 18:07:09 +0200
Message-ID: <20180926160710.64739-2-jwi@linux.ibm.com>
References: <20180926160710.64739-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926160710.64739-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, zhong jiang <zhongjiang@huawei.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: zhong jiang <zhongjiang@huawei.com>

Use the common code ARRAY_SIZE macro instead of a private implementation.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index 5bcb8dafc3ee..e8263ded0af0 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -222,8 +222,7 @@ static struct ipa_rc_msg qeth_ipa_rc_msg[] = {
 char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
 {
 	int x = 0;
-	qeth_ipa_rc_msg[sizeof(qeth_ipa_rc_msg) /
-			sizeof(struct ipa_rc_msg) - 1].rc = rc;
+	qeth_ipa_rc_msg[ARRAY_SIZE(qeth_ipa_rc_msg) - 1].rc = rc;
 	while (qeth_ipa_rc_msg[x].rc != rc)
 		x++;
 	return qeth_ipa_rc_msg[x].msg;
@@ -270,9 +269,7 @@ static struct ipa_cmd_names qeth_ipa_cmd_names[] = {
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
2.16.4
