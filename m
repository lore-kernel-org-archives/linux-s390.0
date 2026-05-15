Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3941C31C;
	Fri, 15 May 2026 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834058; cv=none; b=uH1colzsLBUn4JKlfd0PriocpzEZffeoWl0OnxAuIxii6l0bQLf+lwf43V+QyRK75zho19CN3C+dJCpERxnQLnWz1gIy0LeSrHqJ6Y6NPHWOfc6CdHjLhEoG1BsEXgEdsEJWOmA6KlvHlMGc5tdCrZ/2COlp13RQ6PCWvomh8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834058; c=relaxed/simple;
	bh=V6yEqaFQCoZI8qoiiyIiHOJF16Tl/iQVq/00WwwB25o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLV8bX1Su9NLklMCCvUGFLs+3a4HWHL5rb7D/ck8jdZj1s7XfeiXN+PKoYlfq6rzWSoxyTmFRd6tm6nTX5Ng0siWMeWkLJ/sKJwfeoDf2gAVkRcdwI3xfDRWVtD7BdPnRj7zHw5t9Yr4TRXzTwBW4kzudLQ9newnpZQOwhoWPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Rx0Zlvle; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Rx0Zlvle"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Y3nib956f6mGNZYwsjE/R02g8MxIpdLt/ccJKQbM66M=; b=Rx0ZlvleZQhuppC6zDjWw28UQo
	vrltkd3AVr9lVmeaabZ2oHNvXwZ2Q/dw9JKA7RKBytJCVm0uAHHPhuxg1hqFtCZuURsxBSRugBY3g
	5BBvtw6MO/0nmxa3Qk7YDCfV58vLRZKabL5kyoK3fdQrBQWYGYjkUnaFPtD+9BNm++B69RPyNZYPp
	B/KqgA6rpcOV1cdxHxuiGFn8JAKg7PRA5ryCtjq3zPsFhw3TDpfjkFzhhwUH/Ui2JB84VSvatX3Rz
	p0asd653PMtzAAq6taFIoENC40t+XzdmUbYqBSMI9CssAyVnIa5l5viptkPkzFlpF31VfRG16I3Jf
	9iaYo4Tg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzh-004bGv-2q;
	Fri, 15 May 2026 08:34:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:31 -0700
Subject: [PATCH net-next v2 7/7] tipc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
In-Reply-To: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043; i=leitao@debian.org;
 h=from:subject:message-id; bh=V6yEqaFQCoZI8qoiiyIiHOJF16Tl/iQVq/00WwwB25o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpKwRKKYcS1QkqhNpZrg3ef84+znnoD6pXlR
 VyBhF2NXcqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bWPpD/9b56rwVJ/8WTMaqjTyn17SnrQzZwoUHqpSlnmNhKOBIAyRfZ+G6X7dmB2eQ93ld+YSQGj
 h9cFihSTIAUG7szpwXTtU75DE2Tf4+gvnRkY0Rr/xOprNGvBY+DW8HICG3qEQniQUnWghhKnMta
 ZlQSRELprUyQjI+U8uaoJLMlm3JJJdQ28EbEQ1Ndd/Co4ytQYQ3iXSIepG2SwrP42W+eSGsu2Vv
 1kHarjeeYbbASvc8Qi4GdpBSkAixaBCdlWDP9XcXr4lXS8vh56I48E9vVIt6DDbnVuA3qSpCX9a
 eB+RvQSJFLnnyNk/lhGmBb//dhTxLJjE2PTJq7IEUkLodPELw90SG2Teqpbgn/yaLoN5Mv2YGyD
 U9CopoIzYp0l2P/mj7cb3FtPnh3XDCWED8q2sWE9X6iwvs7FWXm0aSxp0F8vISmGMUpqUyN2u8W
 BwO0bpqcjUABqDi+cm1o/TuXS5Vjfk9s4PZgUXVmm5RTJARgntWUraDbAF3hrFWC6GFqDo5VHwf
 nfAzNNVWbPSudjnPigpV5r2hcSi2UxJof9O8ribKn/99u5/I50bdyhkRXQJP/7G8Hfoij2QHLWY
 k9IV1+DXkCPCmY/2xYYOFlqtILlmp1YmRuXpxBTZcos6YOiM3P17imvRDbdoLs9swql9PpbBbJs
 6S2TCcZXNRv+JLw==
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

