Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00ED4BE45F;
	Thu, 10 Sep 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057778; cv=none; b=bjgnjumFrAbjiGsdLDYB3SyUypqj4SDGnNE0eyedZsHrK0ixVERgB0tMmhaMpeGcBEEF4xo5xKKLPDO2M/SDPDz2tw//jGlE4zJRQsZOc3zmX5CHVKyFkdutwCrn2oroJc06Din5aV6CqLxw6+f4ON/xDpmE3/P3BCZcP4W0RbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057778; c=relaxed/simple;
	bh=2Apoet0k8WVTXIH4aVqalEbrP7NA3KRZmITBGA13cNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPMNTGyODTwcXv3YBsR3AOe9cRgQROuRBeUoR05eJu4rZUiek/eV3sVGiAmNvUKD0KMMth3PV3nb9aHzyWWHo5k6JNrkPCtxwugbBBvmc1r9GUl6iS+upayD1n7NAEiPV0Ji94bOPwlBACYXD7BiXBtH9VJvp/fe3NbslcpyZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oipBapYS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oipBapYS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AFD2fj3266059;
	Thu, 10 Sep 2026 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aUWRntB0d1H6IbL2iLaI3jV9B96pWL+EMeYnI0uoq
	C8=; b=oipBapYSUnVwwvOLZMfViWbcJX3CL3lutuGgVmNaBwX/yJ452NFJYTwNd
	lhnysLfsVGHPaxyRgcXHEIh1gSrpM2Q7jxg19+tgcvVIjAF1NUGGU4br6GApvsou
	sOKVGfivxcxmBbTaFe4X5b23xoeKMtHSnIzJxjpO7tAffDMTzH3juTS1/VX1+JAa
	ZOR4mCD0CkR/H2wyrAjr+vgZv6nJDq3Vdl79vy0QmvsWVY+sSQSWyPdyLlaJwnPk
	gA5Kq99RRjQeLQ0CRf+OZUholfm7wqNoZstuHQKcarsx5Ea/1rU56rL3BQyOoBvQ
	Eq7bwMTo1kKYfJerc9vtNOj2fPsRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qp02x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 16:29:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7bRF183835;
	Thu, 10 Sep 2026 16:29:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk15ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 16:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AGTKE845023712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 16:29:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F4620043;
	Thu, 10 Sep 2026 16:29:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF8B820040;
	Thu, 10 Sep 2026 16:29:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 10 Sep 2026 16:29:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 934AE160E52; Thu, 10 Sep 2026 18:29:19 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>,
        Bryam Vargas <hexlabsecurity@proton.me>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net/iucv: Add lock nesting annotation in iucv_sock_close()
Date: Thu, 10 Sep 2026 18:29:19 +0200
Message-ID: <20260910162919.2100124-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa2dae5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YCHcyxAEXZIDGAU0KIQA:9
X-Proofpoint-ORIG-GUID: O5RiHSyALEiXTKwLZLCuKGs-v8vou-ie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX5IbPbw1+PUpJ
 CZr3m0WGiVS7WY++xiMvu72AjT7wIx3jBQPQsWkIsmzxkz6HSVcYv0evvUf6P5RB35YsFRAvNNm
 GVq5JtBDUH30ODnUoT2flkV/lbnCKmO6cqUn4PnizUx0QY48mryZL+U90uyrA7jmkj0StqtTDRF
 OcJYXYbC3hGXaXkaKaBwXOZzaVKHMGAle0NIrdayYCTksFS/yBXYYuCc2lSiHMJdNKRDYZPzPSn
 OwMbfXocO+7a2oxBjoVazDuLwM1atXWOkWRJae197XwvUjDCY7AHPZG9zK/t6Ui1krMow+XsxSQ
 2xFndY7LfKHfaG5eIj77tgDYZ5QCluo51pidP2mAKJ2y9p1/u9AD8ONfH7x/1qoHAbbrHurTZkm
 nWgpEmyT+LNH9my9a3WnSPYD+gBEOijCFIagS3asFSzhGu5tHOgWdHHhTqHRNlCOy6Ke4HQqK9p
 HHAKZRh3tSlvBVhyO7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX0U8v98GKHpjK
 4ua7m41k9tJZ57fVvzuSohd3VY9KZf7WGiywjYHETVPURqNJcf/VqGR/S3ZT64Yg6apDxoc1lkw
 HxeLs8M0CNa0qVFgxKw+MoebhArs9Cs=
X-Proofpoint-GUID: 4t-QwTGFYCM9wdBTLQGUewm-RB_p5FeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

iucv_sock_close() acquires lock_sock(sk) and then, when the socket is in
IUCV_LISTEN state, calls iucv_sock_cleanup_listen() which acquires
lock_sock(child_sk) for each pending child socket. Moreover
iucv_sock_close(child_sk) is called on the pending child sockets.

Avoid lockdep warning by using lock_sock_nested() in iucv_sock_close().
Split off __iucv_sock_close(), so iucv_sock_cleanup_listen() can call it
without nesting.

This is a missing lockdep annotation - not a real deadlock.

Example warning:
[ 6690.906930] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 6690.906935] WARNING: possible recursive locking detected
[ 6690.906942] 7.3.0-rc1net_KCSAN_KASAN-00240-g641d03105cc0 #23 Not taint=
ed
[ 6690.906948] --------------------------------------------
[ 6690.906953] afiucv_test_loc/5183 is trying to acquire lock:
[ 6690.906959] 000601ad13f20a78 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv_acce=
pt_dequeue+0xdc/0x340 [af_iucv]
[ 6690.906984]
               but task is already holding lock:
[ 6690.906989] 000601ad1c115278 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv_sock=
_close+0x82/0x7d0 [af_iucv]
[ 6690.907006]
               other info that might help us debug this:
[ 6690.907010]  Possible unsafe locking scenario:

[ 6690.907014]        CPU0
[ 6690.907018]        ----
[ 6690.907021]   lock(sk_lock-IUCV);
[ 6690.907028]   lock(sk_lock-IUCV);
[ 6690.907034]
                *** DEADLOCK ***

[ 6690.907038]  May be due to missing lock nesting notation

[ 6690.907043] locks held by afiucv_test_loc/5183: 2, last CPU#0:
[ 6690.907085]  #0: 000601ad137a5550 (&sb->s_type->i_mutex_key#12){+.+.}-=
{3:3}, at: __sock_release+0x7e/0x230
[ 6690.907109]  #1: 000601ad1c115278 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv=
_sock_close+0x82/0x7d0 [af_iucv]
[ 6690.907127]
               stack backtrace:
[ 6690.907135] CPU: 0 UID: 0 PID: 5183 Comm: afiucv_test_loc Kdump: loade=
d Not tainted 7.3.0-rc1net_KCSAN_KASAN-00240-g641d03105cc0 #23 PREEMPT
[ 6690.907140] Hardware name: IBM 8561 T01 703 (z/VM 7.4.0)
[ 6690.907142] Call Trace:
[ 6690.907144]  [<00061ab555fd6208>] dump_stack_lvl+0xe8/0x140
[ 6690.907151]  [<00061ab55623a110>] print_deadlock_bug+0x340/0x350
[ 6690.907156]  [<00061ab55623f768>] __lock_acquire+0x11b8/0x15d0
[ 6690.907159]  [<00061ab55623fc9c>] lock_acquire.part.0+0x11c/0x290
[ 6690.907162]  [<00061ab55623fec4>] lock_acquire+0xb4/0x1e0
[ 6690.907164]  [<00061ab5580d6b96>] lock_sock_nested+0x46/0xf0
[ 6690.907167]  [<00061ab4d66e38dc>] iucv_accept_dequeue+0xdc/0x340 [af_i=
ucv]
[ 6690.907171]  [<00061ab4d66e541c>] iucv_sock_close+0xdc/0x7d0 [af_iucv]
[ 6690.907174]  [<00061ab4d66e5b62>] iucv_sock_release+0x52/0x130 [af_iuc=
v]
[ 6690.907177]  [<00061ab5580c5b24>] __sock_release+0xa4/0x230
[ 6690.907180]  [<00061ab5580c5cdc>] sock_close+0x2c/0x40
[ 6690.907183]  [<00061ab556ac7a00>] __fput+0x2f0/0x880
[ 6690.907187]  [<00061ab556ac8cc0>] fput_close_sync+0xd0/0x1c0
[ 6690.907189]  [<00061ab556abbc70>] __s390x_sys_close+0x90/0xf0
[ 6690.907192]  [<00061ab55894df0e>] __do_syscall+0x1be/0x5a0
[ 6690.907196]  [<00061ab558976a7a>] system_call+0x72/0x90
[ 6690.907200] INFO: lockdep is turned off.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/iucv/af_iucv.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index db261ecd19af..dc906f5f7c42 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -91,6 +91,7 @@ static struct sock *iucv_accept_dequeue(struct sock *pa=
rent,
 					struct socket *newsock);
 static void iucv_sock_kill(struct sock *sk);
 static void iucv_sock_close(struct sock *sk);
+static void __iucv_sock_close(struct sock *sk);
=20
 static void afiucv_hs_callback_txnotify(struct sock *sk, enum iucv_tx_no=
tify);
=20
@@ -302,7 +303,9 @@ static void iucv_sock_cleanup_listen(struct sock *par=
ent)
=20
 	/* Close non-accepted connections */
 	while ((sk =3D iucv_accept_dequeue(parent, NULL))) {
-		iucv_sock_close(sk);
+		lock_sock(sk);
+		__iucv_sock_close(sk);
+		release_sock(sk);
 		iucv_sock_kill(sk);
 	}
=20
@@ -394,15 +397,16 @@ static int iucv_send_ctrl(struct sock *sk, u8 flags=
)
 	return err;
 }
=20
-/* Close an IUCV socket */
-static void iucv_sock_close(struct sock *sk)
+/**
+ * __iucv_sock_close() - close socket, caller holds lock_sock(sk)
+ * @sk: network socket
+ */
+static void __iucv_sock_close(struct sock *sk)
 {
 	struct iucv_sock *iucv =3D iucv_sk(sk);
 	unsigned long timeo;
 	int err =3D 0;
=20
-	lock_sock(sk);
-
 	switch (sk->sk_state) {
 	case IUCV_LISTEN:
 		iucv_sock_cleanup_listen(sk);
@@ -454,7 +458,12 @@ static void iucv_sock_close(struct sock *sk)
=20
 	/* mark socket for deletion by iucv_sock_kill() */
 	sock_set_flag(sk, SOCK_ZAPPED);
+}
=20
+static void iucv_sock_close(struct sock *sk)
+{
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	__iucv_sock_close(sk);
 	release_sock(sk);
 }
=20
--=20
2.53.0

