Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684543;
	b=anSA0+YAZJWVgmxcN0ywyR6G3k5CJ9CehoLEt3/Hm1m99MtSjFGxdaYBXg3eDQGyqFpG
	 lfx6s04f6tBpyQhDaSCv/mzbdN/riZ2HQcTalA5BwM6hcNFcBGYqSH1jWLzDhXY3cTaD+
	 6oPdTHsfJXGShZ3ruRje/qn5j9+PsCNkCDkpcGKcnLU8s7RIB7aVqVMGo4vF7zzZnYWAm
	 KAMpDxgxaLSik/QxmxIeDqnvirLUbYU7BTmqwLvpUZXNOEawSUB7pCrS3yfP/dmxh9Qtw
	 su2fzaN37ILg6GSqN5ldKFvLQjdXEVig0ggRh6z2yE939nDqJs/e+iF/avp9ByU9qBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VVD0WDAeRb8rE7Y+PmF64AB2nDAGwsKbP8F5o0XoaO4=;
	b=qDUMaathzGTtLIBel3rzls+zhjA6aFGDUbzuai6qZ11Z5/z2tKnrQN7VXz7EB8R7XR+5
	 cZm4ZNjTDEuBVwPE9cT3Zf0/3x4NhOZru7Sqk/pGgbwC5hUp6R1NzjLRH2bQriI6U3T7X
	 miRUYF1VJK7GudKvC+t3nqfakUK19r1o9UVELgUcSL9LjzMQU9MAcex4NCeeGQazalGQn
	 xPhfv4OtKXQ/1TDIx/DV4cNxbaDGHhx/WeS4gq8+B6CiaCr5B/2um7yS4a//Xg0rixp0L
	 Hha1W8kbOatkmsqBrzCHYUHYJCtFCMKERww8VoYCkQNudhvrbS718X+UWLs7XHkLiDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7le3yfL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E6606A325;
	Thu, 22 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 414E6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7le3yfL
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEe142646088;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VVD0WDAeRb8rE7Y+P
	mF64AB2nDAGwsKbP8F5o0XoaO4=; b=M7le3yfLLZcK1M4lpP6TA1IWbRj61dHXV
	DOMPbrfB0996230yiBC9DLG2LhP8h7M+CsblvOiC6qNoQ8p7NYlhJSNz8TgQoU6Z
	v3QNqj0R1GaxhndBiOz0L2kol3apM075jFwVCf4OzbV4a395JYD0iLqS2XFs9ZgN
	VvwtR8/isNskhq3VMTI0k9FwcBDSxu/JVB5WHCIY5yOAZ2i0qwL3EjLVRRGAP4W9
	Tg66o8DyW3QNeUAIATRquuVJyYSI0RFqjnVyb8kP3ujalLkPRBKlJ1he4NUvzJsq
	WD/y0uqqTiHwZwaakuetJJyPG/O0ymNATDw+145KlFpCs1F/M1eaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5br3bq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJvi4662213;
	Thu, 22 Oct 2026 15:55:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck16nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtV1t50921868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B79F62004B;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971832004E;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 02/10] KVM: s390: Refactor and improve DAT tables handling
Date: Thu, 22 Oct 2026 17:55:23 +0200
Message-ID: <20261022155531.204593-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: eQFAkXd6Kn_cFQuSjnEcSV5F8bUQP96n
X-Proofpoint-ORIG-GUID: eQFAkXd6Kn_cFQuSjnEcSV5F8bUQP96n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX5JG8XA/hhrkt
 tW9tka5WHNZlNF7yzLlfNUtbb4gtFtWbKfY2iXU8XWxYH/rabid3PBVUZJ1JwtmSWmrOH61vEAW
 R9HHcVoMIGaIIc8Jziicjt2eJAgJIdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX//SpDQjbVKOQ
 hOMxqiEiGKpuD2rXY5wW7jn3G3vmoLxdizz7LvHB7mSZCotB4eogwhDt9i+ZFz/oEoNFRe6ROmU
 YoG7exJqpFLky9ATGopQ+9VmmsN2wBvKkiQGyhzPbq6/gKVdG7KCny27u6tFPckJlRH6qnPOYR/
 BbFwRpjmNu+NdiWeoSg5LkOALtlxsJgxHJD0m5/DUOD0Jpubmc4CXscuc1U95kOgXcP8Gsw/PGf
 f2O4mzwgix++A9wZFnpFGtImaEyjgM+U908eRxEpu474N8lnvp6uw9UxbADKql9lnWRPPBKxAFU
 ovW/QSR7yEeHxURXpj7I69eE57+ursr/MkVqV+wPOqWZsh0aEwo82q7T91tfDaNq25NPFj+oi+a
 /41nI7xHzYjQTO8WKj22Qql1Y2nvfEx3R7h0gExcZZh/tG7DAjKPyVOQW3d3AbCzxN9FBCSyCMV
 /4XofQcuzUYYHRE4A3A==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ipIrNKnqRxNbbhCid3UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220062

Refactor and improve functions to handle gmap DAT tables. Handle
machine_has_tlb_guest() inside the helper functions; the callers won't
have to worry about it anymore.

Add crdte_pte() to allow using CRDTE on ptes.

Fix idte_crste() to add the missing table-type bits.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.h | 51 ++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 3167543bf2cc..bf01af50e192 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -110,6 +110,9 @@ union pte {
 #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
 #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
 
+#define CRDTE_NODAT		IPTE_NODAT
+#define CRDTE_GUEST_ASCE	IPTE_GUEST_ASCE
+
 /* Soft dirty, needed as macro for atomic operations on ptes */
 #define _PAGE_SD 0x002
 
@@ -609,41 +612,65 @@ static inline bool crdte_crste(union crste *crstep, union crste old, union crste
 {
 	unsigned long dtt = 0x10 | new.h.tt << 2;
 	void *table = crste_table_start(crstep);
+	unsigned long addr = gfn_to_gpa(gfn);
+
+	addr |= machine_has_tlb_guest() ? CRDTE_GUEST_ASCE : 0;
+	return crdte(old.val, new.val, table, dtt, addr, asce.val);
+}
 
-	return crdte(old.val, new.val, table, dtt, gfn_to_gpa(gfn), asce.val);
+static inline bool crdte_pte(union pte *ptep, union pte old, union pte new, gfn_t gfn,
+			     union asce asce, bool nt)
+{
+	void *table = pte_table_start(ptep);
+	unsigned long addr = gfn_to_gpa(gfn);
+
+	if (machine_has_tlb_guest())
+		addr |= CRDTE_GUEST_ASCE | (nt ? CRDTE_NODAT : 0);
+	return crdte(old.val, new.val, table, 0, addr, asce.val);
 }
 
 /**
  * idte_crste() - invalidate a crste entry using idte
  * @crstep: pointer to the crste to be invalidated
  * @gfn: a gfn mapped by the crste
- * @opt: options for the idte instruction
  * @asce: the asce
- * @local: whether the operation is cpu-local
  */
-static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned long opt,
-				       union asce asce, int local)
+static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, union asce asce)
 {
 	unsigned long table_origin = __pa(crste_table_start(crstep));
 	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
 
-	if (__builtin_constant_p(opt) && opt == 0) {
+	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;
+
+	if (!machine_has_tlb_guest()) {
 		/* flush without guest asce */
-		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
+		asm volatile("idte	%[table_origin],0,%[gaddr]"
 			: "+m" (*crstep)
-			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
-			  [local] "i" (local)
+			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr)
 			: "cc");
 	} else {
 		/* flush with guest asce */
-		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
+		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt]"
 			: "+m" (*crstep)
-			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
-			  [asce] "a" (asce.val), [local] "i" (local)
+			: [table_origin] "a" (table_origin),
+			  [gaddr_opt] "a" (gaddr | IDTE_GUEST_ASCE),
+			  [asce] "a" (asce.val)
 			: "cc");
 	}
 }
 
+static __always_inline void ipte(gfn_t gfn, union pte *ptep, union asce asce, bool nt)
+{
+	unsigned long flags;
+
+	if (machine_has_tlb_guest()) {
+		flags = IPTE_GUEST_ASCE | (nt ? IPTE_NODAT : 0);
+		__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, flags, asce.val, IPTE_GLOBAL);
+	} else {
+		__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, 0, 0, IPTE_GLOBAL);
+	}
+}
+
 static inline void dat_init_pgstes(struct page_table *pt, unsigned long val)
 {
 	memset64((void *)pt->pgstes, val, PTRS_PER_PTE);
-- 
2.56.0

