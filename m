Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9840245C;
	Fri, 15 May 2026 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834047; cv=none; b=ckp9nHVhuDcJTMgclVGoJ0jLluwS4Kzr2gIE8wWdLy1JuQCnP0VDnbbsJ0uY/4pAVo5tbgS/AtGP70LdJpvUK7BEb7fQmbx+/kZoxzssfhycyZw/eannJHMdg7SNpz4Eq3UQPFA45F87g1PHRNA4egra5uubNWISziuAu9VcOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834047; c=relaxed/simple;
	bh=W56Zt/m5WtA6ZtxQtbYwmAFL4lHK2Y63RhGd2qkl1no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Trst1dH48NnzQy/NFLzBVdGS64wKkE9on3LALoR8jsk9PgjOHHx5ICt4LHTkt3J0t9qIGjxyxMlXCXcFanDK7RxPH4CoCWICMxW4gi28AMTFd+qonzWuLv8fUTNEXO0Kc9FhwNQ9ZK0tOz6w6Lff7z5yfOJwQF2W0/wTwv20tWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=X1Xwegh/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="X1Xwegh/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=L1ykyjVwNL5KxggtxIRFk0UAsUP7TQjsS7m6hNH6g0o=; b=X1Xwegh/TbtDYviH9UXIL/zJE0
	K1elmZG+B9gSV6cVWWrlJdRjC+D6E6e+iXBWLIDgsjlHPJzBKeHgkwYgTfQqeEQ6hZ6AtbAUAcSkX
	b2vCCbZn/zl+R4+T1uFSzN42+Lo7qDknMBhT7DH8P6XqK/WsKyranuS25mMOM0alFc29ELA/yOiDT
	r8IxUGywom0LHJBW4FRkZ83vXDcj+64CpdqrTVp4/HvNTZPaFq/WoGOylGmKAEJI/ylpsihbDF2KM
	rz/ac3gQ4oidh5JaHBjKBNZgBQAvcusHIOKWNBLrqDgYpOuL1ne10L/rIuOl+De5CD0M5tcXN6BBV
	+GSFhstA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzV-004bCh-0b;
	Fri, 15 May 2026 08:33:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:29 -0700
Subject: [PATCH net-next v2 5/7] l2tp: ppp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-5-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=leitao@debian.org;
 h=from:subject:message-id; bh=W56Zt/m5WtA6ZtxQtbYwmAFL4lHK2Y63RhGd2qkl1no=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpKrXuQgkErmGkxOiLZxQOPdS8pY3yJg3A78
 lMJR51CnjaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bXFAD/92DWue4VjunUMMpAytLhzekJP19SL0ruIm/U9TKHSCNpdyENK1ekXLPUdNNqqe7gaqqo6
 MULBfINYTK4NnP6Fj6fs1KBDuSJ3nXPGfFlWSiFbAf/ubsMFMRYZc3yC8hYxWQzWA5GnmNqVXyd
 shgXjXNp0j27c09rTp72iHQX5scphj63UyhYD32VyzuF8STaAuF2qlBMbntPD0F8AuiA726ZbHF
 fp8c61U4b6/TaAPxEA8ZKN8gBRgKiDdnS4cDU3w2fi2gQ72bN4VLw+oKu3Eh9F0msGPwhkCbIfU
 Hsu0CmiuyS6dPdAtEr36Kk/1NUKz1WWSEPDS2281WpING0LEy3Q+ju052ccDkloer9n5TXBMgQX
 yqncvXwLsPcOQsJTjWym77aT/1yn73+9/wT0poNFXiMIE/DtS9sUbj/3C2pVAGUcrAEkPi2SCat
 Ycg35HAl80OaQINZIKZ0YWy8CwWIv+49b9bVNPY50lBNpPcia+HFr0G19CdeTaYTG3OuNQo4qFM
 cAb9vB+YiiQZXdQKGJ10jYihBPtMdh5yRZNEkRUtS7OeWd898d1cgNL+2GKTs/lBL7FFyVRH9Ar
 fp71LjyBMgEIIAO6LGXa4yet5FvUZF7f+F3Xwm8LGWVHWjhLLQCTW5QiKZMFa/uwLeS2dWft+i9
 9B9IptAT8OmhwHA==
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

