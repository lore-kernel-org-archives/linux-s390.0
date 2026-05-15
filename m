Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F523E3DAF;
	Fri, 15 May 2026 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834056; cv=none; b=BmD0RfTwL0xdCC6p4E7h1mmD8Rrml5C5h2gNlzGsoAK2vvCdwoJAKHUe5hBFtnYTGKw5mq80BoZzP+ZTqNsgxTb4hLWtv7snYytb3+Z7GWBerHA9uoVFpBNz/NEwpCCyW8qodDnOx1+/RHb9eQS2wD66LHcOGSQfoAVTOl2khuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834056; c=relaxed/simple;
	bh=sp88kJh3MpZ3HcYglUnXhuzMAOAw7teBpY9YCzaoASA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqJSMxcVKMSs3kgVlHJN7QTrlZGqKvwCEtISVsNJxMNJcBBtMgqLKlbEgsGy2aAP1yspxWPo/UD7vXR122ghFSO56ND4GzTriyF7nKkcPj2KgsQtYycfASsj+9DMHjaDuGtzHEyCyYLO5EKYhKvACK2Y6m/SPvBhUA50GmSBYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CRyDIRAy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CRyDIRAy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=EqRgAXV6Qi88VaqKjwckW39kYh3sBGxBCDGEqJ5f3nw=; b=CRyDIRAyQSYCdtzgPvfGL6jCCm
	n/tO9t6M8ocddhefEH2fV/GyfB+G2igVeNhB/kND4ZND3UFfAnaJ9va1MSYhCHFkjdpk6M+pTJzSE
	TJSAF0BCMRzEcEh1ZzlyCOMGrOVhBZRXaS7ZArPREtDTr6dkDk+P9NtFQoQZbEGmCy7D41H+M/cwp
	cpM0sUTR9pU+OlqXeZnybzkZzWZL+PLTxUqJ5NO6IIoJCm02gYn93gEJaGJWL+KCNXVnQLMGV7GvJ
	73OcVB7qqUNT2zQDDk2dc7gTdDzaCWfMQ4z36Jxl/OQAcJ3Ojw5Kc+CxJbyUTdpvyReRgrm6LeSx8
	ozKp6ZLA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzb-004bGf-1f;
	Fri, 15 May 2026 08:33:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:30 -0700
Subject: [PATCH net-next v2 6/7] rxrpc: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-6-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102; i=leitao@debian.org;
 h=from:subject:message-id; bh=sp88kJh3MpZ3HcYglUnXhuzMAOAw7teBpY9YCzaoASA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpK5I8eWkl/UEd+8ghgYJX882XZvUGShw6u0
 fFmjDGaivWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bVDBD/4r4jaba9xpKDmtVV9nJLgeHxxJNunCehcslbdaFfVbpcvHLDJuOBuOgbm8gvxhi59YWuD
 XI82zslHHrgcM382x1Yn5HaHu1SFwIo/Kc+NbJ340PlWAPhHcfwEgDzm1X8GXygw0jExCXpPSbC
 lXM8QT3Cg5rZxC+0GwuyWH8ylXVZqve9kwOqTxTLyvlBd6OuYpUXL8iAIOF9I8wi9bCGjK0TUMF
 udOcN5OSBCEqd7txG8vYgZw4mjO1uTDz7uWm45vP2uGeNbNocXIzkaz/n2iAylJIVjVOtIjbTOT
 v65jN8MZNZ9qZyHQreNaC5xOQRGVMW25jPfDGQpkWZgyctOyw6Z1zzXQP4kY20+fV5pTgmBxp/p
 nAxs+w8HC19XnvNU/suLE69LLM7nADV5Hz5RcEu9M0dxx3IVGRFnat++5D7AT/zHbo7unTxLTaZ
 GBGD5H64NIU+tadU5rrPruvw5LpiKFHZWb4lJhS42YDUBaRDQicKHyrO9RLI/1sCX94wLb9jDBR
 Ht1rQIUkugRKikQD2v3QszmXtrz04sM6b+R4AZBIwo+Lbv4Z8B1SXvlTIgjO5QiqHer8Gf90FZz
 3x1m16Se5REvhDE7j2i6mNWGWTNc+DkDVKNRacqx9rOzOsTdtQcIA8xqbVPCBEBaWLhBsLFbkIA
 jqP58I5QJD8P8og==
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

