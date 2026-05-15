Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0A40FD8F;
	Fri, 15 May 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834039; cv=none; b=TQuYVkgxaJUQ4OHrol+QUsSTNMjYxxyPEfSt2FvLatVpTINT8JuGgf3hzdS3Ue+iWRjNQorYT1y9AYhul7XNd+4Q+7IjV3+ZiCF5bpAQVyEC4s5PTe2mAAWL9DNlsvRfyCEge38C5GTDfO4fQQSXfCA2oNNbOnw63ZK1hXtHXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834039; c=relaxed/simple;
	bh=mLjMS8AXXQWWpHQvJDt9wZGN1YLyFgu0AP5yDHz+tM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGkEK0pZgWJ682wvIptGadgHT87Y51AyDqqGksPDG6bH5UPOwID3c6OLXGnmKKUyWVuv8vPQxF8OCP5dmaavFyVthBxn3VNeeyd1qm0DSy8kWbzny3d3FMOylwmtdJ6AWenboNxu1xeormAv3kgukcmYoUJz/dIjsEUtyE+WcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lZTX8sEF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lZTX8sEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6WroK2SRMCzSY7s1w6oOlAckh2hz3l6QOa4ze9nZxOw=; b=lZTX8sEFA55RG+THVuKsgwkx8j
	a5Ecrndzgg5Wbncj86IDoxjltKG5Tqmp/d5xK4AeGVsrD2Xzvi1vvKaaKXGLKQcALzLXRuOMm4TVp
	F03DAc9nZEejo6dt7KBDtqxujokoSoVqKtwcGsngH3xHQcrWiecbwtqZg2iim0QNG6W2LDTBBdUaZ
	byI3DHxDIty1j2iaYoeN8q8t3H69aKUqNNSVMOAKLtLmUvAZ1vSX+5q6/BU4mLsGzM2K+EgcT5PYQ
	1lbISls1XnrWj4pLOB4Pd97BhmvD+EZ9j66O2+JQXlRARDN+0+6iXXdtCtqi14iuPjbUzAt0YZNot
	YmVS/4yQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzO-004b9h-1t;
	Fri, 15 May 2026 08:33:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:28 -0700
Subject: [PATCH net-next v2 4/7] xdp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-4-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=leitao@debian.org;
 h=from:subject:message-id; bh=mLjMS8AXXQWWpHQvJDt9wZGN1YLyFgu0AP5yDHz+tM8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpK1LnbS49KtCbUe6Gz0SZPIqNo5LB4637FB
 zfwXecNSneJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bc1WD/4vl/DjHTDe+El9I1dIWtMFioM9nJ33C04jOEmQFAwhhlHABqOOeGm4lmeiZmIJOhK33v/
 pJuPZEwUtCTXhbgbwVJ5eRWdT64CbkUnU0zwEL1Mn1rztJ0h5Jb8aQ6NJIGiCVE5Ge1aXk1sSXi
 vNbf4KXPAWhZ9SmoWUex4mxz38eIKx9cb41ueMPbW28zwiZHKkN/askvuHBVwZKvsuFIfDYuJuA
 Ozp1GYngGxV2mCIj8rtatl56axnk9l2mwex0m4tdb0TDaFGBGza544EDfQRBnR4EA/AO3suaxUt
 fJBz8C+K54GK//L4yOP8AhAQrb5YRWXXW/kDkls9KmXAQiDk2KtDN5GYvfk0Kt5yct3VKNd0KOG
 C9B8E2oqkDkvhaXOjN/gY/AIutyY1RRvvab1yybyCFkMpSi8wk4p+B6ISRtdqXm16N9T+IP2bPL
 R5ozucfTquAFmYnsxX4TkC4HBaJh0w30ONm4+04poDEkcUKOd/oK98FWop4kSh+5koiwGqyJy0F
 p4b4ST2UyN+yGjM8/KnCOPF5Lj3VTmMh6HlMyhagEncG5j5iBR9boeEi7GpxqsFHSGrjwbLs2/T
 fsSQq9AqsGvPn9L682zevtg7TiZAPgOpm6hviTc5f6S2KyWnAn+ZNKZHfzt8aNh8ShoT8ek4b7J
 42DZyAcytJzye0w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert XDP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

