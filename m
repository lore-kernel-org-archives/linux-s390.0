Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58414D2BB
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501821; cv=none; b=oMNiOAzwCdzmT3VmTDj+Dh6hSJomwb6D4CRElPpPInPS6MpVZO1Tz6pMII+kIOCLC6wFeqGW68Dm2Bx99CL3cOxxclKC6ooSTtz198qyEORZktpvviMcS2Xa0GpPOkKIOLvrWDpVdSbcnc9rYm4ejf3XPI+uxkQIuSrGQtIQLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501821; c=relaxed/simple;
	bh=8rfBBYkHNokVj/xK9ivaMyK7E74ZqLioQl3hkn0OiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOjxcZr7ftmTuxEvvJQKRIPGVlRr/fq47EMuHGnwaqhPLcFrdupr5eX2DtxF4tDa5ic8cxR5A7JEHY/832t9G/Gg6iQEitMQGKm20l43HSDYc+x9vkvp8lTd4q6Nwoz6Kj847/6ukqAEMM9ltJP5nXe25REQ5I7b63bIizPvsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tCCqJIBp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tCCqJIBp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAxVIS029599;
	Thu, 24 Apr 2025 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Pnqykevt5QImhrz15
	Si7G8fAU0OQyDXUcA/Xg79yi2k=; b=tCCqJIBpvpgcNu1uf6cozs49fgT30TEQo
	I/NOa1NxS4C0tcFbycVOAd8P9MnsQ3GjMQEJmYSJ1UTmQQSgZEKSskm9TTcaqzQz
	p9WnaA8ciS6Kuf1ty0AEk61z2UNJjVeaYQMaG1pOQ5mWmJ33cyNk6grnEVdDbiw0
	WSqPLB240wNe5QsbJVf/aSVhL5/cvodsj5YLRnJCHfDZtZLZgo2exKr8iSPl8vX7
	kj+swVmAlNZLSkCl2fWQBFIb66S9gY2q+/U3ZKq4IacO19OcMB96f261RyjmYN1Y
	WlppIwHBmdNceQNEcSLCmGIDUN98TFyExlc/FhzHkt0DkNgVy5ilA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aabu97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBS1W6001344;
	Thu, 24 Apr 2025 13:36:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy0cum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaMC229884798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B59B20040;
	Thu, 24 Apr 2025 13:36:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD42920043;
	Thu, 24 Apr 2025 13:36:21 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:21 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 04/25] s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
Date: Thu, 24 Apr 2025 15:35:58 +0200
Message-ID: <20250424133619.16495-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX9d3DlZuBT5UT DQnMEhciOxZf4Z26LGhzMU0DGJHSaFJAGUb2N4zDWbg3IR8PWZYIr3vMQcG1cv54pVC6FodImkt 12xj+8wBj9oT8i2bfixAlZqTYuzU9/38HZoBqwhrtwO5l+zLCChR0oFUtd3M3NYZw0RcxHQPk6B
 /ozwfJfCekyMTc+j2z6fb6pxkW7H7vqB+uOVQww8ZJRS8xUuIfRsem1nrRIBlzC0ISfgtcvODe3 2uWC5eETD3JAodvXxLt0M8Qfa7pEtKrFp85HBXEOBHhOEgr/qz5IOsDWlKIBwf1TynDLkmsCI4K chTrpjUygqq5NiQDtE7+tDNn8SL/kdii9SN5ywrNOdNvduEWwdViDivaB+Lfuc/Y7VuKQAASCTt
 ZgtHJ0PqJMeNtitmp+m48oYXau+2jR9tvzRSUZZT7DTAbjFdIaXz91WtbleOnMT/FaiWhaxJ
X-Proofpoint-ORIG-GUID: mSUNtBP268tAlEE11Y7t4hB_2K2odvsx
X-Proofpoint-GUID: mSUNtBP268tAlEE11Y7t4hB_2K2odvsx
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a3e79 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=hVqa_wrnkZ1V3SoaiB8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

If there is a target list of APQNs given when an CPRB is
to be send via zcrypt_send_ep11_cprb() there is always a
kmalloc() done and the targets are copied via z_copy_from_user.

As there are callers from kernel space (zcrypt_ep11misc.c)
which signal this via the userspace parameter improve this
code to directly use the given target list in case of
kernelspace thus removing the unnecessary memory alloc
and mem copy.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c | 42 +++++++++++++++-----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 139bf2b13544..b299cdb73826 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1035,7 +1035,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 {
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
-	struct ep11_target_dev *targets;
+	struct ep11_target_dev *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
 	unsigned int func_code = 0, domain;
@@ -1052,29 +1052,25 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	target_num = (unsigned short)xcrb->targets_num;
 
 	/* empty list indicates autoselect (all available targets) */
-	targets = NULL;
+	rc = -ENOMEM;
 	if (target_num != 0) {
-		struct ep11_target_dev __user *uptr;
-
-		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
-		if (!targets) {
-			func_code = 0;
-			rc = -ENOMEM;
-			goto out;
-		}
-
-		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
-		if (z_copy_from_user(userspace, targets, uptr,
-				     target_num * sizeof(*targets))) {
-			func_code = 0;
-			rc = -EFAULT;
-			goto out_free;
+		if (userspace) {
+			targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
+			if (!targets)
+				goto out;
+			if (copy_from_user(targets, xcrb->targets,
+					   target_num * sizeof(*targets))) {
+				rc = -EFAULT;
+				goto out;
+			}
+		} else {
+			targets = (struct ep11_target_dev __force __kernel *)xcrb->targets;
 		}
 	}
 
 	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
-		goto out_free;
+		goto out;
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
@@ -1082,11 +1078,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
-				goto out_free;
+				goto out;
 			}
 		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) == 0) {
 			rc = -EOPNOTSUPP;
-			goto out_free;
+			goto out;
 		}
 	}
 
@@ -1154,7 +1150,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 			pr_debug("no match for address ff.ffff => ENODEV\n");
 		}
 		rc = -ENODEV;
-		goto out_free;
+		goto out;
 	}
 
 	qid = pref_zq->queue->qid;
@@ -1168,9 +1164,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, wgt);
 	spin_unlock(&zcrypt_list_lock);
 
-out_free:
-	kfree(targets);
 out:
+	if (userspace)
+		kfree(targets);
 	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
-- 
2.43.0

