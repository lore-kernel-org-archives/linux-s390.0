Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgKBTef (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 14:34:35 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 08/15] net/smc: Add ability to work with extended SMC netlink API
Date: Mon,  2 Nov 2020 20:34:02 +0100
Message-Id: <20201102193409.70901-9-kgraul@linux.ibm.com>
In-Reply-To: <20201102193409.70901-1-kgraul@linux.ibm.com>
References: <20201102193409.70901-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

smc_diag module should be able to work with legacy and
extended netlink api. This is done by using the sequence field
of the netlink message header. Sequence field is optional and was
filled with a constant value MAGIC_SEQ in the current
implementation.
New constant values MAGIC_SEQ_V2 and MAGIC_SEQ_V2_ACK are used to
signal the usage of the new Netlink API between userspace and
kernel.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h |  7 +++++++
 net/smc/smc_diag.c            | 21 +++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 8cb3a6fef553..236c1c52d562 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -6,6 +6,13 @@
 #include <linux/inet_diag.h>
 #include <rdma/ib_user_verbs.h>
 
+/* Sequence numbers */
+enum {
+	MAGIC_SEQ = 123456,
+	MAGIC_SEQ_V2,
+	MAGIC_SEQ_V2_ACK,
+};
+
 /* Request structure */
 struct smc_diag_req {
 	__u8	diag_family;
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 44be723c97fe..bc2b616524ff 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -293,19 +293,24 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return skb->len;
+}
+
 static int smc_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 {
 	struct net *net = sock_net(skb->sk);
-
+	struct netlink_dump_control c = {
+		.min_dump_alloc = SKB_WITH_OVERHEAD(32768),
+	};
 	if (h->nlmsg_type == SOCK_DIAG_BY_FAMILY &&
 	    h->nlmsg_flags & NLM_F_DUMP) {
-		{
-			struct netlink_dump_control c = {
-				.dump = smc_diag_dump,
-				.min_dump_alloc = SKB_WITH_OVERHEAD(32768),
-			};
-			return netlink_dump_start(net->diag_nlsk, skb, h, &c);
-		}
+		if (h->nlmsg_seq >= MAGIC_SEQ_V2)
+			c.dump = smc_diag_dump_ext;
+		else
+			c.dump = smc_diag_dump;
+		return netlink_dump_start(net->diag_nlsk, skb, h, &c);
 	}
 	return 0;
 }
-- 
2.17.1
