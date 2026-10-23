Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770944;
	b=DpiboGBOQ6iz2psq1R2VShvy0HFoKXRJhHnv2tpnuaNdpRZYxxK6os7pgT33ktqf0wow
	 UdAP/Xl17dxC2GqHrGwzrRjqWQIRrdIc7q+Ugt2LydgM0DJ1qffOQ1ekdfs+IdT3lcF5s
	 I6d5v0/N14ts8HMmzFHiIpLHhhHpwrWy/4W08U704yimHcYDn5Umh+bknOxnubSFEt1x2
	 5Ms6yukYQj0866tUSwaCZ8JZjsDBIpM1RlmUCNJL/QExEQETaF16k9K3Y6IKzjawOJtiP
	 BaMfl4sCgNMkcBPQ9dAkoQVml5NW706keypnf6aQ6pfmfwuDH8qtBms+Im1ELIeJ+zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+5jmG+1aHIt443NNbkP2Cr8jEfH4s35viy7/cTOMzB4=;
	b=ljLhtZ9ldFUUXe4FX3fZhiHKAFkHLTFC2nv1qZlcsCjd2NoZ97Y9aKfj6lt7Cv67uSmL
	 Oe29QKlxRgEpi1YEUrVPP+87nsx3djjlVun34GA5EsaznY1KqoaY0WAc1Bga2BXJFCAak
	 9OTS7LPBMiCpbUID7ge18Yd20xSC5BphmnFrNGwRWkX77DUAJv2wROiJBhj0634TY5UCI
	 U0/wThb+uU0hSqx1sIZBeUSUOWkZB77UNHxBO2T/6pK+FDoesOrPiPEOLr3p+0HK7oxHo
	 sMBlSct8LvJBNoNLfC2uidAMhKL0sumH0sVzMib/vXgdzXrBeGTlPq6SZ/3SHxi1X8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xozom0pa;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F1606A333;
	Fri, 23 Oct 2026 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789F1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xozom0pa
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEeTY1519740;
	Fri, 23 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+5jmG+1aHIt443NNb
	kP2Cr8jEfH4s35viy7/cTOMzB4=; b=Xozom0pafmsfsfrWtOFFkNMwi1hQG3b8d
	Kr3JW8UHx8ZaANS4F98TeJ1Hu04VHQZ2a248l2x90y1pHsJx9uprHmT01G4JPTGC
	66zdfNPnEVKoFWjlvzuFeUH/NDHIT/cxF99Y38pbbiA1udzJQQClmJeXHwR1lHjC
	1/NZ2SFfMR+onTixfG+zHl1qg6J2bc/QmNpglSfunOsvfAEB1loSIRCxYINOF771
	IRtHluNxz9wMvYBYXrNqQD3/zFYA96knb0zrdrLfQuZQ+WzAl1MOcU/qUwWfR6uY
	5zeuyYQU+eLBPPIDoQntPZ9cFM+GHU/D+S/b1EpRpjI86o8bye8HA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bx8eu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEL4152203369;
	Fri, 23 Oct 2026 15:55:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgms3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtWsa31851208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4105320043;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E882004D;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 02/10] KVM: s390: Refactor and improve DAT tables handling
Date: Fri, 23 Oct 2026 17:55:23 +0200
Message-ID: <20261023155531.206113-3-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: WMZI7aHBqXiNkJKVTZMREjiKv26c9Wj3
X-Proofpoint-ORIG-GUID: WMZI7aHBqXiNkJKVTZMREjiKv26c9Wj3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfXwruivYfkKImh
 jbTLXmQwQOKJLUTiPT3otQh/TUAArZ+8tlcZprPCeO7XzTlV/rSNx9WQDw0So4b4rsuMuVJ7DdY
 vhBLG4Lt3Tnu/7x/9kmhareJm2QIDcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX3HX1psWAWVy9
 m5YQ47bzk72dCpuyemAA+4WrM0/JwlUsdn34fLsMEosvDl8JCoXPZV3k/RGWwqZYE/bgPFZ7mJz
 6M64TOIKWZJJ8am7blafXi7rNW+eHVoPQ+JLbyxoRioI/+LX4/T62xj4BHpMXBeklFJN6vpKNos
 bch3X+phyyixdYWhOxR/Q3hTfxDZ8yCPxm7b+FhGh92g67xhOTnWfrzFtlN3TUn8LbEYh9yeviB
 Z2zO7IlsVAipLm2gEoe2net4+P0ueL24gv8+GPJ8EstJNKLdlboPoEa0lQTaY9DQIa1h4vtSmXT
 VXBg7/uztTsKt73z6r5exKCaB3829DzzuxDmn2CBels/o26rc4Bk/9r9Nmg4JbzKX1b7yP4+h5l
 oZsmO2d+kobeC6DFVnBUoIAtcNgfIkZ7s9jSM2PuWSqo3FrNBciNDcF0x21tWd0ODXu2dP8JZPs
 OPLCS5B8bbkmFiESFFA==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb837b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ipIrNKnqRxNbbhCid3UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230061

Refactor and improve functions to handle gmap DAT tables. Handle
machine_has_tlb_guest() inside the helper functions; the callers won't
have to worry about it anymore.

Add crdte_pte() to allow using CRDTE on ptes.

Fix idte_crste() to add the missing table-type bits and the missing
"memory" clobber.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.h | 55 ++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 3167543bf2cc..0832a070f6f7 100644
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
 
@@ -609,38 +612,62 @@ static inline bool crdte_crste(union crste *crstep, union crste old, union crste
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
-			: "cc");
+			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr)
+			: "memory", "cc");
 	} else {
 		/* flush with guest asce */
-		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
+		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt]"
 			: "+m" (*crstep)
-			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
-			  [asce] "a" (asce.val), [local] "i" (local)
-			: "cc");
+			: [table_origin] "a" (table_origin),
+			  [gaddr_opt] "a" (gaddr | IDTE_GUEST_ASCE),
+			  [asce] "a" (asce.val)
+			: "memory", "cc");
+	}
+}
+
+static __always_inline void ipte(gfn_t gfn, union pte *ptep, union asce asce, bool nt)
+{
+	unsigned long flags;
+
+	if (machine_has_tlb_guest()) {
+		flags = IPTE_GUEST_ASCE | (nt ? IPTE_NODAT : 0);
+		__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, flags, asce.val, IPTE_GLOBAL);
+	} else {
+		__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, 0, 0, IPTE_GLOBAL);
 	}
 }
 
-- 
2.56.0

