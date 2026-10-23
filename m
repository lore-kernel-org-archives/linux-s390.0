Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770942;
	b=0tQnmZIY7aBgwwgWV91poVQFKmYcG8SzDsN9s1bBctv2mFSktdBzq+5PEnj95KF38w+O
	 VGjGexpUZhnH9cKXhIT7IYNhxr0iDyX/e+8d6n0FS1rbp93izXjtX6HZMkXvrjyJMP7cn
	 Y54qq9jZZqT6HDE1CjHArKT8dridADFH4rqK5BWeuoyC7hlF2wHPgOWo9DZ5rCYWYRSuN
	 N4Mx8SN1U4ynQ1z16Uomp3WgYx4YQHK21MmXA1n2Fn+6oaykLzYRv30KVrmZxxdqnnSyS
	 MsohZ3kD3Tvu40cOpfWAc3rN+zKHxmiMJAvQ2aLDSU/VPKAnvnocVr+JwXLSqQFTK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770942;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GzDT0H9gqpV+k6XBmpb1Gc2FAVECsDExjYUaF6UfxRA=;
	b=CVwg0pYbfV3OpA7V9LwvJsbSO3SlxqSNjJkt1qTj7rY+ubIZ20HqYjkH+hjrsti3WHoI
	 jl32mW+6b6tUJaub4CEU/XOzzlseNZ9CJk4UH9IbAA9Y/V3YzMA1T8PR52q6nSOUgVIfm
	 D3eTDAUDc6zwQ41O/hzEyeASxxk/dvwn5kBxm1NVn2szWyki4tdkJ3gPOwvqKJqUywQIU
	 Tznaq9i6nPqWOxXXCAnwjEDSm+9BbtpYdx4KduCCYddZ9yn5LRXshBHJ/69LKD9jkdOb3
	 ijs/G0G4UYK4u1xd1roZFICEJqdwKOnO4bXCaVU/HbPWZ2Zt0QlyoKincK5l3+2gSXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iV3dH+k0;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E6606A31E;
	Fri, 23 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iV3dH+k0
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEOkU3183816;
	Fri, 23 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GzDT0H9gqpV+k6XBm
	pb1Gc2FAVECsDExjYUaF6UfxRA=; b=iV3dH+k06zUY1nEsLJjwwoAqjU+kNXq7G
	LmTLFHWZnzwT8OfCG4cVh94BEnGNGiWn+bHWwadHyvPYgVYkWmvshxPZk1gfT/Sw
	fa/tZazzjuDrJF8CFzqjON9xrw3O6cXMizQqMgEIfKstVRQwkIFTeevMeCeWiRni
	66TUcMRmZLztmHuTNK73DGW5CNsuwpDDf4qma4pTfv9AoBCUv1qCVolgk9r8K1XU
	2yjSQJ/BiaJA5OZTLgoTfxx9a4dRW5HxC/5hJ5cq6ORt7cWRWZlkTh/Yh731w6oM
	nvV+PegDrggUixY5ScIH1O6MvD/QudYvWCHcOQ1IUJzp5CanCjnIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5adeju-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE67DX2263050;
	Fri, 23 Oct 2026 15:55:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck67dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtW3N31851206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C11720040;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4A82004B;
	Fri, 23 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 01/10] KVM: s390: Move some skey functions to headers
Date: Fri, 23 Oct 2026 17:55:22 +0200
Message-ID: <20261023155531.206113-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX7yoXN4UBvVee
 oYuyaDlzwzRXUOumItAVelJ3U5yEemgJWKo+QZXKjs3tv0PIOiuOjoNdaKlXSfSuw65fPEDalg+
 kvg/2eX6hyYJoIaZCfZ2fBGmoBb+5XAHrzIs++Ho5glbwGDLuMw5/OSa7lu9KGU7XTmsfvTlJva
 1NEVV5oKYtoGw43H8RQYyAgidZJr6/b7xMHgPsrR8QksZXkqwWBo5Eobcb2QTstZzqN45I7dSf8
 4I80Qv5ZMB4GyBvqjDYKoo6GYuS7xZHVuYw1Jn2ed/WtwEr7OcpQSsP9jMbqh5/qymkuxx+WTVe
 TfJBpvAGBcG8RkZxhSkO8fC0Jh5J8jQ7PDvZ+JEWIw0LOAeI+z4uEz/6wDahqfn+DL5CqPBHh6Z
 62ajHnQItNV8jqpFaUyuBn7O8B3bDc5zUWroY6sxkb7BdUJPAZPS9rTsDzr25g3RxEoGeO/pAp/
 Hk3lqeCEE9QtlB+11wQ==
X-Proofpoint-ORIG-GUID: ahRE2k7pvAgBuIq7-6k4jWlrOSbfe-2X
X-Proofpoint-GUID: ahRE2k7pvAgBuIq7-6k4jWlrOSbfe-2X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX8pa7UTbDUCLa
 9Nd/Vh2NfjqucUPrlCFt9A09UxKfXXLH7xqb6ZBxT/UYoRlZgn8LymYbGWT2T1+IwcMA/ouppAG
 578/O3qkAi18KzAK6+UOavXVrmfQ9aE=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6adb837b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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
index 90389d47ba4e..3167543bf2cc 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -988,4 +988,30 @@ static inline bool crste_is_ucas(union crste crste)
 	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
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

