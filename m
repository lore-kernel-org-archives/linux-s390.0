Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6463DA7D9;
	Wed, 20 May 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296078; cv=none; b=mftQOybJ1Prv5qYeTKeqLAIGQ9XvkCt4TA6v4H35HieeR69mftBEfVDW2igZUBva4F+nUC/RB0TLQmen+a33IBJmDDTH+e5mAudz1HZRT6lX2zuG1hVhsDiq5KXyyYiNmS7XC+iJR4nWzX7lYFpZnWQ7M37Kv1PuF/87gMmSgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296078; c=relaxed/simple;
	bh=sp88kJh3MpZ3HcYglUnXhuzMAOAw7teBpY9YCzaoASA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG3qmxMkndxb62LwjwBXfVCu8p1GbM48+s1NMaNboojjbsaTYKQWDXY+TVv3Vz/hXvNi6+YnXaafHeuCfO9aMHFN7Vcft5n/RbEV6gj3KDt6X3FzD3/Qlqa67v/+4lUuwpeVzwpssSk06BJkKSaz3jD6NH3exoCdFNFazM3vTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uGvrnsPM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uGvrnsPM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=EqRgAXV6Qi88VaqKjwckW39kYh3sBGxBCDGEqJ5f3nw=; b=uGvrnsPMxG3ZSpWpbS5dwxE6f7
	9mAHGKMm+oWOs9Q4Z04YmDj+YUZMgSCDBJVj0qB8dnCNhiDj3ieRJmbZuxFSFfcnla2VTjykGVkNy
	3pVZ+hyZbW3XRIloqJmDaqwg4Nx7H8gmo0oSDGQGfgCrA5RmHHmNQQCh4F8wGIYhy4GMXsDdJQa7V
	GCilwLv/1znx8FJzXlSpNc5JErMDmcVQgT17c2Jw8XH7PQsxw3eUACRPcQDq+JBXnE4LXJ8F8156o
	0eGeEmE+nFQwyvlkiOeL9epVej4WuMEg8VL92+9X4a369kMK7LZCHYzhhrlveHpCqVyPHsTXuIoom
	swaxJq1g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBj-003FVA-0E;
	Wed, 20 May 2026 16:54:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:50 -0700
Subject: [PATCH net-next v3 5/6] rxrpc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-5-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102; i=leitao@debian.org;
 h=from:subject:message-id; bh=sp88kJh3MpZ3HcYglUnXhuzMAOAw7teBpY9YCzaoASA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecgpTUnRAVgB9dlIN8YnvFFKVqS/CMC1dfQf
 5dGqvTWh2yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bbROEACaNb3NDKOvOlccp8DSKEv8PeV6ctWb36Chnkby3Z+Cp+NqpUk4VOQyu1VuQ+LvlaD4D3z
 4+aaatwNgjcyPumwXBcnYONR3QyqEaH7EP2X1soIGC4GEtqAVjilMsu/IBaXDcPJDcQ33elkf46
 JbKHTZr2BuRl3LMPUg3U7oGHh6WN4yCc6hskzlJYjChveUPwY/3tS5SFjSdGKq+0IfJXSvrXwzJ
 uebHWziXCKeI6N0I5NgrN6LX68B/skCTyBBJiLgWz5Zuzex3aGt+XRa9GIALI5cuqn6l8UbxKti
 yYS0BBTCb5h3ytFtKJX46UQUYjA/ueSxj9Y22BVGl38FhI3OgBqvt4hivoM6Pu1T9F2pedOzQRk
 RQNgg8r3GZvgmbrpVxcRtF8czJTIn+CT8n9Ze3BQ8Moo5aEoiERIUVwz7a2mPNF+n1s/mHVjttn
 SLBvYyWwxDH4IPXBzDRC+0EuNOFVFfgBMIspig3oX30/5eiNsXJU2kVxVjfxrDaB5kOShNEdQuq
 b98XGx8K8f2pYrTnR/gqrEk7LbZGzE6m13CMFoiOwxhlW2RuMAFgMWiQvoky2kXRT0Ym7BDMkz+
 Fi2pN1MR7DJvYr6COUYACdNPgdm+HdS0cBdTqHlJkWczhGcSGJwt+VAcHW40ZnHJdUka99eoTX7
 g9AZfRk4DRzgQnw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert RxRPC socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/rxrpc/af_rxrpc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 32ec91fa938fb..9ab0f22c881ec 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/key-type.h>
+#include <linux/uio.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/af_rxrpc.h>
@@ -743,23 +744,24 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
  * Get socket options.
  */
 static int rxrpc_getsockopt(struct socket *sock, int level, int optname,
-			    char __user *optval, int __user *_optlen)
+			    sockopt_t *opt)
 {
-	int optlen;
+	int optlen, val;
 
 	if (level != SOL_RXRPC)
 		return -EOPNOTSUPP;
 
-	if (get_user(optlen, _optlen))
-		return -EFAULT;
+	optlen = opt->optlen;
 
 	switch (optname) {
 	case RXRPC_SUPPORTED_CMSG:
 		if (optlen < sizeof(int))
 			return -ETOOSMALL;
-		if (put_user(RXRPC__SUPPORTED - 1, (int __user *)optval) ||
-		    put_user(sizeof(int), _optlen))
+		val = RXRPC__SUPPORTED - 1;
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
 			return -EFAULT;
+		opt->optlen = sizeof(val);
 		return 0;
 
 	default:
@@ -1009,7 +1011,7 @@ static const struct proto_ops rxrpc_rpc_ops = {
 	.listen		= rxrpc_listen,
 	.shutdown	= rxrpc_shutdown,
 	.setsockopt	= rxrpc_setsockopt,
-	.getsockopt	= rxrpc_getsockopt,
+	.getsockopt_iter = rxrpc_getsockopt,
 	.sendmsg	= rxrpc_sendmsg,
 	.recvmsg	= rxrpc_recvmsg,
 	.mmap		= sock_no_mmap,

-- 
2.53.0-Meta

