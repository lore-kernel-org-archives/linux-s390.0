Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FF3A3833;
	Wed, 20 May 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296058; cv=none; b=DRkoEyuERu1TPgxL/W2le4e6UxgRzPAf+/Z73zOcYG9D1hg4dStcyu/fddsCR3erCTV4qoLACL5Y6Payn+/zVb3aEYY+5/W+cgTK4VbMzm1ytg+N7DsLbEK1deo3ZDrI7X7SmKs3DR1+dMYI9sj4WL7gw5XIfTgsJi5S+7V4rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296058; c=relaxed/simple;
	bh=7l+w+wAHbKIY6oUNofPuNKiOa09kSTq+kbLkWSY/nls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITMucSwhGoscpKFl+pMuZDquV94Qm0JOaVg/xFVJTRWVOKT+b4Wm4wMh6UfZreHqWpL5o35+lpY1vkKc7oR91q+5QEKdvodatOIQpPKNgOfI8ozLxWqN6EzoMr4O/GjsBwPpEOGkKlZlJtSGRH7OeZ33dOZw8RwErmsFl3c34lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VDQdHEIQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VDQdHEIQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Ptm+lhG+ow6TJjPimxQw3wswK8UCGdIIvOov5LodgH0=; b=VDQdHEIQcIuzZB+CTi3f4vMnr+
	tMe6vicn6xweGWJztFnMcXQ30qO4/ztgXj/tTPEXcvJIZfF++SySTh2bGubTddWExgvW0DffMRdRp
	aW8HlRvW593io6gDO0JmrEFvoCiHSPczR341N/zcrRbr/kP54W9ZdSPy2X9Egfy7J5x6gKKQcAMEk
	qG1vMXDbKsIeWl+ldUPG9hX5674L1gJT86Ngt6uidLTcPOiu4SeD4mONYFoxkO+3IhopvJVVf7UNC
	z9m7XTK58nQ9QKBsLGsXySFAIbYsP7A7hXnwb80giryot3gTmJhTDMIvJN6bHZsrcbv/2S0gBMoNh
	KOFhGSkw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkBP-003FUE-1t;
	Wed, 20 May 2026 16:54:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 20 May 2026 09:53:47 -0700
Subject: [PATCH net-next v3 2/6] atm: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-getsock_four-v3-2-b8c0b16b7780@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5577; i=leitao@debian.org;
 h=from:subject:message-id; bh=7l+w+wAHbKIY6oUNofPuNKiOa09kSTq+kbLkWSY/nls=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDecgDyOylxAhdojD2pQ5yeusXKyTkiSM74p0T
 YSDXeQTXuKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag3nIAAKCRA1o5Of/Hh3
 bQJID/4grFELZuj5tuz2bZx3GTfJ8BTo4DORVc199/4cNThITGE25gYomss+iVQv6yye6P4fzKA
 UsKJtMusG9udt4gi63IdueBOLnveH0p/OD8C+Xa7sxUPfq0UitlrA0QBpDlKl6dHVblxvC7SDE6
 6fVyYBR7VLgeo7oS2O0tCBtRseAqip1hOzk8MS45//8SO15EvxKWj6BxWNMalf4m4dcIO94zaXD
 Cs8G4aTImCW6QAtVdYFBqmIAfXLEfp9D4hTlQH1wr9OcE4HR71EnIaCzzinJGdaC2jpWnGC/5zp
 pEorYd3Qj/RBu6aPAgCNrzf5rnoBWMpcw7tKoO9oqcUN+gylkU0hXKZ1stPG/dBIaVSq80am+tY
 sAwe8uzA0bjVCo03mAnJf13EUrSJMIR2CYDGqfrFtoQ6Hcqa2G04fe5wwtYSnfXQSuNYKHAUUvC
 YTlLa/kRHkuHHOBV6xT8h++v3KshWlkvYrDLMZZqbkduIVU69qZFsjWQCiKFi23vZUOIu9SutZh
 jItt1b22jyVJxfA7N6SnRYw3uJJ6rUbljzhm1f1j2UgY8Xc/ThNjslPAWp7kiv8jjd9mkApIaL0
 IMD8WHoz3B2q+nzfgh2NarQGsR8FpHYMes/Gqt/Zl52F8mLGZ5XTo2kHjT5/0qQ/zKvGCYicRT4
 4RRA1kA+O8Oy4UA==
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/atm/common.c | 18 +++++++++++-------
 net/atm/common.h |  2 +-
 net/atm/pvc.c    |  6 +++---
 net/atm/svc.c    | 15 +++++++--------
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index fe77f51f6ce18..60132de4eebe1 100644
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
+	int val;
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

