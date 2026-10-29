Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278856;
	b=ZoHSz/pjlPEIv5S3rmxxjpGd0EHCjVDB8VEL29QgW4QcNOlmfHgqclRGrfiK+SJGn/C8
	 pHMzh86C2zWws+2Kc7LjD466ie4S+SRptYSttGYDsLHrx8rSzpasW8SubK6ugwDQXNppB
	 k30Jiq+8iP/9ccJCuW+PR5hsIp9XJQUbj0q00+/1IuzqcGWnHmOm384VFmDjgY0+FubBx
	 NA5JfDHrddKesaPKqRP8worSSuZll7JtU4JwMnrXzSl1Q1u1y4IAfg+UKOJDYPPs5w06o
	 7dpuZHjXmS8hgBYuRvPogfnbxJzaivV4ZdqCyEWhS42l6+yJzH+ywVMaJ8i3lfS4/Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9YVBTzCoBmFYTK0l2/O6XJkdzc+P4h0u7drIqQo/0r0=;
	b=W+Ss/cMQeO9B/Mdb4kklvGWUgsUD97LcRX+XpCMitljkjLmnJn2Y6qRLOxraWEcAdaF7
	 bXePP01Y7VkrmkcMtGecQ/3rNNsOsS8eL52x7+2FXGPUrEz/RVhJW4RhCfs6PHM4e6x3P
	 SyBRVqZDbpp3NryaSXLbhcL73sfpDXq9rV9TsxPTWadqhPW4C+fqKfhZDKgQ3httZxMW8
	 B17I0B23r0BWxEJYoD/kUydkWNpr652CZ/nT4U1nHMSu6hDkkKeMo+8Kxn8pyjdSeVTD0
	 F9o5G88iye6/Widi+jZ9L5deHKQYqMo29lQW9srEZV+aSbYAYbtxTGby3F/tx2DbQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KfGP1Ghd;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3B606A32E;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F3B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KfGP1Ghd
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiCif4142730;
	Thu, 29 Oct 2026 13:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9YVBTzCoBmFYTK0l2
	/O6XJkdzc+P4h0u7drIqQo/0r0=; b=KfGP1Ghdwa3XeGDSkLY2HBoqvzKyK5CFF
	5LmhfeauB583+mr/+d4JvTl/4LncGr3vRORbOLVt++o2GzEGaX0owMPnyZnwbP2P
	PrDnLQPDBcxU0fvutOagRdlzoYVwMqo4yWM1CRedxbaTwxmuOgruEcYRBmAnbGEI
	8C4upE7gilcrciB7N4qD9MlZ3YemqJpj1RT0y+SAOmxR8Q3d1b9/0QxsDqKJRsx+
	HJsisVIbUGXpvn70mYDEjx28DXsz0hgOWDoA/eclUu39UEHGFRFs+UmiL43ed7nW
	EE1JZan/UYpJVb3Di9dsb1PLFahjFpupFVnVBZay1V3IU+dHQgvmA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mjcqy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9K4s92914955;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pewwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0jU344106084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B2CE20043;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A4D52004E;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 2/7] KVM: s390: Move some skey functions to headers
Date: Thu, 29 Oct 2026 14:00:39 +0100
Message-ID: <20261029130044.125032-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfXzJwYtnMlNFoG
 PuRcLRrbsHtYCBJM60lmCk1bQMDyVwWodsyP5KNqN0FP4Pz1HHNk2eoh0nIaeo4VodO2/MrufbB
 XOepArBvK6yHe3PriZZEahzbbBSRIe8=
X-Proofpoint-ORIG-GUID: V824Q12mSsj9iz6lHGgRM3sBrCVo9m67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX1gjZ/rriom6W
 5g2NScRdQrjffq787buydoD6dk1MNNq5Qm/npw0CCRaMSc61aC0sULot96fxYz7sSuh6UDLjSPW
 kQlfPgnFjBRrE+vQoLcCbBl0g8V97tRTA841oki813ECkDle+qmjAFhpDhmvXMFTs/GcDKI6ZIb
 8s2qUffIjZ/udq02RBIGjshivRZLTXIppUkquKDdRRq5q2BTj3k8WOJq83yxR1/VD8GFwFGLaMM
 Mebi1F+eBAJ4iYY8Y1uC2f7zBwAzZZrM6ANq1Lv3TkGJycueNMzf6GhUDeGbfOq8jWvPYNrbh3t
 ZtBYAGVZbaFbwCH6d8ZGnrsyPZq2CZNx7Rz0xn2C8T5EB4r6Pku8uZjgg2KVm1l9gZ2n4ecIv7a
 MwBUit50TsxVoLiMQjmNl1z+4cK/85abCIscLCSzN9pPAG4/AZjsdvMVH4xK2anVZ670Idoeovd
 XhrPWOQjnZNFpJrWBGw==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae34383 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-GUID: V824Q12mSsj9iz6lHGgRM3sBrCVo9m67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290049

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
---
 arch/s390/kvm/gmap/dat.c | 26 --------------------------
 arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f56..b9507daaf327 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -159,32 +159,6 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
 	return cspg_crste(crstep, old, new);
 }
 
-static void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
-{
-	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
-
-	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
-}
-
-static void dat_move_storage_key(union pte old, union pte new)
-{
-	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
-}
-
-static union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
-{
-	union skey skey;
-
-	skey.skey = page_get_storage_key(pte_origin(pte));
-
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gr |= skey.r;
-	pgste.gc |= skey.c;
-
-	return pgste;
-}
-
 union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
 			    union asce asce, bool uses_skeys)
 {
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 4665c1112bb9..687e1fa904d6 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -1002,4 +1002,30 @@ static inline bool crste_is_ucas(union crste crste)
 	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
+static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
+{
+	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
+
+	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
+}
+
+static inline void dat_move_storage_key(union pte old, union pte new)
+{
+	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
+}
+
+static inline union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
+{
+	union skey skey;
+
+	skey.skey = page_get_storage_key(pte_origin(pte));
+
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gr |= skey.r;
+	pgste.gc |= skey.c;
+
+	return pgste;
+}
+
 #endif /* ARCH_KVM_GMAP_DAT_H */
-- 
2.56.0

