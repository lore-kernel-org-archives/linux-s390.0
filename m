Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F73EFD0C;
	Wed, 13 May 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675697; cv=none; b=W4VuuIFgRx+hMPGKFmu8r1eR/Iu7H31rBVnpwrv1cynMTFIRcufEYG0T+aSZsx6n1QZiaeHrYjS6snyd2TjqbYtCRaKzCpQH8+U181isZopQN4DbXFCHSPAxBbu87U8B0+eLjK0PJqa8rrsAuWjsXzEiUBNfnxSKPl0N9UJlcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675697; c=relaxed/simple;
	bh=cotihfo1Bp/34MPHcrNscgZZlFHpB2wnf0qAKt7jQHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lxcx5dttx0qdK17aCj9VMGvQjBejSlknUdU3FxvRtqyAbCeQvIFX0dhhQ219gSQQocL4B7cSmJxmDou4D1Ml0ppVCSAc+HSyJ4N4SpfYjhm5ikJeROb1HlvT7W9LbTUlg7s1XuDN6hGQR9eyZ7iHX67lBuAem/wMwbHybpw7YIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GUbPr2M9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GUbPr2M9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=QvfLzpZ5p3ZyCP2o0RSxYmvBgDjWPHiLn0170VHtJ1s=; b=GUbPr2M9O9ziu130D1GpupW3bh
	MYY+rsOLkH9uEM2qNmxjG0GTPO6BehoPV347v21VnaHJX9L6MirsD5OAJzfEnYlByVAuwICxvdpzb
	IaDZgsQ0XCEcOTlPXR0rhBTQD3gC0XixGH8BbzPb+vfJwlsrZkuGIvOecNYSXc1SrqhZAfHO6rlTB
	3LeltoERw5hLITKGtYkZa3R2iRrvUB6WESl6eDodxJtfaHlTQ602++OmsThskrbuD27w+VyN7rJlj
	5SGA2ifUXNLvWZhkupmzo2tibMYoxA/ce4pVRP1n1UKmmdtORRHWJs1Ua5DYrvvvDUP3OkOLgDgph
	YULLSB5A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN8nN-003A89-2j;
	Wed, 13 May 2026 12:34:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 05:34:12 -0700
Subject: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5539; i=leitao@debian.org;
 h=from:subject:message-id; bh=cotihfo1Bp/34MPHcrNscgZZlFHpB2wnf0qAKt7jQHQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBG/PJPmaySrhQsMA6XcpqSAip19+SSKBMC6vT
 kurMalQ3AeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRvzwAKCRA1o5Of/Hh3
 bWG3EACkPeI4Ah5EBDdnfR3CbYoo1pvGWTh7i+GIQMfU74lfruS4JZrokiETu9DBImQZFb50YOG
 lUYgeDMAQ3nxMrw4FD13eUPUqTxQdtpfc4BT7bzR6lxJDF3iQA7CEiDXnQ+XMkBKMRe2bj8WQec
 YzZzFUlHKBijW5VtD3Z3PZb6RGgigERECZxTKabwg0ktBsX6bN089WG4glWcVPt3FWZnsJWrV/t
 gLMmu/kIEp/qp9lMHshzJk0lld5JfXN1ApLgEXfn2qzdtqObtIOdd0S0HkEhA63EugY7LlJu7Rj
 Cn05+MBIfS8VC8+ueHK/LcEHRxyrJ5LdFO3v56kwl8+kUzZsf6t1D99qlG6xb44WTtaC0kyTSeo
 zDHLeSuJsinY/V0+syvhNoCHQnC47zaTiWozKpXmB93J38ijHcDy9OlDM58LUmvvkBX2pJ0ouo8
 O3b7zc2ndoD9Uks94NX/9ChrdPuqD0h4cBx/GqE07+RMJwd0NzwSD529rd2a9kVR+bO0lsj3AG6
 E3hj0EL8ipwvcq1xbKW6OIJXpnknHcYnm/G5y8/a3gBHe75df1fY9zS40ny/nAYBuICPicSjmWD
 T1l+Udj6A8ulFe1DtDXgFIsdR3wjnzmLSHCPwaIt9ylmBJX2UmmBbJihkYuDG/ZP5f5l+ZXLF/w
 yT8YMxPf0p5ou1Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert the ATM SVC and PVC sockets, along with the shared
vcc_getsockopt() helper, to use the new getsockopt_iter callback with
sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/atm/common.c | 18 +++++++++++-------
 net/atm/common.h |  2 +-
 net/atm/pvc.c    |  6 +++---
 net/atm/svc.c    | 15 +++++++--------
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index fe77f51f6ce18..88483cedd25cc 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -23,6 +23,7 @@
 #include <net/sock.h>		/* struct sock */
 #include <linux/uaccess.h>
 #include <linux/poll.h>
+#include <linux/uio.h>
 
 #include <linux/atomic.h>
 
@@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 }
 
 int vcc_getsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, int __user *optlen)
+		   sockopt_t *opt)
 {
 	struct atm_vcc *vcc;
+	unsigned long val;
 	int len;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 	if (__SO_LEVEL_MATCH(optname, level) && len != __SO_SIZE(optname))
 		return -EINVAL;
 
@@ -812,11 +813,13 @@ int vcc_getsockopt(struct socket *sock, int level, int optname,
 	case SO_ATMQOS:
 		if (!test_bit(ATM_VF_HASQOS, &vcc->flags))
 			return -EINVAL;
-		return copy_to_user(optval, &vcc->qos, sizeof(vcc->qos))
+		return copy_to_iter(&vcc->qos, sizeof(vcc->qos),
+				    &opt->iter_out) != sizeof(vcc->qos)
 			? -EFAULT : 0;
 	case SO_SETCLP:
-		return put_user(vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0,
-				(unsigned long __user *)optval) ? -EFAULT : 0;
+		val = vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0;
+		return copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		       sizeof(val) ? -EFAULT : 0;
 	case SO_ATMPVC:
 	{
 		struct sockaddr_atmpvc pvc;
@@ -828,7 +831,8 @@ int vcc_getsockopt(struct socket *sock, int level, int optname,
 		pvc.sap_addr.itf = vcc->dev->number;
 		pvc.sap_addr.vpi = vcc->vpi;
 		pvc.sap_addr.vci = vcc->vci;
-		return copy_to_user(optval, &pvc, sizeof(pvc)) ? -EFAULT : 0;
+		return copy_to_iter(&pvc, sizeof(pvc), &opt->iter_out) !=
+		       sizeof(pvc) ? -EFAULT : 0;
 	}
 	default:
 		return -EINVAL;
diff --git a/net/atm/common.h b/net/atm/common.h
index a1e56e8de698a..ae4502abf0281 100644
--- a/net/atm/common.h
+++ b/net/atm/common.h
@@ -23,7 +23,7 @@ int vcc_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int vcc_setsockopt(struct socket *sock, int level, int optname,
 		   sockptr_t optval, unsigned int optlen);
 int vcc_getsockopt(struct socket *sock, int level, int optname,
-		   char __user *optval, int __user *optlen);
+		   sockopt_t *opt);
 void vcc_process_recv_queue(struct atm_vcc *vcc);
 
 int atmpvc_init(void);
diff --git a/net/atm/pvc.c b/net/atm/pvc.c
index 8f5e76f5dd9e8..8b2c3e515601e 100644
--- a/net/atm/pvc.c
+++ b/net/atm/pvc.c
@@ -75,13 +75,13 @@ static int pvc_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int pvc_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	int error;
 
 	lock_sock(sk);
-	error = vcc_getsockopt(sock, level, optname, optval, optlen);
+	error = vcc_getsockopt(sock, level, optname, opt);
 	release_sock(sk);
 	return error;
 }
@@ -122,7 +122,7 @@ static const struct proto_ops pvc_proto_ops = {
 	.listen =	sock_no_listen,
 	.shutdown =	pvc_shutdown,
 	.setsockopt =	pvc_setsockopt,
-	.getsockopt =	pvc_getsockopt,
+	.getsockopt_iter = pvc_getsockopt,
 	.sendmsg =	vcc_sendmsg,
 	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 005964250ecd2..7c5559f50a99e 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <net/sock.h>		/* for sock_no_* */
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/export.h>
 
 #include "resources.h"
@@ -501,25 +502,23 @@ static int svc_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int svc_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+			  sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	int error = 0, len;
 
 	lock_sock(sk);
 	if (!__SO_LEVEL_MATCH(optname, level) || optname != SO_ATMSAP) {
-		error = vcc_getsockopt(sock, level, optname, optval, optlen);
-		goto out;
-	}
-	if (get_user(len, optlen)) {
-		error = -EFAULT;
+		error = vcc_getsockopt(sock, level, optname, opt);
 		goto out;
 	}
+	len = opt->optlen;
 	if (len != sizeof(struct atm_sap)) {
 		error = -EINVAL;
 		goto out;
 	}
-	if (copy_to_user(optval, &ATM_SD(sock)->sap, sizeof(struct atm_sap))) {
+	if (copy_to_iter(&ATM_SD(sock)->sap, sizeof(struct atm_sap),
+			 &opt->iter_out) != sizeof(struct atm_sap)) {
 		error = -EFAULT;
 		goto out;
 	}
@@ -650,7 +649,7 @@ static const struct proto_ops svc_proto_ops = {
 	.listen =	svc_listen,
 	.shutdown =	svc_shutdown,
 	.setsockopt =	svc_setsockopt,
-	.getsockopt =	svc_getsockopt,
+	.getsockopt_iter = svc_getsockopt,
 	.sendmsg =	vcc_sendmsg,
 	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,

-- 
2.53.0-Meta

