Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E323EFFB8;
	Wed, 20 May 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296065; cv=none; b=qjq2YxXWlf0D/gDitwfmadPkLJKmKCS6EP4wXCHPcvsutCl2Sm/pJ9dWcnisf79Kf3f1AkH0V0EcnnR7td7YzuXBm+oNw0HOBbRfoulZSt7GvTqJzJQIxnPOi2emePGfpfyjy0BI4HYr3cFXl+WTRhAfeCUPH63afgx/kQaEl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296065; c=relaxed/simple;
	bh=mLjMS8AXXQWWpHQvJDt9wZGN1YLyFgu0AP5yDHz+tM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2GDpMYRVbJRp5HFMdr1UwMVuKHBio7muHPebUpFLiL9Bi+tqEEM9h/26c7anz20BBbsCGei1nOQ40q6hJq7uWQOzdCoXX6g3S8EQ5PURwyHz9STEyawVk8pxewoMscKcnUt9GQgx6ECV2rWJC7KeYpBac63sEtateZMlGsTdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HBwislMY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HBwislMY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=6WroK2SRMCzSY7s1w6oOlAckh2hz3l6QOa4ze9nZxOw=; b=HBwislMYy1s1MyZ53qjcozEOLa
	l9cAWhUX5MiCrsRL5uruJLtxuukR80dSRBFOZ/NcNVOpyQ0mTaqDFCaOxLs1bJnb5cqVo1Dscqy25
	p7FiHcwe4vs/r/M36hRlXpNG0QFuMuZW1jVShyy+5BEGdb+ueUSFQbkSCg28C2GZH95Uo0F1ttorw
	PGPyLqWl7MInXByrvC6h/lAuDsZ39igjt3fDyDim3GI91BvnBl9RV5udaw2GJXLXwVOkAR4zqkdpn
	2mDKslOtYUrWn/WLp2+LW3J949dTa0JT2OWBR1BmHsOyRzlOwBzpOtVsYidrr/X0VYRXd10jBhzjI
	cKXrlWMA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBV-003FUP-2e;
	Wed, 20 May 2026 16:54:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:48 -0700
Subject: [PATCH net-next v3 3/6] xdp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-3-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2887; i=leitao@debian.org;
 h=from:subject:message-id; bh=mLjMS8AXXQWWpHQvJDt9wZGN1YLyFgu0AP5yDHz+tM8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecgXjiP1TkOVmDJD8ZjbIEnrdnVvPD7RLrAb
 a3RjVaydaWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bXZwEACvb+c8YkS/0uBY55FDkcVfawDaxZ8nOCoxKXlfiabxoHwUymOhfeUimemAN8DTi28VPA/
 h8r69WY957GKkoRQglgZf2YlGDplzHgAHAsrr8u+9kcFzO2x75emgYuuBuP9INkOJ/JIdAzoRgN
 RXM6L9V+rzjLwbQP++oUao00sLB7n28RujePDZGl+8ujcfYY4nHUFJdBUILmGWA8MK4o76IbQKF
 i0V6fG2sBhBt06wmXKuaIb7OHVkFoZg2+WGtSDJ+/B/XEXwGtn1SsjxtNWhn1FmQ9Vxe0Q15i6D
 zrjgBaMe1wEbbRv4e+tXuvbd2/8hU1F7QOTQVj2Tx3h7owJTV/pVEh+5kJWUIfbT9nqXWYx3tez
 UysoIyhYLBDQLoa/zxYgQ4VRHqK++fs26oKcE/RJe8PsRM1iE9Povr1oL0/MnscqXHAlqub1NAN
 azXBNpxDCe+vHc1VRusdxc85NWP8uHkePHFavJOLqbq6ybMUsJ/wqnkfI1Gv+unXC3XSpOW9MOp
 0HX+VdN1nZyt2qqd3r1S84gQIDWYM6CXn8FhnmCA7thxIZlEY+ZN9XscrdAN7VAS8z2p1mkGvkY
 lah7iabUWa3nbHgPWSuN7gTAQh+tI+QBL6y2LDEx9vrplhTvtGKo0z9dya+9Ppty306RqN2sLvo
 JblMalwCFy0tEFA==
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

