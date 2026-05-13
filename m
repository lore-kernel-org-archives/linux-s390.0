Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B341B370;
	Wed, 13 May 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675698; cv=none; b=s3mSNR68MlQ3dxPurNT2m650aFTkXvOrV7tlOGutw34IlI2ej5zXWezXGxUKjBJBnlBOT5o4JRksnTzRYLewGmmlvIp7bE+yo4iVlNgpsv6gTo+E7Rx+4+RucDv+nc5LltjgsIAKCM/T5fjANT/6q0U/3sTQDaiffJkh35RI/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675698; c=relaxed/simple;
	bh=5oT/aLBMv9wkg8/zsOy+l00lkNWyNDMzk98mghaX2+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naU3zLf6qv8lCEpmVItuvAaCxLjkEwqy+e68PEHVKZp9xbIyjx1Eu8ZvfqA1wOrM7IzC8qNpSGWzxqPEDHlZzR2+xKxEUtf1MYA9wD7k7p9gB/a1E/h9EPNtRFbae//iJwPQ7TwrSJ8BmPtmLucCtPBWWxUaGMuN45YMB2eEZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=In8hN+qG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="In8hN+qG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=krARNXEWrK0bUU1KDLEePU5qvlCpiZ9zejQmhk6GTp0=; b=In8hN+qGU4yVZ0T9ZVZDBl79vY
	OWfgfm42Yomazsj1h9uTpBPL4eOrWc0e5+EVbhE+pCyTVYPt15cOHYevNGkUPnTNRIwT1Vag6bV67
	2KNHlG02gtOqwws92/GPimBGhcw2eCB1duDntZ2l2d9vgxFgC/YICwYxsOGY+69opsTbmkzBZyY3H
	Go9NUJvOrFJeo/a7NKxsE3iTs+Y5iwGWXn2vPz8D94STdFClKSUjMtpPKeJJWd9wZBLJjo63x2r4A
	Tq7c9lW0Jps1p729bMJ0uZo/iUn9Byd5haYjuqT89dAVO2lE13nkwMuzQBKNs2eutyDYnuF0qKX/D
	o3LQJsEQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nU-003A8C-2I;
	Wed, 13 May 2026 12:34:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:13 -0700
Subject: [PATCH net-next 2/6] xdp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=leitao@debian.org;
 h=from:subject:message-id; bh=5oT/aLBMv9wkg8/zsOy+l00lkNWyNDMzk98mghaX2+o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PlszkdljAk0D6qJ3Q/CP8YqQaHtU38DpKg
 +KNkjIf4SOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bYCcD/40JBn5BdNiRB5Uk970kZ0ApjZH6avh2/n9kteRqeCXX03VaaSc/VZT68ie0bPDaRDwoEv
 GChrqRPErDQ3YYnJM4frV/v3JvcEtjTk9teSlRMuyZwxrPdQwiUPY7/QNL2zKMY6vd/wVxb1ovg
 8Mvca9Zp5uM0ZHbVI7e2z4t/0f+afx3jouCFJWX/3BaaGrV8Ze4nVG/v2zIWN0Y8F4zxMEpvsRt
 wpNuL6FRfc/y8CUhGdOHwAV0aj7uumQ0TbYz8b+c+/9n9zJQuqQm3tzuqY71+yF6MoArLLQgQQX
 CuvPr0OPbkQoai7AoU6Gatjk6gS/3hIq0HTVp+4XDeLPvUFQEjzZPaW2xtrkz2EfpiAGmY+jy6W
 qybUIFH2VEEj/C5+cIEsEgxLFYw84vp20FsYQNXmRnvypYMuyDK2/91AFS4xiM6sbCDzcpWmhQ2
 WsaXUI+LJoOVSPA4zThDJWZT+dK2vFL5yM1kKfWyGCExA47foxTTgQYZAeQ2BG/7rwgEZKqh+Ln
 oVH1QbOTAQSEOEM4VY2JrCMhkOEKrO5gsMaUvO4nzQWm+gB1tI1Z7pW8T3ciBVdR1hXv2TaAlUq
 LWxbeW8xvGq+aV6NAwhh7vrViZvamnFCHTmV4F0PxZkonA/bxuvmPC4QSdCMiGNEVcb6xgbjf+B
 TaYBDV3MFgrx+Fg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert XDP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/xdp/xsk.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af55..77f8de054a1be 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -22,6 +22,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
+#include <linux/uio.h>
 #include <linux/vmalloc.h>
 
 #include <net/netdev_queues.h>
@@ -1729,7 +1730,7 @@ struct xdp_statistics_v1 {
 };
 
 static int xsk_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct xdp_sock *xs = xdp_sk(sk);
@@ -1738,8 +1739,7 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 	if (level != SOL_XDP)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1773,10 +1773,10 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 		stats.tx_invalid_descs = xskq_nb_invalid_descs(xs->tx);
 		mutex_unlock(&xs->mutex);
 
-		if (copy_to_user(optval, &stats, stats_size))
-			return -EFAULT;
-		if (put_user(stats_size, optlen))
+		if (copy_to_iter(&stats, stats_size, &opt->iter_out) !=
+		    stats_size)
 			return -EFAULT;
+		opt->optlen = stats_size;
 
 		return 0;
 	}
@@ -1825,10 +1825,9 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 			to_copy = &off_v1;
 		}
 
-		if (copy_to_user(optval, to_copy, len))
-			return -EFAULT;
-		if (put_user(len, optlen))
+		if (copy_to_iter(to_copy, len, &opt->iter_out) != len)
 			return -EFAULT;
+		opt->optlen = len;
 
 		return 0;
 	}
@@ -1845,10 +1844,9 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 		mutex_unlock(&xs->mutex);
 
 		len = sizeof(opts);
-		if (copy_to_user(optval, &opts, len))
-			return -EFAULT;
-		if (put_user(len, optlen))
+		if (copy_to_iter(&opts, len, &opt->iter_out) != len)
 			return -EFAULT;
+		opt->optlen = len;
 
 		return 0;
 	}
@@ -1949,7 +1947,7 @@ static const struct proto_ops xsk_proto_ops = {
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= xsk_setsockopt,
-	.getsockopt	= xsk_getsockopt,
+	.getsockopt_iter = xsk_getsockopt,
 	.sendmsg	= xsk_sendmsg,
 	.recvmsg	= xsk_recvmsg,
 	.mmap		= xsk_mmap,

-- 
2.53.0-Meta

