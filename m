Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWIhL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 04:37:11 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/9] s390/qeth: clean up string ops in qeth_l3_parse_ipatoe()
Date: Wed, 23 Sep 2020 10:36:54 +0200
Message-Id: <20200923083700.44624-4-jwi@linux.ibm.com>
In-Reply-To: <20200923083700.44624-1-jwi@linux.ibm.com>
References: <20200923083700.44624-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Indicate the max number of to-be-parsed characters, and avoid copying
the address sub-string.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index ca9c95b6bf35..05fa986e30fc 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -409,21 +409,22 @@ static ssize_t qeth_l3_dev_ipato_add4_show(struct device *dev,
 static int qeth_l3_parse_ipatoe(const char *buf, enum qeth_prot_versions proto,
 		  u8 *addr, int *mask_bits)
 {
-	const char *start, *end;
-	char *tmp;
-	char buffer[40] = {0, };
+	const char *start;
+	char *sep, *tmp;
+	int rc;
 
-	start = buf;
-	/* get address string */
-	end = strchr(start, '/');
-	if (!end || (end - start >= 40)) {
+	/* Expected input pattern: %addr/%mask */
+	sep = strnchr(buf, 40, '/');
+	if (!sep)
 		return -EINVAL;
-	}
-	strncpy(buffer, start, end - start);
-	if (qeth_l3_string_to_ipaddr(buffer, proto, addr)) {
-		return -EINVAL;
-	}
-	start = end + 1;
+
+	/* Terminate the %addr sub-string, and parse it: */
+	*sep = '\0';
+	rc = qeth_l3_string_to_ipaddr(buf, proto, addr);
+	if (rc)
+		return rc;
+
+	start = sep + 1;
 	*mask_bits = simple_strtoul(start, &tmp, 10);
 	if (!strlen(start) ||
 	    (tmp == start) ||
-- 
2.17.1
