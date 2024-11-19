Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC041C1F2A;
	Tue, 19 Nov 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029755; cv=none; b=dOyaW19p7naJR7V+CdYXOTMmMKeYkr8UKk3lsMPyMKmIPJZiAf1uxEGfA/aGy62iW2Ko8wwEHv1arGVS9kHGrVYgszfpr3s8xqjHulS0eNxAJRmbKlMEGEeKkkhmfz+vKXqRBjSexzZUASB3hexguH5eqeWwMFBJ2/FreiDe6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029755; c=relaxed/simple;
	bh=7QIX0twdwAYbIvKadLXm2LlFG56fSbGo387f1nbfzxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRQdv7EPZQh24mZdPlvJOv64z4moS2OgOegxJZWm+V4plE46lC4FqPw2p/+xoD1kw3SBJSMs8m5XCC9fLsqi5Fnb/tpfl13EEOBrM+5KoeQT1P5XifskuIpClHAoSrDXHqcLfGu7r/rOwogfUt/hkRR+T6xtQuSoWNkTcWnXiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VX/XFnFC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VX/XFnFC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ8l73U002974;
	Tue, 19 Nov 2024 15:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Lrcxi1ccJ6p9bcF2TctZ750c/OL5d7g4GyxSqiER3
	a4=; b=VX/XFnFCMOlZXKNlu2jh7cjF/5GZe2WOXKJuZnOVUXNaM/8z7BqP/ldYO
	v8ykjYrR2i/jzEHNYlBcHEbGU7RGYeOZEvmJmbFk/LIh/vPgqsv5ZAVT5Y0A/Kd0
	akbNIGEnv+f0TeeYZKpY9toNKP/rFJXq5qAzF+rEFo8q1RHGrZ401mrM5SM/CjPZ
	Ur6Xh66uGWtzPk0HEePuI/lCtzAVreDEOJTSgmxuUfVxLFHeJ9d/qFm/o2zDST9x
	EZpkx9xRGw05kRDgGjkLo6OFYxpyEJ1E/KgusjTkpRbM0U+hSBAJSloGwZqai8om
	LwQJGLZao1eKqGY0fvyAQDXIOPcZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2w0tjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:22:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AJF5XD4007827;
	Tue, 19 Nov 2024 15:22:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk2w0tjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:22:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJET1k8030931;
	Tue, 19 Nov 2024 15:22:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63ygy1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:22:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AJFMKbk33948352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 15:22:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 902132004B;
	Tue, 19 Nov 2024 15:22:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C36320043;
	Tue, 19 Nov 2024 15:22:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:22:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id F3B6EE1312; Tue, 19 Nov 2024 16:22:19 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Sidraya Jayagond <sidraya@linux.ibm.com>
Subject: [PATCH net] s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()
Date: Tue, 19 Nov 2024 16:22:19 +0100
Message-ID: <20241119152219.3712168-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LeuXr6h3aObsWFt3A9sfPIu46QyWRynC
X-Proofpoint-GUID: n6GnXYtes0zrMQBNLVo_dN7ZRPGQKYQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=834 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190110

From: Sidraya Jayagond <sidraya@linux.ibm.com>

Passing MSG_PEEK flag to skb_recv_datagram() increments skb refcount
(skb->users) and iucv_sock_recvmsg() does not decrement skb refcount
at exit.
This results in skb memory leak in skb_queue_purge() and WARN_ON in
iucv_sock_destruct() during socket close. To fix this decrease
skb refcount by one if MSG_PEEK is set in order to prevent memory
leak and WARN_ON.

WARNING: CPU: 2 PID: 6292 at net/iucv/af_iucv.c:286 iucv_sock_destruct+0x144/0x1a0 [af_iucv]
CPU: 2 PID: 6292 Comm: afiucv_test_msg Kdump: loaded Tainted: G        W          6.10.0-rc7 #1
Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
Call Trace:
        [<001587c682c4aa98>] iucv_sock_destruct+0x148/0x1a0 [af_iucv]
        [<001587c682c4a9d0>] iucv_sock_destruct+0x80/0x1a0 [af_iucv]
        [<001587c704117a32>] __sk_destruct+0x52/0x550
        [<001587c704104a54>] __sock_release+0xa4/0x230
        [<001587c704104c0c>] sock_close+0x2c/0x40
        [<001587c702c5f5a8>] __fput+0x2e8/0x970
        [<001587c7024148c4>] task_work_run+0x1c4/0x2c0
        [<001587c7023b0716>] do_exit+0x996/0x1050
        [<001587c7023b13aa>] do_group_exit+0x13a/0x360
        [<001587c7023b1626>] __s390x_sys_exit_group+0x56/0x60
        [<001587c7022bccca>] do_syscall+0x27a/0x380
        [<001587c7049a6a0c>] __do_syscall+0x9c/0x160
        [<001587c7049ce8a8>] system_call+0x70/0x98
        Last Breaking-Event-Address:
        [<001587c682c4a9d4>] iucv_sock_destruct+0x84/0x1a0 [af_iucv]

Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
The following mailaddresses are no longer active:
Frank Pavlic <fpavlic@de.ibm.com> (blamed_fixes:1/1=100%)
Martin Schwidefsky <schwidefsky@de.ibm.com> (blamed_fixes:1/1=100%)
---
 net/iucv/af_iucv.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index c00323fa9eb6..7929df08d4e0 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1236,7 +1236,9 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		return -EOPNOTSUPP;
 
 	/* receive/dequeue next skb:
-	 * the function understands MSG_PEEK and, thus, does not dequeue skb */
+	 * the function understands MSG_PEEK and, thus, does not dequeue skb
+	 * only refcount is increased.
+	 */
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
@@ -1252,9 +1254,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	cskb = skb;
 	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
-		if (!(flags & MSG_PEEK))
-			skb_queue_head(&sk->sk_receive_queue, skb);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_out;
 	}
 
 	/* SOCK_SEQPACKET: set MSG_TRUNC if recv buf size is too small */
@@ -1271,11 +1272,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	err = put_cmsg(msg, SOL_IUCV, SCM_IUCV_TRGCLS,
 		       sizeof(IUCV_SKB_CB(skb)->class),
 		       (void *)&IUCV_SKB_CB(skb)->class);
-	if (err) {
-		if (!(flags & MSG_PEEK))
-			skb_queue_head(&sk->sk_receive_queue, skb);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
 	/* Mark read part of skb as used */
 	if (!(flags & MSG_PEEK)) {
@@ -1331,8 +1329,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	/* SOCK_SEQPACKET: return real length if MSG_TRUNC is set */
 	if (sk->sk_type == SOCK_SEQPACKET && (flags & MSG_TRUNC))
 		copied = rlen;
+	if (flags & MSG_PEEK)
+		skb_unref(skb);
 
 	return copied;
+
+err_out:
+	if (!(flags & MSG_PEEK))
+		skb_queue_head(&sk->sk_receive_queue, skb);
+	else
+		skb_unref(skb);
+
+	return err;
 }
 
 static inline __poll_t iucv_accept_poll(struct sock *parent)
-- 
2.45.2

