Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgIJQtV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 12:49:21 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 09/10] net/smc: use the retry mechanism for netlink messages
Date: Thu, 10 Sep 2020 18:48:28 +0200
Message-Id: <20200910164829.65426-10-kgraul@linux.ibm.com>
In-Reply-To: <20200910164829.65426-1-kgraul@linux.ibm.com>
References: <20200910164829.65426-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

When the netlink messages to be sent to the userspace
are too big for a single netlink message, send them in
chunks using the netlink_dump infrastructure. Modify the
smc diag dump code so that it can signal to the netlink_dump
infrastructure that it needs to send more data.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_diag.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index da9ba6d1679b..f15fca59b4b2 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -22,6 +22,15 @@
 #include "smc.h"
 #include "smc_core.h"
 
+struct smc_diag_dump_ctx {
+	int pos[2];
+};
+
+static struct smc_diag_dump_ctx *smc_dump_context(struct netlink_callback *cb)
+{
+	return (struct smc_diag_dump_ctx *)cb->ctx;
+}
+
 static void smc_gid_be16_convert(__u8 *buf, u8 *gid_raw)
 {
 	sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
@@ -193,13 +202,15 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 }
 
 static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
-			       struct netlink_callback *cb)
+			       struct netlink_callback *cb, int p_type)
 {
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
+	int snum = cb_ctx->pos[p_type];
 	struct nlattr *bc = NULL;
 	struct hlist_head *head;
+	int rc = 0, num = 0;
 	struct sock *sk;
-	int rc = 0;
 
 	read_lock(&prot->h.smc_hash->lock);
 	head = &prot->h.smc_hash->ht;
@@ -209,13 +220,18 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	sk_for_each(sk, head) {
 		if (!net_eq(sock_net(sk), net))
 			continue;
+		if (num < snum)
+			goto next;
 		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
-		if (rc)
-			break;
+		if (rc < 0)
+			goto out;
+next:
+		num++;
 	}
 
 out:
 	read_unlock(&prot->h.smc_hash->lock);
+	cb_ctx->pos[p_type] = num;
 	return rc;
 }
 
@@ -223,10 +239,10 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int rc = 0;
 
-	rc = smc_diag_dump_proto(&smc_proto, skb, cb);
+	rc = smc_diag_dump_proto(&smc_proto, skb, cb, SMCPROTO_SMC);
 	if (!rc)
-		rc = smc_diag_dump_proto(&smc_proto6, skb, cb);
-	return rc;
+		smc_diag_dump_proto(&smc_proto6, skb, cb, SMCPROTO_SMC6);
+	return skb->len;
 }
 
 static int smc_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
-- 
2.17.1
