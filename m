Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCB428821;
	Wed, 13 May 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675703; cv=none; b=oozw0zaOmTF2UrfwHrjrB0EMgXL/FcIF++CEbicb9nECkB8v5cBT7ZLcikBRVZg/vZUZggMOwBFSZMPST1ee7KsAQ0tGee82fXSwznfr5Gx8HA/J1qcqWoa3k+6St5QdLwbzioMWjbnqkgSk+ZWXpEKhrpLDF/4QVRt36uMId2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675703; c=relaxed/simple;
	bh=Fr+0wmjHlF79em7QD3yyoUyusFO+aw9/+aA1oi3mVTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncF/UlCVk8DRdCvw3DxyRDS2U1F9OzlRPafPcHNr4m3dP3GZHZHAqpsJ6ZyyCsgFbBnDVurBIMjThgBTmQEeryKDvwSWhBFQBJkPeVK50nrpo7Johnl8bx2I17kL6STBBTfTeSNQNQjjp+U14bUMTwXTI5LQUHD0nuo3IFnb1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ru3PuHEs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ru3PuHEs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=2WMPuApTHPuVLLw+lzkepvgCjK8SwBMKbbLMEPuDxpo=; b=Ru3PuHEsdj61Wv3bybbJCOUyRJ
	Of2+eYBmmDEI/XbkbfuHLFIwkCSDJMmfcDfBcX9Vs9Vg7m6z+vr0G8U6ZYcRNcF3MHpU2RYw7PvXL
	D/28CO9x9z9oF3yfh7EWmv31gCBnKicfqWHATO3PDNXqPkIDCanadY3yShAJyNeLPMJ751yqzz+yy
	lYTZ6xlbUmfY135+mb/RAOngbazxNdINioDIk9ZM2i1TNCF7sGB25bRCJmCnOvtYzUeW5fS8Zn/vL
	BkONJhnKw7XZBLhvwme5F3bogjhZc70R8E+zbPvrZ+/QzJ6MUVVXsUH+1O7xjZ9PhZ6WUrhQVxMCU
	C1tX7mJw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nb-003A8M-10;
	Wed, 13 May 2026 12:34:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:14 -0700
Subject: [PATCH net-next 3/6] af_iucv: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=leitao@debian.org;
 h=from:subject:message-id; bh=Fr+0wmjHlF79em7QD3yyoUyusFO+aw9/+aA1oi3mVTM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/Po5/1i6RhWkIFNZRER12k/7yJVu0+bsNu1
 1GxS8VLtQuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 beylD/9Viop+R7QCfyllsFEtw2FvAbAusw52xe9pcfIVnghXfL/+Wt/au1wpIR2WRndXi7hRoAZ
 fsguRFGA1slFHLP+3OaNSpiqA6nnITQxx08x3jR7dp+wPnI3inntY9+zq4EySzFbJupvEwXzcF+
 KkYoUNItO7itUmwqvAKAxoHzYFqG+9zwZtvYZ7OdhIzMwZaFZfBB1O4LmmAPguQ8QpP/qm9AIeB
 1BcVWUmV8WDlY5Y8xTK29GAHV1Xs22K5e/Z1BRA/M8HVu8+dZFnk56Q8GcUf0nORK9j0ao7ZdUT
 eC/HJCZMQc0Yz1hh623QQCLT9K9w6Xe1os/yAiCPGG0Kn5zqb+Ag/uvT/ZvRoklFU1iRu6q04Aq
 1Ieh4GjiAv8zKAxITbDG6USNYHYh1jbwASohFV+VL8O3ZvCY8eob5yXIjTxlhOvIIRRZVvHu+YS
 rqnoGpEZn3ktjKhsPRs0edIxRfU0itGM/DQyCBvSzxjVXhrj+000vHOgNJ3JgjnLZqN4oC14lk+
 XaLamQ0OWyphgrWnMVHJsOlf8dEwXwIK2+dehzOfnH0CdUcHBaNo/kWf2lj2wpEUMXtr5Fl4EYE
 fdzjdaqF62pVaG/QOEwoFQ/4F0OMP55QX3+V+Yz7GnymKvOzSFjxMbbjHeLHUTUwlAnRrzKnItv
 N8QZKT/4BKp/IrQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert IUCV socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

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

