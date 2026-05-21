Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD713F0AB1;
	Thu, 21 May 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374100; cv=none; b=buyB/pWQOqJ7Y3QiozBcICxSc7vbnMNkIm2dqQaiR+CR3BlSE6o1r4Ad7V9lygDo1un8snnVRUeQwADIDfzbsDkCRSIl4b4wJyfk7PoX1HdkhVxlXLKQoRBSWZ3bj7O1hKmcPX7lCjMadbV7KZFD8YKYQIfd7CLmfFRVBmGHv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374100; c=relaxed/simple;
	bh=KOcqB4yiXaUIQL7EBJxJNPCiiEntHJ1bUw8VYCWroQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SasILCP03v6EOkCTvFeFk0Vm7OiHkZdSZAsJ8gl7C+6fGkCW4EiAz/kHVonzXPB/eImu/LcAlI2nIu5nKKDhPy0/06QPZs2j1zaH3rfQSMuUA8DQ9BaCwTLfsghbss+EeibXaDmfwc5EUd/QQ6s0c9iRfjPSd+IjPfLrBSl44RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BSMtO0QA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BSMtO0QA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=qAMGqTgmR8jSCdmI+3X6UVT4uJLS740CwO54lzXmRr0=; b=BSMtO0QAxYtBvbaIUIuu/RkNRo
	sP7sh6Xt1jZRnIb/d8RI0Jh5vpVeFqcyTdauqTCnkGyuMH9L9jnwfRVO0KRKJjg9iptb6CCj6GE3Y
	qLqymGi6NbZ09QRCzIK8y9tDItyH2hCOfd8t+zrXi+VyAVMbdgY8isFlYNroWVF3FavcIrpi8iukT
	6TkZ0KZizXy54h4LnH5K+Ao/yzxrft0HZTyQcuhSMl1maTsHu9qe1F5tEn611lamjSTd6Fjs4waj2
	X+cftUQvX/sPHNDnpi2Fpha3m+rx3BFqU47CZGSV++Q7GhVqQCuQKmc41usxZFKn9dPfTsB4V6ZGC
	zzP6/AEA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ48C-003wJF-2q;
	Thu, 21 May 2026 14:12:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 21 May 2026 07:11:45 -0700
Subject: [PATCH net] net/iucv: fix locking in .getsockopt
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-af_iucv_fix2-v1-1-f16b1c510aa9@debian.org>
X-B4-Tracking: v=1; b=H4sIAKASD2oC/yXMQQqDMBAF0KsMf20gpsZArlKKpHGi4yItiYog3
 r203b7FO1G5CFd4OlF4lyqvDE9tQ4hzyBMrGeEJRpteW6NVSINscR+SHEa5ztk+6FtnW4eG8C6
 c5Ph1d2Re8fhj3Z4Lx/Ub4bo+w+XycXUAAAA=
X-Change-ID: 20260520-af_iucv_fix2-74756a034517
To: Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ursula Braun <ursula.braun@de.ibm.com>, 
 Frank Blaschka <frank.blaschka@de.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Stanislav Fomichev <sdf.kernel@gmail.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=leitao@debian.org;
 h=from:subject:message-id; bh=KOcqB4yiXaUIQL7EBJxJNPCiiEntHJ1bUw8VYCWroQA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqDxK3tMf/ylUFHpLxikkm2upb64Ed2ZLgjulnm
 UAsOI56JViJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCag8StwAKCRA1o5Of/Hh3
 bS5GD/9g0WFCY/wMWvxDQMlhYsmfkNfHZL5OCW2hq02snkDp9agp/tjVHT3EFWoUFwc5hnFrSCE
 CGA0GdctEd+tvz/YkaFOA9dmtWruSMZX9IhtffAuvc6ZCZCdRwZvkSG1ZqY6XxUucU23Qe35oOt
 YAjmaXz9Bf19MkV/zPRLPbjmt6GyLJsC/lYUYHENWJhiRh6g1oQzmutnh5E7lO/8LQ2MjeJVu/V
 5bXdNgfujk41lZ1YCPMbeSWPTLVMRX8GQKJnTB1Sxg7RBbxEFetrO2hPlxIJayTyQGFMGW/nGux
 TytPgwc/CWa4+o/mK0ueahgtCOD6OawLSu4Oukpknw5ldvsbsl44JbVHlXNTFtMsJVHvmA4NXMK
 z9w+HZymOemHONr4UGgMYo3DPLIREg/liAaMCCe1FKAqXQc2qriPc9aJFi3EnEKIS9GuSY00kF3
 D3nsvlwtimm6qV114e4+kiu3a21fohDh5IUX5MRTee4goQ9DtUANd7t/Ou1zdk18eifIddWqOKQ
 wYL0MofDUiCJuOcxPQ99fhI8THBDdTVJBRsMV/BcN5JwHyTwCBTCNwjCAMVv9H/Nb/ZeHQTgDzU
 /ieAQOzoM9IxXe/3pctCDx4qU8ij3GvfstfAonEGX/5y5R4OZ0EaaRJXoV72O+JHaxaGC13RDbJ
 sSCTIEbsk8VDF4g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Mirror iucv_sock_setsockopt() and wrap the whole switch in
lock_sock()/release_sock(). The pre-existing SO_MSGLIMIT-only lock
becomes redundant and is removed.

Any AF_IUCV HIPER user can potentially crash the kernel by racing
recvmsg() with getsockopt(SO_MSGSIZE): the SO_MSGSIZE arm dereferences
iucv->hs_dev->mtu after iucv_sock_close() (called from the racing
recvmsg()) has set hs_dev to NULL, producing a NULL pointer dereference
oops.

Suggested-by: Stanislav Fomichev <sdf.kernel@gmail.com>
Fixes: 51363b8751a6 ("af_iucv: allow retrieval of maximum message size")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Note1: Not using goto/label to simplify the merge conflict that might
happen with the migration of af_iucv to getsockopt_iter

Note2: This was only compile-tested.
---
 net/iucv/af_iucv.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 72dfccd4e3d58..c2dc3338670e8 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1540,7 +1540,7 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int val;
-	int len;
+	int len, rc;
 
 	if (level != SOL_IUCV)
 		return -ENOPROTOOPT;
@@ -1553,26 +1553,34 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	len = min_t(unsigned int, len, sizeof(int));
 
+	rc = 0;
+
+	lock_sock(sk);
 	switch (optname) {
 	case SO_IPRMDATA_MSG:
 		val = (iucv->flags & IUCV_IPRMDATA) ? 1 : 0;
 		break;
 	case SO_MSGLIMIT:
-		lock_sock(sk);
 		val = (iucv->path != NULL) ? iucv->path->msglim	/* connected */
 					   : iucv->msglimit;	/* default */
-		release_sock(sk);
 		break;
 	case SO_MSGSIZE:
-		if (sk->sk_state == IUCV_OPEN)
-			return -EBADFD;
+		if (sk->sk_state == IUCV_OPEN) {
+			rc = -EBADFD;
+			break;
+		}
 		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
 				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
 				0x7fffffff;
 		break;
 	default:
-		return -ENOPROTOOPT;
+		rc = -ENOPROTOOPT;
+		break;
 	}
+	release_sock(sk);
+
+	if (rc)
+		return rc;
 
 	if (put_user(len, optlen))
 		return -EFAULT;

---
base-commit: dc416e32baaeb620b9809e9e25fc7b30889686e9
change-id: 20260520-af_iucv_fix2-74756a034517

Best regards,
--  
Breno Leitao <leitao@debian.org>

