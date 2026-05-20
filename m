Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9A3F65E0;
	Wed, 20 May 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296084; cv=none; b=kHDj5JjC7tTCo1ASzTeffjomZ58FxFVYEjaV+t89vw+q1CYSBHC2qRYcKI1of+V4GouA6yMFkKgb5/gTqtlPWHa5VydD1m3O5KHuedTpj0e/pmmSrGJJ9cJMAc7HeytOsOo0W4GKRK2bx++VVGFER1BecYuZglC1mPXoBW+Q/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296084; c=relaxed/simple;
	bh=EJ91vFLbXslMvIHRojLDFKgOipEyDnI9YsoyRqBaYVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YlqhUYEmB6NTk1bLtewmt4HviNn/q2Ugi4Bh0m4e20ZkNgSSg6AARyt16YgUgLPQdNiBie3cltTzCZ5zfxfFbSnyXWXvqh45i1xIdjgLmv5f/Lx8E4ietlqsHkz2974VSQct7bwlWDZO8PRR36PFscs6OGfEmozOhN70InQ+PVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MBmvsGU+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MBmvsGU+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=R9vdjw1UBOL4Hyoux1kOF6cKvhkh6pXtVIRprxY+a+g=; b=MBmvsGU+I9nZL0psA6vayRNoH3
	MqxPfwFe3lnlOqTRZWa9ClPh0Mp3jhXaczm0NqpUdquSShZ4e4rngIzVHClnLFIKV9WzYK6F5KqEA
	lKtLnr1SrRV+iYg8gwxgfNcLy5NEJMNeSF6889+z97ozgQ+91WtKJtczeStHo3Ij/hO+IZd3SJGzd
	mrgFBbTt1JPW0RROoZvPYLDtTZ6oL397Afckw7f0R3zrbbfzAGKIByd4bgxYc+N5lE3/4hlmwCIds
	dbq1eRz3ngVILS9ubI2adzTROl5V3zTdQnXxec/fwSnHoZQxdECfMqM2Io2igH7FZrg9RJLi6Ub+G
	yqwF5NDw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBp-003FVj-14;
	Wed, 20 May 2026 16:54:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:51 -0700
Subject: [PATCH net-next v3 6/6] tipc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-6-b8c0b16b7780@debian.org>
References: <20260520-getsock_four-v3-0-b8c0b16b7780@debian.org>
In-Reply-To: <20260520-getsock_four-v3-0-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223; i=leitao@debian.org;
 h=from:subject:message-id; bh=EJ91vFLbXslMvIHRojLDFKgOipEyDnI9YsoyRqBaYVE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecgoa2ed7mODMXM5hFG0/d4ScsBrKhwLkdx0
 m4Gsba1ip+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bVL/D/0UzBVtCzaf2YRbFbhLxaS3xilITTsnr/snaC5W1anUe/JAvVLYUuM9RMwBW59Z8/IEOAN
 t2nltU1DxtoCS8v3/Nh8cN3fP804Q/VlS9weCQOD3Veq1UYAyAf101749+7/8x6TtvgdvM6rGL8
 X5gUqzjIcHlZvV33S4lsp/ZLuhxP+iBWnCoaUvEUqSG8rGovhST672w/z4akyYM6Sep02kzkl3L
 w4Cb9lk3Aq7iXF+VvyzfPKArVWNrMGIaFmgWAFzlVK5g78G1+jEFDcbHzmQ+U28tBI2xMD86PTb
 Pg3Wjb4lFqVew1oGf60ECbbJrUf4QstnLRo7zFGl2ocN8x0i8aAbiFJMqJBo7RF82lcxIxKRBoD
 3G/4/QtKHLLgmsD++bzViEdQkyCj6fB7wbH9ZGTD5IPm/E9Y6qwmjaM2FwVyEVJAs6Ro9dIh80W
 JynRPVwC45WqJA3gWcUFDmKHJb/M96/F19/eXkcUueZXC1Dw6EjsO1g7ymMwpNKL2TZf+bqPIVQ
 BDNCQf/BfVotZqIelgPSebNYqzYkQLRyuuuCKpWrNMsp00ldEE2RidHDZo278aZSV37tqH7nXwL
 +SF9Zg8MpZiut+PYUyhOBUuSL0Y6s6CjtPjWqeWr6fcZSnHhhc35JY4p1l+/PnEblVCVPVVtoM9
 jJgeqAw8jWXpDoA==
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
Also dropped two now-stale comments that referred to the old "res"
variable handling.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/tipc/socket.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..3a94278a44ac4 100644
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
@@ -3284,15 +3283,17 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
 	release_sock(sk);
 
 	if (res)
-		return res;	/* "get" failed */
+		return res;
 
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

