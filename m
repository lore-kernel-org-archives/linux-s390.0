Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09C12B60;
	Wed, 14 Feb 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900445; cv=none; b=NhLQ4Uckq7tCbUNtGscQXA3uBDnqYIGvJtV7Wb7ANAli8aVVojn54eDSN5UKrzln+W9jAbWzPRpWExiQ2ydWFUQWRcG4Y+RHCQ9vJaOTQA3BzfE+UIlvENEH0dbfDylpqbarVsOVpkqAuqB47rP3FDXUapkMykCcpgWHPMVgU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900445; c=relaxed/simple;
	bh=jKZ1qdvxo5B5C/PGd2hoHurAdfual4D3xaJec0APJLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCZ0cuy6ECep4JBVGkTHJo3p6uV1CgyM7zYLFo9sKb3UNDw9tZFNhSpNuRTBCjjUyHMEt9NQhq1zh1dwLK7DqB5jkRKivIvZMgsgl+4wyjnCPRWNBTk1OwsDpJ3Z1MBMkz4vu5Pogzjiyj0Q/nw6zhZ/DM7QUKI0+zfXj7QRE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rXkDYdSj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rXkDYdSj"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E81H2i014977;
	Wed, 14 Feb 2024 08:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NbGy7bXJkCDs8pudWJIrjgwCKBFrcoqliAuXZRqGp9A=;
 b=rXkDYdSj9M5Kcuw1YOR2cy0to1qymdCpqUdp3q7LSZCJ4RJICTIRp1x+VxvNt0tsTUDd
 By4/KXUBqmW68hLIYmnkuy2WZ6uw9dWTax48nHMEO8/bhuTa8lT6ecjE0oiOs5bY81Ub
 VdHRNIBqRWhAns9MgLncWBK1OPPK9V48tgFCe22af7UGtZoRp0xePQb1AULCKcmIys70
 wwUKmt8nYJdb/cS6xJ9OHeMtbNon7BeKHq3TlNqETKv6yQZFFm8vPPd8reRA9sHW+s01
 BoCxluPO4gABuvPaKMxR0wHqIiMg6+GGeEFkyttNsRYiQufDloc78ETVJD4eQ0L4RMhO Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8s4usksy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:47:19 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41E8kUPs001762;
	Wed, 14 Feb 2024 08:47:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8s4usksg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:47:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41E67kOw032596;
	Wed, 14 Feb 2024 08:47:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftn2ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:47:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41E8lCjP21234404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 08:47:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 551A02004D;
	Wed, 14 Feb 2024 08:47:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 445F72004B;
	Wed, 14 Feb 2024 08:47:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Feb 2024 08:47:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 17091E034A; Wed, 14 Feb 2024 09:47:12 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next] net/iucv: fix virtual vs physical address confusion
Date: Wed, 14 Feb 2024 09:47:07 +0100
Message-Id: <20240214084707.2075331-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Tx-PHddtH9iJzvsaw2FeGqLhlKGG7XQ
X-Proofpoint-ORIG-GUID: YlkmprJU6KmAoox4hKpj5RO4D0itNggb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402140067

From: Alexander Gordeev <agordeev@linux.ibm.com>

Fix virtual vs physical address confusion. This does not fix a bug
since virtual and physical address spaces are currently the same.

Acked-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 net/iucv/iucv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 6334f64f04d5..9e62783e6acb 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -286,6 +286,7 @@ static union iucv_param *iucv_param_irq[NR_CPUS];
  */
 static inline int __iucv_call_b2f0(int command, union iucv_param *parm)
 {
+	unsigned long reg1 = virt_to_phys(parm);
 	int cc;
 
 	asm volatile(
@@ -296,7 +297,7 @@ static inline int __iucv_call_b2f0(int command, union iucv_param *parm)
 		"	srl	%[cc],28\n"
 		: [cc] "=&d" (cc), "+m" (*parm)
 		: [reg0] "d" ((unsigned long)command),
-		  [reg1] "d" ((unsigned long)parm)
+		  [reg1] "d" (reg1)
 		: "cc", "0", "1");
 	return cc;
 }
@@ -1123,7 +1124,7 @@ int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
-	parm->db.ipbfadr1 = (u32)(addr_t) buffer;
+	parm->db.ipbfadr1 = (u32)virt_to_phys(buffer);
 	parm->db.ipbfln1f = (u32) size;
 	parm->db.ipmsgid = msg->id;
 	parm->db.ippathid = path->pathid;
@@ -1241,7 +1242,7 @@ int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
 		parm->dpl.iptrgcls = msg->class;
 		memcpy(parm->dpl.iprmmsg, reply, min_t(size_t, size, 8));
 	} else {
-		parm->db.ipbfadr1 = (u32)(addr_t) reply;
+		parm->db.ipbfadr1 = (u32)virt_to_phys(reply);
 		parm->db.ipbfln1f = (u32) size;
 		parm->db.ippathid = path->pathid;
 		parm->db.ipflags1 = flags;
@@ -1293,7 +1294,7 @@ int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		parm->dpl.ipmsgtag = msg->tag;
 		memcpy(parm->dpl.iprmmsg, buffer, 8);
 	} else {
-		parm->db.ipbfadr1 = (u32)(addr_t) buffer;
+		parm->db.ipbfadr1 = (u32)virt_to_phys(buffer);
 		parm->db.ipbfln1f = (u32) size;
 		parm->db.ippathid = path->pathid;
 		parm->db.ipflags1 = flags | IUCV_IPNORPY;
@@ -1378,7 +1379,7 @@ int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 		parm->dpl.iptrgcls = msg->class;
 		parm->dpl.ipsrccls = srccls;
 		parm->dpl.ipmsgtag = msg->tag;
-		parm->dpl.ipbfadr2 = (u32)(addr_t) answer;
+		parm->dpl.ipbfadr2 = (u32)virt_to_phys(answer);
 		parm->dpl.ipbfln2f = (u32) asize;
 		memcpy(parm->dpl.iprmmsg, buffer, 8);
 	} else {
@@ -1387,9 +1388,9 @@ int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 		parm->db.iptrgcls = msg->class;
 		parm->db.ipsrccls = srccls;
 		parm->db.ipmsgtag = msg->tag;
-		parm->db.ipbfadr1 = (u32)(addr_t) buffer;
+		parm->db.ipbfadr1 = (u32)virt_to_phys(buffer);
 		parm->db.ipbfln1f = (u32) size;
-		parm->db.ipbfadr2 = (u32)(addr_t) answer;
+		parm->db.ipbfadr2 = (u32)virt_to_phys(answer);
 		parm->db.ipbfln2f = (u32) asize;
 	}
 	rc = iucv_call_b2f0(IUCV_SEND, parm);
-- 
2.40.1

