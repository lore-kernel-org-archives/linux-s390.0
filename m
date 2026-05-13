Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83A41C30A;
	Wed, 13 May 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675715; cv=none; b=RUBngss4X3jyerqp1I3NHo+nwcLHaNjFV3fTstYlr3APuoXcfFxQI1u+ZEoxQ2eGx3ShSWGYLiZFGLcaQDMmapb5YMzSplwD+kMwVtiU1+8pYtNsglm5FgPDNSN8M6RUssdfudExRataMDU8vtKpsrLERuXETZLa+5PtePlb6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675715; c=relaxed/simple;
	bh=/ifnZ+R/m/l4sS+35vtlLiYTDUDaOuXzlwMquGGtep0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SS2dCnzkVwW6MWPo/y/mexVmA5/MvfnG3yD69+nnztzFgWs8zHX3C+RzwoAUUwJXPjM6j0IsskrkP1zxlXGTflsPaHuS0AcwV19rkgBgQcAG8mLqJRUQ6P7B/eo4nE97kX1IwBxX6DwrJg/r2HsQfBmgWX/MlMasCp5s4ibAX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O4gPHsEg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O4gPHsEg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=rFPiwC2zxGv1gubkilKgGFfkbSf1GmG2sq5wGP6WhaI=; b=O4gPHsEgRyeo6n3qRfo/eW+SQu
	qjAzHVwuHmqFiH3FuytMJrDBjQuT9QPWDpd7KR4wkpgaSF2zLwnj5sE3ZRytYRKjcHKRLXAkCbT3n
	Jm7LlxS3oY1SpyFXTXlVDYDTaykOUvat+JogRq84uW1IP9/qLtWs9sdRpFswLEv73hLrJDE7MjtQ/
	Mh8+zw7o57ph7nnVDoe1j3YX+zzaH8x3QW+qMw0VxktKQdM+N/h/dWRMjcPCiet8LN3raoRlfh34S
	gzV78v61Vuh/UvwPQCYfrlu7qzt/dZOx+mkZAVhxfenQm05we5XhQdNXBMqYatVvbVLLyH1VjDUje
	le5HjOgQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nh-003A8f-36;
	Wed, 13 May 2026 12:34:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:15 -0700
Subject: [PATCH net-next 4/6] l2tp: ppp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-4-fe7f0e756fac@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=leitao@debian.org;
 h=from:subject:message-id; bh=/ifnZ+R/m/l4sS+35vtlLiYTDUDaOuXzlwMquGGtep0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PzrXZt6ARFDTQtGmOtRsdKAww4WTLwGhQe
 8/4AS+wIIGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bROGD/wJLDsiBeFZIBM7asusZwiEQcnGlYBQmtNbrgkbL37oksylpvNxnPl29ugy41kgPwISprg
 jdHR1oMxv6XqUxx4m3K4gyUipmUTObYqZYxKtPg1a8VkRBC2wa3y2nd2kKQ1k++m7FMfni8zYe1
 yyD82EORRQChny2uLbZlG1jS31qmFnLIkS81LhhiaJYDr7sYN5VbA5hW5kNIfP6Gf60NInZtztX
 qBfvXgu49oyYIOoPqnDQihwgCCED6m5iy8PQMkxLRrAtps4akkHQ8MQ/w6G3I4VMzsB1Xhe4+U5
 TX0IHsHPlFHLwFMy9TSQJelrXq/BebVdNLcijPv95nTiwjIlvZRyPv3AkQ5BlOjPoBqflIpqveB
 l657SjPCRNOpf6EpMdBn4Pwgtgtkn6WFhu7/QQ5grUWmjv48tr1FHXjqQtew4fZ13ND7ubJa6tw
 j6+wY1ocD87fLPGscC6EgZ+q3AHVv9Y2Ct7Urcl0cNJ7TZVqaXde2Q8tJyr5ek31B4u9sNcHBKh
 QcM92xS/u6mhL6NOCk+q84v+x2Jmcg/ylO74mO86Rgx7biwA01aLeKE1RlNVQ8oF8uzXX1wCnc8
 D6bWlxyrKKLyTtJybhYxsAQMm3x19w3WIKAEUmHAqg02tAb4XVgz3CWk2AvKfmIGr8H1CxUqWTs
 Afab7cEsL+7P9rg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert PPPoL2TP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/l2tp/l2tp_ppp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 99d6582f41de2..4c7a1152b20ba 100644
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
 
@@ -1358,12 +1357,11 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 			goto end_put_sess;
 	}
 
-	err = -EFAULT;
-	if (put_user(len, optlen))
-		goto end_put_sess;
-
-	if (copy_to_user((void __user *)optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len) {
+		err = -EFAULT;
 		goto end_put_sess;
+	}
 
 	err = 0;
 
@@ -1634,7 +1632,7 @@ static const struct proto_ops pppol2tp_ops = {
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

