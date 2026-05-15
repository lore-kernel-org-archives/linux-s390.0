Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D914014A4;
	Fri, 15 May 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834035; cv=none; b=G9GxJ1trrurc8E4qsoFKL6aRS23qcSpRPPKEQC/Vmr8FuiO1aKGvgQIw3MiFNX+8VS8YnaLBdFN3feB861OqfI/HaY5omDyqOWNdfmUR2veI8A5TMkZ+A6qemoHf5UbaXq0xlf7HaghUrA+NUF2wgvPOP9Pp5kxXNjRRkSpO9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834035; c=relaxed/simple;
	bh=7l+w+wAHbKIY6oUNofPuNKiOa09kSTq+kbLkWSY/nls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4oaFAKKkGTiYrVAhxiaZk/1QHOWhPMV+JhlYjXil+02i8aHxDtq0unGGHJ6dtek2+c97nq2nrsnegd/a3fqsnmbNsGzz+5d7E+Y+RU1ZXyyWyJtJNxnS/Kt6/w2YiwF5pnLg0NOeERHvwmsyRBw1KGWNwQVZigw3afygvxrec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KU9YorJ/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KU9YorJ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Ptm+lhG+ow6TJjPimxQw3wswK8UCGdIIvOov5LodgH0=; b=KU9YorJ/Hp4rbEiOUtAiGcd0hW
	wd8YT/eY8Z1k1rNowfy910L+Rf9N2gwp5kMUMbA4FEP9KxEtUXR4XMYvJ2hIuHfZ+dXIlQCwXHxUa
	ydJ+2VGdKhXWi6/saAuNOxQ66s/H9amy1DC5+4dg3yNa4Y7BpUI6U3ap9Nzb7wqIS9Ghtb+IlimuZ
	BuPBKCEQxbC9ExHvGTo9PFH++UROpTGVw8ex+7LLqXmPhKMf2AWN00FvuXU8k40juM7CeDat58Tdy
	Sd82o278MtXHtlPwkwUm5vQgxRGFAMx2QCNgC0zRXHbQBaCm7cdmgwoOsFs+zuh+oKB+HcAGcDYQk
	yChpsRqg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNnzI-004b9T-02;
	Fri, 15 May 2026 08:33:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 01:32:27 -0700
Subject: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5577; i=leitao@debian.org;
 h=from:subject:message-id; bh=7l+w+wAHbKIY6oUNofPuNKiOa09kSTq+kbLkWSY/nls=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBtpKI+pXBtju5rfwiCSvXDS2ZMzcrCVCnjDi0
 Usbz0i7BkeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagbaSgAKCRA1o5Of/Hh3
 bY3eD/49YT7QF6Cq4WhqeR1WeJahw0Yj9bE5BVqenUWD3L0nXNS04gcxBEpuebgr3tyJhenutu2
 J9TUdN90F07HLAQUNpRyF47bJTrSVSKZtSPVC9j39MYIT++2nBUeDjqe7ngopXB4Wt0l5nXDgUe
 AbOibdNY3dMBFZPiPuMKouje3hyPRQLAR6IEB9GABViTeROf9HszfQhrh3aNqnQg9Ky7ix1QqTU
 1SeueG/3cJ9igmUoQA7DW9SBbWOOomHqYQfMJAHbMhegudb9eplWcfvwj6bscKSPhMIxbcUfCxP
 BKkGH7zD9tgZyuX80pljxMtHWdRDS6w2a0aoJuJ+lPjcFVWOwK8UyndEbE+YkFbhbUFFQ7OnsVf
 Zv1uAWfPK5Rm2I83/1LtViq7paz9N2PUQucg714tOprsPPB1/Q3pEDtmWoOzrjNa+GG2Ojkf5hX
 SdZUC7PXL6lwYM0toL84aR6oTme2zjSBUJlfut1N2IxoKpT6QuY7hmoF6Z8MVEOYDH7m5F+ms/3
 DZtyl6T/dbZtjhhCVtQd5vYzpb7JfaPBF+w2gCvsU5oiQCZpHgeAo1XfEsFpndbtSaKgQugyAOo
 8UA4jPZfyCld/TxCSnRiIGY0nkiWYDuGB/g2xgZWLKR9Q+Ke8u/a44TLAe5TlaVzboFGuJVuJuV
 rSH4ay84XyWPJag==
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

