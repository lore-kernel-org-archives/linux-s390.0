Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE533D75A0;
	Wed, 20 May 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296070; cv=none; b=EFhFSvznI16caaV6b9wprmtFfvXEr2+7C0K2jw2KBcQb+3eupctQgyhbO/Vdt0DotlBcUGy25Fx0zZuJWNW/wVsfpxKvfU0a+YdcC9kpJxxQ82SbhjqPYubtgzqvK7l57BzVRA/dywBX19TxK6qbBdYSd4h/J0EirgkHvj/EMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296070; c=relaxed/simple;
	bh=W56Zt/m5WtA6ZtxQtbYwmAFL4lHK2Y63RhGd2qkl1no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7D5dQ97dNQU+47UD9yXjhMChZ/hP7e8BLyWTZeLrA3m0JrGoXbRO9cTiALOp0Bui9qLyLpsEFxva1YzJWdpRViNCkGm7ylOI2Zu6IWp7rBS2VmtLOcTiX1A+0sSSn/1ABNGM3Pa8rLuCKHB0PE6HWz1syxZr9AcjktBLQxj4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tEXzPEbz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tEXzPEbz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=L1ykyjVwNL5KxggtxIRFk0UAsUP7TQjsS7m6hNH6g0o=; b=tEXzPEbzSVfFY+9B8ckBdixUvH
	FtiZwRgMGV0ANxAMQqRIB94vH4gsansm14D51dBEALiRbVEu4PP2VUR5JJndpl0oRtn2U142ppwE9
	r94ppW+XJH+BE60y1aLPS0U24MJZordTTVdxJLeK/vpo+/YQcnbMdIn0GoESkf3t2+4QKq1hJRDTl
	cJq73wPLZDl1Uj+RghqC6SI8IPCDfw99ScZUEYhkt1mXAVz2ppuYHN40P9cFd0RPhuoWUBR8ezGQI
	HiA/dVQT6LG3g8LJmb8h7Tp6OEgPSdzmRR+Ro7oy9qJIaSjfsqg8trOz7aosgNfqh1mr79v8kBAqp
	T2+cFizQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBc-003FUp-0c;
	Wed, 20 May 2026 16:54:24 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:49 -0700
Subject: [PATCH net-next v3 4/6] l2tp: ppp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-4-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=leitao@debian.org;
 h=from:subject:message-id; bh=W56Zt/m5WtA6ZtxQtbYwmAFL4lHK2Y63RhGd2qkl1no=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecg6zrKqBbm/paWH44fQIZrRaHflp4dK2qth
 d5viTMWxqGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bQY2D/9H5x44lC4NChNsXQn+Q0vXGTd+vDptTZyVBuYzSu4XaHFlhkMqyxi18C8r6avjT4zyVQy
 KZqbZi/thnPd8CdXvS9G0M7OgML4VEMHbgeSWV6FXSksaYLPvblbtUUiuy6dy9LpbhzFWX9RmTx
 XyWHYbxt42DarDTgGd3ZkyM0JxkCJHyMMgacWU/ZLs2J2w4eyHtkr2wRpwWqZwiBmOJCABLTIcs
 pLeRAbr10ZS0lGU9pP8koT24ivfQrhjWE7oFFXl1k1O+vg6D6L6UwGquxpGv26j5IJx9juSzE2W
 pax6QCURhoUriOZKjScFEjfq5WRTivjU4dVM3rSxzV/Gkz7YyAbXkG7LvRM3KFgXII7982osH81
 1ytasaJGCSHG5zkMldLOYdlpZqouYoCzlpR4boKYkEHA0uA5qMCepOJn4TYFj2T5/9K1pONmg88
 spHLU4VofQQSrflLgOhPLYPyFfxrY15FbpL+nZy8swv4RH/na3B0dXjDjNnT030OzvMbVDN+lrM
 6MAGxb7dkeWP0rO6gXn1Sb1fSm/ipzhLZt+M//NwyKzXPSf67uUEdn/gBl9EPkermB/4sa3R+UV
 2/jyrJybU8FI8QAzysDLaMt8AAN1Tqvg7t7ZVcJnD685fGCRWfa9GNcV4BLw7ekavkA0Qg3Gh6f
 H0LWwjEA2hjzDbA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert PPPoL2TP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/l2tp/l2tp_ppp.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 99d6582f41de2..46143e882af5e 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -59,6 +59,7 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -1317,7 +1318,7 @@ static int pppol2tp_session_getsockopt(struct sock *sk,
  * or the special tunnel type.
  */
 static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct l2tp_session *session;
@@ -1328,9 +1329,7 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_PPPOL2TP)
 		return -EINVAL;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1358,14 +1357,9 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 			goto end_put_sess;
 	}
 
-	err = -EFAULT;
-	if (put_user(len, optlen))
-		goto end_put_sess;
-
-	if (copy_to_user((void __user *)optval, &val, len))
-		goto end_put_sess;
-
-	err = 0;
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
+		err = -EFAULT;
 
 end_put_sess:
 	l2tp_session_put(session);
@@ -1634,7 +1628,7 @@ static const struct proto_ops pppol2tp_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= pppol2tp_setsockopt,
-	.getsockopt	= pppol2tp_getsockopt,
+	.getsockopt_iter = pppol2tp_getsockopt,
 	.sendmsg	= pppol2tp_sendmsg,
 	.recvmsg	= pppol2tp_recvmsg,
 	.mmap		= sock_no_mmap,

-- 
2.53.0-Meta

