Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076241325E;
	Wed, 13 May 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675718; cv=none; b=NJ6sE2MOSkVpL1y5o6esubRBRFN4wO5//v++B+EU/aIUNYSGfzSD9mtdrGkvLsJO/phqzDZRVw8Jdpyz1HiqDLQqtmqAdKIZfCgoJ23FpRwbxKEzuOB4WB5hTUigDppt3YFwOCTeQTrDsq8/sBCuvwo2rtQHSwiitl/p2DlG1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675718; c=relaxed/simple;
	bh=p7hVaV8xjsARf4k51QHECRVcUobZRQWqSnhvJ1q8neU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hw00C8ZVY+6GwgEj066QARLUEgvf7OwCNvtt3Ar0SW31r9T2OEEB9lD3QjLY5+PvmTh63jT2vEr3rvV9v6Pj9YBwTrtpKq8uGC3HKb/LgQR83vqRdIOWFxy8ocgZCkSjMy+mEsW9bPZBPZug0+zf37heOu8SZH/L6Kr/tUuhPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nfpRbGxC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nfpRbGxC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=CbxXvLiw4sMVhAzVlRt5P+d5WLtKTwA9XSCvlNZA1Rs=; b=nfpRbGxCv8GEhRlEwR+Vd6qUbC
	JIwYV6TILystoxG5lZ/+NMY4hWrcLh5cbzapdccPjCdevkzPiVfkjF80tGpx2s6XQbz1dpYmJ32Sm
	yRTPhTYX3HYw5IwrTaFilX2spMeVhQLbZV7uyMdaJFmOfzddXvm0MRZIoTw4s2RuKgk5heQt4od9H
	4cVAJkAkmTWLjvUmtDCPLoc1IC4qNyEx77rsSFuws7qhoqkt4Eo+hvSPUyF3tOKF3oxqokHy4affE
	Lp+F+ExnGo+10qoW95ICP9IZrcMtkB+lIAyjs8NiF/m5d8vu776BXam/pH68jDMMry+BdUQlz4K1b
	FdsMaEQg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8no-003A8x-1M;
	Wed, 13 May 2026 12:35:04 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:16 -0700
Subject: [PATCH net-next 5/6] rxrpc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=leitao@debian.org;
 h=from:subject:message-id; bh=p7hVaV8xjsARf4k51QHECRVcUobZRQWqSnhvJ1q8neU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PRvKzbSTKV5V3M+lVEf2nLgN2t4cbBxM1P
 wtB5IazTwyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bXGdEACN1LRwNTQ0Y5/t2FF3/QkPQ1n/dPc1L2cE3D/ihieD973VI3SHKyiFRjZwG7h+i3AalJw
 sah8qDgszZ9wvmpaN6nnf8h7GTEEfi4jRSzVDjeInLa5Ax5nxtPKq8KzJptn1xE8qf1xpIOD5Vx
 x1yk13F4dzS73ijTwRx9FZXUs74HatC6TW5qg6s2Ewe/fgQlvVJPaXGZu4CizZIgEhOCGBgl0+y
 kVjoScnA6V+wYefhVIachPYJRD0HxtUEnX+IOmw8bzRxbpC3bMbnIj28rTnqF0Wwt3MVFmOBGXm
 5GrWMOU42miJFUdcXipCl4zoafoQCNNZA7ukDcWXknZhCLzxN03waGzteTNA0Xz/AApStw6quUx
 5QPvMoTvqhgJkft2Vy8NNy+7wDKfhE86aeYkMLDQeB5FmyAbnWewFa2ZjpsKRQWK2HckKlVtPU1
 IM0O8VR0Ud7aRENJu0kk1eSiADYy/oiML14z7qpo9Fu5jqqYdQ3zlW7sM6hdnPVWL02XYvGSN9d
 tLd1300fuVbxxN+sQc6tb+qibJX2nmnlfYtXn7Ao0SDVn0/n1HpOgVNI2VJO8pauH7PSYpEwmuI
 aGKVJx1Vo6xZ9e5F74zQx3f6QmCysLDlM3in6ZHYLl/wnzSc6AtB89dH0257FW8mCMI2OmRPsAG
 YGBtj5OWc4kdn0g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert RxRPC socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

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

