Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAE378D8D;
	Fri, 15 May 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834025; cv=none; b=VbOX0HFSAPZg0fGdUIerP2fpI+4dvcHqGxvnUARYaozPVA/+JeVta65DNy3hQ9n81R0isbId17AEu1frIzXeT1oRmJ/DgAM+t9AgVd8cuiiKz5eOczOxtAhccZ7RVAbJd5FUsFvKvhjVQIK9axDkHruDxRfHD9LXOwsNdSq+8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834025; c=relaxed/simple;
	bh=sRzstdgsXbKL6tHsxt/R+ZqoiMe+d7TM62p6vVJPOJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgwrfY32F09AcIzDpgjDJAM0yF4yW6hPdG8NPPTlGuRkLhTH8pqNhbA3RXjmdcl7OIqYAkkQ8TBBM/7TxjWfdBj3p2ep8o+NpXQgumrUJWEbtsSWHt8BSlBmRxJQovv+gzTRf4o3/wTWXXMOBHMAc1h8AswCdNTSY/qMg9Oq5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s/aqgSUr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s/aqgSUr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=wKabqMQvYbzhjiMoPiHLrjNUX1Z92dSl6JFvGORH2Rk=; b=s/aqgSUrYHkhPt/fr35701w12w
	A9DyPpJjNZzE3UxTXU/N+H/AxpzQ3vrIMgPibRO+u2dE4iILQKWGl4hShuNAbBdkhYOLz8xip0hlN
	iJKkBpeFN77ay/tDla1bMZWMmrt2nhWJV9NpqqHSAmoIFH3XVklWHrpu0tvCcMHSf2PHgQJ5XrXA8
	X1+ljVTf15ANCpo8ByZdf9sfUOwivXlIjKCfoDY9xTiYPiIE59QPpQNd/RdMOKMDosVW5EjmUY/ce
	FlABVGC8Lv0yZKLY0VVShvmW2sqfbHSNZKrvIcT/QYBd7w4eii1o9aAjcWeaBJMfNzZpqK20c7jAP
	W+Vkk4kQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzB-004b9I-21;
	Fri, 15 May 2026 08:33:33 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:26 -0700
Subject: [PATCH net-next v2 2/7] af_iucv: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-2-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2185; i=leitao@debian.org;
 h=from:subject:message-id; bh=sRzstdgsXbKL6tHsxt/R+ZqoiMe+d7TM62p6vVJPOJg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpKxRaiWrftzUDLaONB0HIWfi1j0PJvEiovT
 xf6/1tCV1+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bZ7pD/9DS2O+baa/AApYtG4NyZMxoEfLlQCyoT7+qbNowrZ0RAjojhEjXl0AwdLXeRhq79gBPD2
 4683obkAkSiabr+MLGrAsFauz4cAEnqcztMEDMlQcdM3bYo+40wBl9o03VTDY4ak35ula+4x9z6
 qsuTIm7QaeRVoqP35umRwazcSTAXM1sudTcHEf1E6L4j1zdcMLpfSBTcbEePzguOAw3tmpixhwQ
 rVNaK9HyteEfYo7iHhvTb9/ytgDsUp/OopHZlZtm5SXGWzw3rS+uYaN+x55xUKlJqLOtTsUhSqZ
 jucEh/aNzpC8AAb6bBxtDXQX2wKznv9B5QWufsjMpNLs6vOD8owrwDZLEg585aThEoyazIIiPoX
 vhEvFijbdtGMYQgDKUquC1Ky4DfkDukY6A2/BD5YcGJYvEo3tVLvzjr+ZKotWKO3vYeDLmZnEtn
 6tI86nrJuAIROOxYAclvRmuNPC6k1IEfueyJ7SMZJgO8xIcwkueF5xrdaJkW12hcLg/rEy67VMg
 BS5KbndiBJ8vS3sfrm3aZA4qXTbZR+/YFC+HXcmvh0JW1VzAUWIFcvDS8zM2sKelaVeilAYUhKg
 daiXkYEMUHYuSJ63el2qQHPg34xVHBlNcDW8WoivHSI5UgYMKOAc8KUFPyKtC6Xwigz6s1GLBNX
 fEI/N9ULhNmsTPw==
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/iucv/af_iucv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 3dd11d7a967c8..c0faf06d4afc0 100644
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
 
@@ -1576,9 +1575,8 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, &val, len))
+	opt->optlen = len;
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 
 	return 0;
@@ -2230,7 +2228,7 @@ static const struct proto_ops iucv_sock_ops = {
 	.socketpair	= sock_no_socketpair,
 	.shutdown	= iucv_sock_shutdown,
 	.setsockopt	= iucv_sock_setsockopt,
-	.getsockopt	= iucv_sock_getsockopt,
+	.getsockopt_iter = iucv_sock_getsockopt,
 };
 
 static int iucv_sock_create(struct net *net, struct socket *sock, int protocol,

-- 
2.53.0-Meta

