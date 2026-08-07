Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819F353A8A;
	Fri,  7 Aug 2026 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090592; cv=none; b=FBhWIdfOBJ8t6Tey+7Fy8Krvj+4Xc5YyIJs4F1x7b3zlVrqUDJhUekGwtbqZqoY6e7EM9JO0xH/H7c55lrJKUPSilwTAmfyVQO2/P/eL4rkqnhKN2Qqr3acTkDk18/ViyNVe+y/1GRWpN9wX7wg0BmflLZ0URefi9wXYt78ZUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090592; c=relaxed/simple;
	bh=W47yOSk9qb5NcAFRGAJeiVanZr3v0kIwsjLEnwE0fiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lv/SjV14xJQhoOSWmn68Qzr0Ny8qMtM/yIMF5Pvo07+v8Fg6dSIhk6FHSORKX1MJ7gkc2K5bm/UZofjTXtxWFx2OfqDE/OdsKiOb/PUu0TT2pkNC9SMlUbiYLUUrqre3AKfVif7EPvb6UHwF/jfgx0cnRR+esPZzJbbQwg0HJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PliJx1Zy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PliJx1Zy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HeKD4133718;
	Fri, 7 Aug 2026 08:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BaJiXoXuKSqz4T4+M5qhLC0eDA4i
	85Nl+WhDorNPAa8=; b=PliJx1ZyFIgT7gq9tfe3NOumFNv7lrnhGiCi6qXuUEsl
	CWEEJ1KluRPNMIYg52N2p1s/eixQRkBzJKdusZEVTi3l2g9Xcx+OiIH3vFSqrG3A
	Bo9GnjFTB7UK+5yQFP9mEUCL7+uYxLtT+IzjrgxNJlunVUOXgAihYHeqOlHHLomM
	OWYVoO4RtAwchiL+bS9rRfhyxtnvLtC+dhfXaAv4sFw4KnidGJ1D21Z6U7X5SiDJ
	yUdn0C9VA2U2mHZzJ/hsQir5rElQmvvnoUUp8A9ySD1N22mLnL5aCGnJPxQ9iXfz
	LsHm+V/EoMutTbmF2S7P0iP9/RPugySScPpkyoZl1w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy042ygk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 08:16:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6778BJmU013038;
	Fri, 7 Aug 2026 08:16:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhptj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 08:16:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6778GF6A43516256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 08:16:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF7A2004D;
	Fri,  7 Aug 2026 08:16:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10AB2004B;
	Fri,  7 Aug 2026 08:16:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  7 Aug 2026 08:16:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id CAD99160DFC; Fri, 07 Aug 2026 10:16:14 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path
Date: Fri,  7 Aug 2026 10:16:04 +0200
Message-ID: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1NyBTYWx0ZWRfXx4Y43Akhefun
 24sBYsMLeKFO4WujLbDetqXVRGnKPWJf5lh4cbaQJ72Py8eYGqU4HcKnen4KJ2hZUzk5ZEHAnVG
 BMGLaNc2EaGxxpDHGJqP3IhGBUDaPiLOXAsKWShbuK+zqQEVknOdVXI/iPkfqXr9p5JcQUOEYXJ
 7sO6O4I9alQ118XKdGDszoS/4ZCgVtgW4Y8kT991x7ZGod0DiE8OjtCKH7yuJ43ZWNl2FzkM9UY
 OkdoWZDgNmJgU44cUsiQTATGAz04wJ2kU1CAotPruly9tsbYqrxkLXyXAv+kimCLkAWxMZsv6K4
 nDk2d8GsG2ChVqlWbueo9lFqqlYDKiQMe9O58aCu4ywtl6EjkNVCh2hixccHds51Lz4EaABumDy
 eOgUezznOtIGOeHEfpIhAgPEGUUyAC+2Lb1vdjO3xO3dJcthfAzWak7hC5VJN6OYH7YCnY6DlG3
 0QCPMVBAqafwVXZ0v5Q==
X-Proofpoint-ORIG-GUID: N-gexsGQoPS_Cu7dchBsN5xiW4UrsWqJ
X-Proofpoint-GUID: sHUUdkfmuf19Xa13JQm1Pbrtr-Evabz1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1NyBTYWx0ZWRfX3bo0LicR6M7C
 vaOvGXVbC5/Eoknxi55gcJqmzn3NFbJAWy0TSQleZI/M+4unVjtyeEiaXawh/ghuha3tiWeRvhI
 1GXlHpuEky4iVrFZGpXoNnUmO6KWryc=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a759455 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ChcJzeUvlmU10I9KIo8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070057

Two races in the SMC diag dump path:

Race 1: smc_diag_msg_common_fill() reads smc->clcsock fields after a
NULL check, but smc_clcsock_release() can set clcsock =3D NULL under
clcsock_release_lock between the check and the reads.  Hold the same
mutex in the read path to make the check and reads atomic.

Race 2: __smc_diag_dump() dereferences conn->lgr and conn->lnk with no
protection against concurrent teardown.  smc_close_active_abort() calls
smc_conn_free() =E2=80=94 which drops lgr and link refcounts =E2=80=94 wi=
thout first
unhashing the socket, leaving stale pointers visible to the dump.  The
teardown path holds lock_sock(sk) across smc_conn_free(); take the same
lock in __smc_diag_dump() to serialise fully.

Both fixes require sleeping locks, which are illegal under the
read_lock(&smc_hash->lock) held by smc_diag_dump_proto().  Pin each
socket with refcount_inc_not_zero() before dropping the hash lock, call
__smc_diag_dump() locklessly, then release the pin.  Restart sk_for_each(=
)
from head after each unlock rather than resuming mid-walk:
smc_unhash_sk() nulls sk->sk_node.next via sk_del_node_init(), so
resuming an interrupted walk silently truncates the dump.

Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
Fixes: 9dbe086c69b8 ("net/smc: fix invalid link access in dumping SMC-R c=
onnections")
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 net/smc/smc_diag.c | 78 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index bf0beaa23bdb..000000000000 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -39,22 +39,34 @@
 	memset(r, 0, sizeof(*r));
 	r->diag_family =3D sk->sk_family;
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
-	if (!smc->clcsock)
-		return;
-	r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
-	r->id.idiag_dport =3D smc->clcsock->sk->sk_dport;
-	r->id.idiag_if =3D smc->clcsock->sk->sk_bound_dev_if;
-	if (sk->sk_protocol =3D=3D SMCPROTO_SMC) {
-		r->id.idiag_src[0] =3D smc->clcsock->sk->sk_rcv_saddr;
-		r->id.idiag_dst[0] =3D smc->clcsock->sk->sk_daddr;
+	/*
+	 * smc_clcsock_release() sets smc->clcsock =3D NULL under
+	 * clcsock_release_lock before freeing the socket. Hold the same
+	 * mutex here to make the NULL check and all field reads atomic
+	 * with that writer. mutex_lock() is safe: this function is called
+	 * only after the hash spinlock has been dropped by
+	 * smc_diag_dump_proto().
+	 */
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock) {
+		r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
+		r->id.idiag_dport =3D smc->clcsock->sk->sk_dport;
+		r->id.idiag_if =3D smc->clcsock->sk->sk_bound_dev_if;
+		if (sk->sk_protocol =3D=3D SMCPROTO_SMC) {
+			r->id.idiag_src[0] =3D smc->clcsock->sk->sk_rcv_saddr;
+			r->id.idiag_dst[0] =3D smc->clcsock->sk->sk_daddr;
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (sk->sk_protocol =3D=3D SMCPROTO_SMC6) {
-		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
-		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
-		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
-		       sizeof(smc->clcsock->sk->sk_v6_daddr));
+		} else if (sk->sk_protocol =3D=3D SMCPROTO_SMC6) {
+			memcpy(&r->id.idiag_src,
+			       &smc->clcsock->sk->sk_v6_rcv_saddr,
+			       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
+			memcpy(&r->id.idiag_dst,
+			       &smc->clcsock->sk->sk_v6_daddr,
+			       sizeof(smc->clcsock->sk->sk_v6_daddr));
 #endif
+		}
 	}
+	mutex_unlock(&smc->clcsock_release_lock);
 }
=20
 static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
@@ -87,6 +99,15 @@
=20
 	r =3D nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
+	/*
+	 * Take the socket lock to serialise against smc_conn_free(),
+	 * which drops lgr and link refcounts under lock_sock(). Without
+	 * this, a concurrent close can free lgr->lnk[] memory between
+	 * our smc_conn_lgr_valid() check and the subsequent lgr/lnk
+	 * dereferences. lock_sock() is safe here because the hash
+	 * spinlock has been dropped by smc_diag_dump_proto().
+	 */
+	lock_sock(sk);
 	r->diag_state =3D sk->sk_state;
 	if (smc->use_fallback)
 		r->diag_mode =3D SMC_DIAG_MODE_FALLBACK_TCP;
@@ -182,13 +203,16 @@
 		dinfo.peer_token =3D conn->peer_token;
=20
 		if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
 			goto errout;
 	}
=20
+	release_sock(sk);
+
 	nlmsg_end(skb, nlh);
 	return 0;
=20
 errout:
+	release_sock(sk);
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
 }
@@ -204,25 +228,43 @@
 	int rc =3D 0, num =3D 0;
 	struct sock *sk;
=20
-	read_lock(&prot->h.smc_hash->lock);
 	head =3D &prot->h.smc_hash->ht;
+restart:
+	num =3D 0;
+	read_lock(&prot->h.smc_hash->lock);
 	if (hlist_empty(head))
 		goto out;
-
 	sk_for_each(sk, head) {
 		if (!net_eq(sock_net(sk), net))
 			continue;
 		if (num < snum)
 			goto next;
+		/*
+		 * Pin sk before dropping the lock. refcount_inc_not_zero()
+		 * skips sockets already past their last reference.
+		 * smc_unhash_sk() nulls sk->sk_node.next via sk_del_node_init()
+		 * so resuming an interrupted sk_for_each() would terminate
+		 * early if a socket is unhashed while the lock is dropped.
+		 * Restart from head after each unlock, using snum to skip
+		 * already-dumped entries.
+		 */
+		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			goto next;
+		read_unlock(&prot->h.smc_hash->lock);
+
 		rc =3D __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		sock_put(sk);
+
 		if (rc < 0)
-			goto out;
+			goto out_nolock;
+		snum =3D num + 1;
+		goto restart;
 next:
 		num++;
 	}
-
 out:
 	read_unlock(&prot->h.smc_hash->lock);
+out_nolock:
 	cb_ctx->pos[p_type] =3D num;
 	return rc;
 }
--=20
2.50.1
