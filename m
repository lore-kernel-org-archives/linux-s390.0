Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8D36EAB8;
	Wed, 20 May 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296052; cv=none; b=khHs4kEu0YmjuCwcPXnJUgzEf2OOqbYhm3lAPPAoRHgS+zAWBUoO5UG1E7J/uW1oObfqW5N2eW4u7wGU6TLaiNdKIDYGZnmN5JSszb6Y/opuW1QpBP2fac+iMvMGQeJKQPchec9PtFnXnIO6+Nr5OwreetdF1NYL/gWauRFUgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296052; c=relaxed/simple;
	bh=ds7repM3GfKwVCPTBlPEylK0lJdlV0G4PW0g4dlpb7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcN6rUDQcME9jHQFjJw92KjFKYAudJsp5tYKT3ZQCscDzYBJcpmBavKH7P/cbvrPjRTcrhYhO12XthK64WjAVjiSXV1v14J6v3ci6+T4s5+WXvMkg05rmEtXiEh6Tdao2Joeu7A+BgaVVd/MTiLWKskQTiLyHl44V/91ggxmj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Bab0XAEx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Bab0XAEx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=RmTWKkI25NL3IXqet/TO14Ipdwn0wvG7RqPRb5B1yow=; b=Bab0XAExiaVZYb+r9CLBwOBIP5
	KOpTPU9tITd9DjvGTLc0/2PINH0gpP6ZOmswzLZWZXc68RkzR5j4MFzmGVWCEnoRtGu3K0XsWlfuo
	iEIFuyUYznklM27mIsD/gGI3djk9MD2uufCFqRhgcd8c+ApFqhbcYuIstF/kriDkOvBgYnB9a4VQO
	36KKusRlCDLI9z8wyqn4b8PuskypkxirCLJLSXwdC2LWrazfqvg0Ez/vrfzR/ibtydENRhd0ASRdK
	F0bkt2XvnpaIelo6LgsIdjQCu3sDMsMcOxqAQYPoC/S3iNNkVs3bieBTNp8bUAiKS4qtzUeYkSIHc
	YVyQUI3A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBJ-003FU4-0R;
	Wed, 20 May 2026 16:54:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:46 -0700
Subject: [PATCH net-next v3 1/6] af_iucv: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-1-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; i=leitao@debian.org;
 h=from:subject:message-id; bh=ds7repM3GfKwVCPTBlPEylK0lJdlV0G4PW0g4dlpb7s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecglSm/Ml6ui8cpJo0v971RFRvnBd6ciGV11
 gP+Dv3wZxCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bZoPEACj7pGZCLMLbi1Jdd6AHwyq10MyPXuvbpuYvIBVGP4qkeil7AjegGTlYq5fhgxoaPOL1ms
 iz5/9DSx8aibMHAKcy+CEi6lvViPcWe7f6lZNH/vtovjc9cctfMoongt7jvR+8gUJ9dJQhNtoYO
 FXG+m9cGRR4reIlO7Cx1chLsLJ2C4ah3k9CWFOQgcJOhiXHVNRt0KyNiZq7XQK3xXwl1vqLqIoX
 OMYdCyYMnfbv2qhOmsSDBGjt+CZodyhY4+Dqjp6P+UmsLgaSP4ASeW56nZd6cASLk1yhi2HkETl
 w1o8s46idAZg5IXb0xP8a3ekmutyKxu8EbA3OPUB8HBPYXGAzjHsuIRnmjrIpKODXc45QMIVOtb
 +JYCIJRNxcKWBSGcW3EAjnSErwJBfyxa4PBT5zAcJKtwSeODfSwohIB6zo4W6GNO20Rf5m88doB
 ntkkPtwDOyO+346aA7M2EKY2WKQvQk/MD+82+BFNwZJoEegPhBaL690rmHvKuj24FHBLxER3V47
 fu0zYv0FRRbHc18FLVlcEJk+Xwaub+DiOW0RbgXzGUpffc97NuWDupgpgfEcXWqU7RkQr+rqEUR
 qhU94w6p/KqKZsKOVe1GHjOKa7ZyS+aS96d9c7sYMP6pvFLCQjr5KoaKQbb6Qp3TIWXa8ZdmlAu
 RSbA3vF7D9rAZhQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert IUCV socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/iucv/af_iucv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 72dfccd4e3d58..7a5ce93a83d9c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/uio.h>
 #include <net/sock.h>
 #include <asm/machine.h>
 #include <asm/ebcdic.h>
@@ -1535,7 +1536,7 @@ static int iucv_sock_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, int __user *optlen)
+				sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
@@ -1545,9 +1546,7 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_IUCV)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
-
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1574,9 +1573,8 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 
 	return 0;
@@ -2228,7 +2226,7 @@ static const struct proto_ops iucv_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= iucv_sock_shutdown,
 	.setsockopt	= iucv_sock_setsockopt,
-	.getsockopt	= iucv_sock_getsockopt,
+	.getsockopt_iter = iucv_sock_getsockopt,
 };
 
 static int iucv_sock_create(struct net *net, struct socket *sock, int protocol,

-- 
2.53.0-Meta

