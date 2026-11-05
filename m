Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893037;
	b=v+P3/eQLqHBxikhsYp9a49k+ruIu8Q5BOWIIyP45YnHP1KNvZbvpGiZxh9y4dohpDuxy
	 vJHd5KIg8q8VvAi+YvrRHk37dNCZegW9LDCur7dbP7wA80xrBQ7Ey7y+exYOE5Wxb6hHr
	 Hr5FavKb/+F4a8IhxPwg0jIxH7/69H42qSJaWgHylTDmXdKJxQoKcraiDyaiePCUDVssR
	 5Ktqfy14Dcp68pe6ioEWMy0simNhIhWqIUWN6S1Cp1D5rvuzkJ1JikFeaK+08GO2zZhc+
	 WpmYkJMToryCis6yoGvVGCo9wTTtueEUqNuTHhl73ZUGAqQoJT7qaukdq81IwwIStJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=highI4sLWoD+sNPWN8VCSeUaWPHdP0mFuKg5IS/MbTc=;
	b=EhxGvizD0HTqANMl8RF/fJ2D8e3377K/AFFl1XO2kS24YpvFcXYK7xIPg4BkYIbiOsIR
	 WwijakXEdgjCUcw96hIc5U/qkNplb2Gs8xy8dKgxhqouDmMpBsgtK480A82NNtKG8XMAN
	 gQ29I/PrrCZPgC9/4X+akrGKBGKWeKTkuPYTSdJWmgyxEGjRB+huoZJnmtEKNpTmt6BmY
	 /46BM/1jIXlfgnEdU4kNOgXnZK6RM04OjZ1D+T+kBHCIn5q2ZXOqnxAyQjyuofxPQixzH
	 vmU1Lf3i1gEfjJENRsixiM28v6vAISfLWmOj9+cOE0Mah1TkcbhYf40GIvau+9OAbiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SSI2lT8g;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826B606A33E;
	Thu,  5 Nov 2026 15:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8826B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SSI2lT8g
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiTmh3735418;
	Thu, 5 Nov 2026 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=highI4sLWoD+sNPWN
	8VCSeUaWPHdP0mFuKg5IS/MbTc=; b=SSI2lT8g1PiNUv51fikveqQOTucuZWEL3
	hZmDlTl5JaUpD+E+/wiTsmRAeq5bRIc9owIvrVcHdPLG068O4A4/SS2vmVPjonYa
	VfjIxk3wsIRFJjTJwzV9m/+n4GQH2DCovGrFkkX+Vh1RL0QcULEmiTihK51A/Jhc
	PmkQt8JwdL/PPO3hS+PodcRkiDfZZ+jDBNPB8lrmy2e3VgVZhnPn+0RkzlmYR6jy
	5td5dX6AJPYEZziUKy/arXIbZNsURb4I7f1/6HA5aOA5apEhcPPdgsSppI8WK2ko
	WV5loMSbdSRmioaMRCnNH8hwdVA2KIW+RnweCfe+CPWYOO737wNVQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj30gr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYuvh1746147;
	Thu, 5 Nov 2026 15:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mjryb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Fb6m830999202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:37:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0F720043;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B1362004D;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v6 2/5] KVM: s390: Move some skey functions to headers
Date: Thu,  5 Nov 2026 16:37:02 +0100
Message-ID: <20261105153705.208516-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105153705.208516-1-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XnfTSKzjJ5krnf0OYmplvfaP-Ial4NAT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX0o+6BEhEf3+D
 T4JnsvFfYydYlnu5V7B28iqnhB0Ga9r3hNMELj/4vI5dHBj0oefly9zPIWCujYfIxjouYlxjRhT
 sOn+RcbWNIwm3pKAwhrUnCGm1ybHMvU=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeca2a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HEUQaSvOCpYZseJEH4QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX9d5MX4q2EY/g
 n0mQQT4ddEary1JLBiPxc3Y8L+FX/ZZrS89bVG4IsNlYRbOlKr/4GL+DPQAXo4+/XStZZ8qJm24
 pGdNUcjffipSixN5MioSDu674uLNucs1FBwkT+vXAoez02Kfya6zfibDDtQYTO1/l3rEl8uEn/p
 G3zYmT0uQhGlFs09mlo2yLU6UntLGvsqbjKYlYwJml3lTbcLjfsy1UHxaj7OK2IP5X4eYVUGna9
 w9o3Mam5OEBB9tulHbwnt1FhmeuTTe+JAOB2Fn5+DH1o4NifJfa0Zx2/mzcHRMJAxT1LJJmqC9l
 9TR6I3SiCSHz/f5rgQYtoRkGfeEw4wsuomDjPW7SjipOFxB0y4QOdqMM87HtNAWx9vCNLYE/Z46
 1AQPuhONQwb/4qJo2PL2MOScelXbnRN0PMrEIknQUVY5ebKoHq+jzrnaki/teB8DvAyRJ3BcD1v
 BYAaPYg6sisyC/vLe1w==
X-Proofpoint-GUID: XnfTSKzjJ5krnf0OYmplvfaP-Ial4NAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050060

Move some storage key handling functions to headers, since they will be
needed from outside, and they are small, so inlining is acceptable.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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
index e6215c0b571f..9cdd1f122d7a 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -1008,4 +1008,30 @@ static inline bool crste_is_ucas(union crste crste)
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

