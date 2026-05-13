Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB3441036;
	Wed, 13 May 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675724; cv=none; b=SUE+XkxNnJSW7SB10IW6YC/VKhWQavMqr1Kf1zlb4JUrAMD+WELN3lXtzIWqEBg9OoXd+iI0uTnIBLti9vpZ1lcfkRQZDPUxtFja9HmuoXhYIP6uMo+uUp67Ym+oBY8QR832EKcVthwP/uo4S1/pdq0tgqDs4upZSe+4aayBrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675724; c=relaxed/simple;
	bh=Z0ETmeAmKPYR2VU1YRxV60q6d9tmgqfaakc7JmmhaPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqVSmH+NsnVPs6I5wHKAB1Z//DREnFHq4r6Lb3q4eKRPoRguP7P57qi+aE1E+BM6ZVgu17gkI050Lx0oZ78AswXj6HGjzW37qizo4ogZ6xMt6VjW73xbhpoIR8rNaAx6iRDTXSVFt38XvomgHMNQiz+ulh0QDkz3iK0+gxqMMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=T7mBH6Gh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="T7mBH6Gh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=W5I1vZx+Y2S9t7G7jWTlUs8gZMOuYDWt7ZsUgVBeDbg=; b=T7mBH6Gh4BDscnqfAuLtKoAzbB
	jax6nMGR60umeuA4US3h5Dwg1fT8IWVwiRbkvriHN21Rrhx8ozZ2s+/VJOUrgfmB7mdCprEnX3/9M
	JTL119BUsM4jZGbaoYODnWlGSKx0rWjjNFHVgb8y8ckcNEhGQZ1KghbknAmwWy4eeO3YH9/NuBFnY
	AQg2LrRjj+0tRDVw+8j/WWLzlRy2j45Gf2ldxn05ORsPA53843cDiz4386jTE8AYwMbbtXAyq/bWL
	uig27L9cbfP/8jfOnf+SnwyJYEvi3qwCfDezPsJL0uZUVFaUxh038s/liJOYa/ce24JxEtaFgOfMC
	Lnj/72uw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nv-003A9V-08;
	Wed, 13 May 2026 12:35:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:17 -0700
Subject: [PATCH net-next 6/6] tipc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
In-Reply-To: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
To: Chas Williams <3chas3@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
 Marc Dionne <marc.dionne@auristor.com>, 
 David Heidelberg <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org, 
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3995; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z0ETmeAmKPYR2VU1YRxV60q6d9tmgqfaakc7JmmhaPQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PaowN1KvCyr8CcTiJ0E7AwR2awXsEDIGLM
 nLu04vGNlGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bXNnD/0WM/D4XEOrsBMsAMLIfbsjBaNjvSj5/1ayamyCAhAAjDJWsHn3OLW6rXZBtOIEc72WVql
 GyutItuq0vfeobIoCrimQ3IJCHyyrZzUCNug7lUBhmbtUmMLUk5hEAE9SKM9UfrtWRbuJzGapgS
 0txO61a8vXUL33bcXfn+uT0emCvUDooT7DpOknLT8bttYQWeNyrfUAkZwOJ8vPjA9HGpkiV7rHG
 19DuOnjyX2/gvEuhhfVrFCfLts3cv/KYL5WYldgX3CovsTcz+rjfcxzDOd4waTvcSyZjxWDTeam
 ep1Iu6adQRosYK7BzRTJwxvUafsqrsflbe+cLalIlIUziTxilyBD2VmPBPSoeNNvKHtZc1gG2LY
 PUOrTZl9tqF21Tqvm4fqFrHfa01/jQ9Jw+v4lEr24f1VCClSw8EOA6SDog+/xG44cMPXiKjdVoU
 iRuuRBt2IQMElbmw9ULN8FlNYWZi5xj/Ib5TA+TCaiOlnvhdh4xorjvn41uofINk0zOYebGUHPx
 4YmSOjcukete1BJKckqG+QUrWZRuDK/zoP+bgb2Sk6xXcKwnlPmNilVjHqRXN/TYXmjxeJ3b3hg
 otzeihi/dlrbkPnF1Qsfcx2WA8PopJkIcEqZjJhzuWpdldua+d4fJuY7ZW87LSfM32ZlrPjvjyU
 V770VioEJZ26fEg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert TIPC sockets (msg, packet, stream proto_ops) to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
- Use sopt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

The sockopt_t parameter is named sopt to avoid collision with the
existing optname parameter named opt.

Note: Dropped the unnecessary parentheses to make checkpatch happier.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/tipc/socket.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..858aa6e9566d7 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -37,6 +37,7 @@
 
 #include <linux/rhashtable.h>
 #include <linux/sched/signal.h>
+#include <linux/uio.h>
 #include <trace/events/sock.h>
 
 #include "core.h"
@@ -3220,8 +3221,7 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
  * @sock: socket structure
  * @lvl: option level
  * @opt: option identifier
- * @ov: receptacle for option value
- * @ol: receptacle for length of option value
+ * @sopt: socket option container (input buffer length, output value/length)
  *
  * For stream sockets only, returns 0 length result for all IPPROTO_TCP options
  * (to ease compatibility).
@@ -3229,22 +3229,22 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
  * Return: 0 on success, errno otherwise
  */
 static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
-			   char __user *ov, int __user *ol)
+			   sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
 	struct tipc_service_range seq;
 	int len, scope;
+	int res = 0;
 	u32 value;
-	int res;
 
-	if ((lvl == IPPROTO_TCP) && (sock->type == SOCK_STREAM))
-		return put_user(0, ol);
+	if (lvl == IPPROTO_TCP && sock->type == SOCK_STREAM) {
+		sopt->optlen = 0;
+		return 0;
+	}
 	if (lvl != SOL_TIPC)
 		return -ENOPROTOOPT;
-	res = get_user(len, ol);
-	if (res)
-		return res;
+	len = sopt->optlen;
 
 	lock_sock(sk);
 
@@ -3260,7 +3260,6 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
 		break;
 	case TIPC_CONN_TIMEOUT:
 		value = tsk->conn_timeout;
-		/* no need to set "res", since already 0 at this point */
 		break;
 	case TIPC_NODE_RECVQ_DEPTH:
 		value = 0; /* was tipc_queue_size, now obsolete */
@@ -3289,10 +3288,12 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
 	if (len < sizeof(value))
 		return -EINVAL;
 
-	if (copy_to_user(ov, &value, sizeof(value)))
+	if (copy_to_iter(&value, sizeof(value), &sopt->iter_out) !=
+	    sizeof(value))
 		return -EFAULT;
+	sopt->optlen = sizeof(value);
 
-	return put_user(sizeof(value), ol);
+	return 0;
 }
 
 static int tipc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
@@ -3365,7 +3366,7 @@ static const struct proto_ops msg_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= tipc_shutdown,
 	.setsockopt	= tipc_setsockopt,
-	.getsockopt	= tipc_getsockopt,
+	.getsockopt_iter = tipc_getsockopt,
 	.sendmsg	= tipc_sendmsg,
 	.recvmsg	= tipc_recvmsg,
 	.mmap		= sock_no_mmap,
@@ -3385,7 +3386,7 @@ static const struct proto_ops packet_ops = {
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
 	.setsockopt	= tipc_setsockopt,
-	.getsockopt	= tipc_getsockopt,
+	.getsockopt_iter = tipc_getsockopt,
 	.sendmsg	= tipc_send_packet,
 	.recvmsg	= tipc_recvmsg,
 	.mmap		= sock_no_mmap,
@@ -3405,7 +3406,7 @@ static const struct proto_ops stream_ops = {
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
 	.setsockopt	= tipc_setsockopt,
-	.getsockopt	= tipc_getsockopt,
+	.getsockopt_iter = tipc_getsockopt,
 	.sendmsg	= tipc_sendstream,
 	.recvmsg	= tipc_recvstream,
 	.mmap		= sock_no_mmap,

-- 
2.53.0-Meta

