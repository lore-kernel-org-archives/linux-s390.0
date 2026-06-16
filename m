Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FD366DC1;
	Tue, 16 Jun 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613658; cv=none; b=JIJYSIxg1OsxI978sYSMtyero29NPRCboGdj8u/bHoa7u2YQB464haHtpa9/4D1ZeJRcnj89VCo2YyR2gNFXvqyGnuue2USPTZXoU0zh9TjwQeG70INSZdTBEzgcAeapPi5F85h78+qEpFPkvql/wpDBBN03J84srxlrN6GOfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613658; c=relaxed/simple;
	bh=7u9j+rfRescss5/pLALiuBaT4qt2rps6sOm97+S5jVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoGRVw41bw5cNMl9WGeT39eOpCpBLTc+j4aj2sbyCZrv7P9PxRNX1L470WbfBjeMCM5/InSjjCydabLxrMUmIyKGMTt4KclQf1auVHzEpBoap8nrD5z+bjPD9nkmKC9wgUgmuSI8dvY0q2EfXNXu5ent88IwA2BO+QbyNCEfFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T1YJpfMl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T1YJpfMl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZYF1117823;
	Tue, 16 Jun 2026 12:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nUfBEGqesd6MqjNBt
	Qa0F7SwyBD3Kt2fkoYxJnylfBc=; b=T1YJpfMlHT2yfdWBA6p/lNx6sVnx7Ol+7
	NOl0+AvAsoX8UG/fMo3TcWbj/wB8ds4vbgmnY0DZ7cmUmlO3J0RdCSNe4BEs97gF
	1W8sb96Dttk2uyKpJmk/oHjr5n5M51FCmVTh8gdF7D6Gg2/yeqsl4aLcLEFZBC6Y
	5gk6nLsk3GmfBuavOjadOWDeaJkp5FsupG0futzvbUI6Az8kIZvaGR6+rAYAGe2c
	PYm2KHFm6BaHA8nkoAoVEA+VgYURMnj89jEBYGh8L3ApGqVFrfIq6jq8WU/MiWRr
	E/rMAOb0qpY3DwNdAIZglnpWNaJWlsQkZcmoy36pWcneKI0ykZ6VA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2d36s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYgJv030961;
	Tue, 16 Jun 2026 12:40:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb46h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCedBs48824710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:40:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EEE2004B;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D26620067;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 83D19E0E0C; Tue, 16 Jun 2026 14:40:39 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 2/7] s390/mm: Complete ptep_get() conversion
Date: Tue, 16 Jun 2026 14:40:34 +0200
Message-ID: <394c934384e463a36852af3e806d9b69be4a3626.1781611976.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781611976.git.agordeev@linux.ibm.com>
References: <cover.1781611976.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfXxCVlLJjVo3S7
 BltFSDHhNI8io31CZ98BJUUykwIcShn3jvo2ALVrpnKes5/HVY4/ZTivX9AbYRkGzDM2veH98U1
 YZiU6upiRqpP/ltvhxGvA4q2kzzeVZU=
X-Proofpoint-GUID: gUIvkMhyGw5nJmWYKWLQAqzq_iC0xaWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX7YIFNwKRKCFF
 rvanbhAGN9qiskLEFNvuMcH2M8SYbu4IRGIyCd+y4O6UTmS41y6/1UiFuInoIx2jyK0z/GMI23G
 iPRHTXvYQdmnVCBAv0n0dEc0X6SSNuV4l46cdI0Xtn5YymkkCLPrIPzmY/A4m+xohdo0dUDZHOd
 cUsKfexgXLZl1WJtM0kkWMbGg6WCSAVjkdgo+jW5eSjFby4JDeLOB9gECmPpx9ny1894pPs/etn
 Xo2HiehPYZ+egJLsmSJLLlbi9bEzoFyn8qMrUlv4BMhEzFfdWOQ6P8a+lgfCRD+SpO0d5fC2UQ/
 tIx/rXk91zlBSjlWadPx4xX2EaefGf1N+6Ai1QPY/n4/byxR9Iawb19lw/BPuNc5gZP/4GNdRZL
 YhAAMdz+GCpYc2wpAM3MDy6o2zFB4uPoDu0ZnhYUAbULTbaZpu2Xolmc0TCLUwnucUK66lESgqL
 kvLkUoaMNr5fNgMLKUg==
X-Proofpoint-ORIG-GUID: gUIvkMhyGw5nJmWYKWLQAqzq_iC0xaWz
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a31444c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=icivV8tQf5KrWCeISukA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160125

Finalize commit c33c794828f2 ("mm: ptep_get() conversion") and
replace direct page table entry dereferencing with the proper
accessors (ptep_get(), pmdp_get(), etc.).

Override the default getter implementations even though they are
currently identical: pud_clear(), p4d_clear(), and pgd_clear()
require corresponding architecture-specific getters, but these
are not yet defined. This avoids a dependency loop.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/boot/vmem.c           | 32 +++++++------
 arch/s390/include/asm/hugetlb.h |  2 +-
 arch/s390/include/asm/pgtable.h | 60 ++++++++++++++++++------
 arch/s390/mm/hugetlbpage.c      | 12 ++---
 arch/s390/mm/pageattr.c         | 45 ++++++++++--------
 arch/s390/mm/vmem.c             | 82 ++++++++++++++++++---------------
 6 files changed, 140 insertions(+), 93 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 7d6cc4c85af0..ff6d58a476ba 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -338,7 +338,7 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned=
 long addr, unsigned long e
=20
 	pte =3D pte_offset_kernel(pmd, addr);
 	for (; addr < end; addr +=3D PAGE_SIZE, pte++) {
-		if (pte_none(*pte)) {
+		if (pte_none(ptep_get(pte))) {
 			if (kasan_pte_populate_zero_shadow(pte, mode))
 				continue;
 			entry =3D __pte(resolve_pa_may_alloc(addr, PAGE_SIZE, mode));
@@ -355,26 +355,27 @@ static void pgtable_pmd_populate(pud_t *pud, unsign=
ed long addr, unsigned long e
 				 enum populate_mode mode)
 {
 	unsigned long pa, next, pages =3D 0;
-	pmd_t *pmd, entry;
+	pmd_t *pmd, entry, large_entry;
 	pte_t *pte;
=20
 	pmd =3D pmd_offset(pud, addr);
 	for (; addr < end; addr =3D next, pmd++) {
 		next =3D pmd_addr_end(addr, end);
-		if (pmd_none(*pmd)) {
+		entry =3D pmdp_get(pmd);
+		if (pmd_none(entry)) {
 			if (kasan_pmd_populate_zero_shadow(pmd, addr, next, mode))
 				continue;
 			pa =3D try_get_large_pmd_pa(pmd, addr, next, mode);
 			if (pa !=3D INVALID_PHYS_ADDR) {
-				entry =3D __pmd(pa);
-				entry =3D set_pmd_bit(entry, SEGMENT_KERNEL);
-				set_pmd(pmd, entry);
+				large_entry =3D __pmd(pa);
+				large_entry =3D set_pmd_bit(large_entry, SEGMENT_KERNEL);
+				set_pmd(pmd, large_entry);
 				pages++;
 				continue;
 			}
 			pte =3D boot_pte_alloc();
 			pmd_populate(&init_mm, pmd, pte);
-		} else if (pmd_leaf(*pmd)) {
+		} else if (pmd_leaf(entry)) {
 			continue;
 		}
 		pgtable_pte_populate(pmd, addr, next, mode);
@@ -387,26 +388,27 @@ static void pgtable_pud_populate(p4d_t *p4d, unsign=
ed long addr, unsigned long e
 				 enum populate_mode mode)
 {
 	unsigned long pa, next, pages =3D 0;
-	pud_t *pud, entry;
+	pud_t *pud, entry, large_entry;
 	pmd_t *pmd;
=20
 	pud =3D pud_offset(p4d, addr);
 	for (; addr < end; addr =3D next, pud++) {
 		next =3D pud_addr_end(addr, end);
-		if (pud_none(*pud)) {
+		entry =3D pudp_get(pud);
+		if (pud_none(entry)) {
 			if (kasan_pud_populate_zero_shadow(pud, addr, next, mode))
 				continue;
 			pa =3D try_get_large_pud_pa(pud, addr, next, mode);
 			if (pa !=3D INVALID_PHYS_ADDR) {
-				entry =3D __pud(pa);
-				entry =3D set_pud_bit(entry, REGION3_KERNEL);
-				set_pud(pud, entry);
+				large_entry =3D __pud(pa);
+				large_entry =3D set_pud_bit(large_entry, REGION3_KERNEL);
+				set_pud(pud, large_entry);
 				pages++;
 				continue;
 			}
 			pmd =3D boot_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_leaf(*pud)) {
+		} else if (pud_leaf(entry)) {
 			continue;
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
@@ -425,7 +427,7 @@ static void pgtable_p4d_populate(pgd_t *pgd, unsigned=
 long addr, unsigned long e
 	p4d =3D p4d_offset(pgd, addr);
 	for (; addr < end; addr =3D next, p4d++) {
 		next =3D p4d_addr_end(addr, end);
-		if (p4d_none(*p4d)) {
+		if (p4d_none(p4dp_get(p4d))) {
 			if (kasan_p4d_populate_zero_shadow(p4d, addr, next, mode))
 				continue;
 			pud =3D boot_crst_alloc(_REGION3_ENTRY_EMPTY);
@@ -451,7 +453,7 @@ static void pgtable_populate(unsigned long addr, unsi=
gned long end, enum populat
 	pgd =3D pgd_offset(&init_mm, addr);
 	for (; addr < end; addr =3D next, pgd++) {
 		next =3D pgd_addr_end(addr, end);
-		if (pgd_none(*pgd)) {
+		if (pgd_none(pgdp_get(pgd))) {
 			if (kasan_pgd_populate_zero_shadow(pgd, addr, next, mode))
 				continue;
 			p4d =3D boot_crst_alloc(_REGION2_ENTRY_EMPTY);
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/huge=
tlb.h
index 6983e52eaf81..e33a5b587ee4 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -41,7 +41,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_s=
truct *mm,
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
 				  pte_t *ptep, unsigned long sz)
 {
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYP=
E_R3)
+	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_=
ENTRY_TYPE_R3)
 		set_pte(ptep, __pte(_REGION3_ENTRY_EMPTY));
 	else
 		set_pte(ptep, __pte(_SEGMENT_ENTRY_EMPTY));
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index 3197b8b372a2..f9a8a92fa160 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -983,22 +983,39 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	WRITE_ONCE(*ptep, pte);
 }
=20
-static inline void pgd_clear(pgd_t *pgd)
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
 {
-	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYPE=
_R1)
-		set_pgd(pgd, __pgd(_REGION1_ENTRY_EMPTY));
+	return READ_ONCE(*ptep);
 }
=20
-static inline void p4d_clear(p4d_t *p4d)
+#define pmdp_get pmdp_get
+static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
-	if ((p4d_val(*p4d) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYPE=
_R2)
-		set_p4d(p4d, __p4d(_REGION2_ENTRY_EMPTY));
+	return READ_ONCE(*pmdp);
 }
=20
-static inline void pud_clear(pud_t *pud)
+#define pudp_get pudp_get
+static inline pud_t pudp_get(pud_t *pudp)
 {
-	if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYPE=
_R3)
-		set_pud(pud, __pud(_REGION3_ENTRY_EMPTY));
+	return READ_ONCE(*pudp);
+}
+
+#define p4dp_get p4dp_get
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	return READ_ONCE(*p4dp);
+}
+
+#define pgdp_get pgdp_get
+static inline pgd_t pgdp_get(pgd_t *pgdp)
+{
+	return READ_ONCE(*pgdp);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, p=
te_t *ptep)
+{
+	set_pte(ptep, __pte(_PAGE_INVALID));
 }
=20
 static inline void pmd_clear(pmd_t *pmdp)
@@ -1006,9 +1023,22 @@ static inline void pmd_clear(pmd_t *pmdp)
 	set_pmd(pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
 }
=20
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr, p=
te_t *ptep)
+static inline void pud_clear(pud_t *pud)
 {
-	set_pte(ptep, __pte(_PAGE_INVALID));
+	if ((pud_val(pudp_get(pud)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_E=
NTRY_TYPE_R3)
+		set_pud(pud, __pud(_REGION3_ENTRY_EMPTY));
+}
+
+static inline void p4d_clear(p4d_t *p4d)
+{
+	if ((p4d_val(p4dp_get(p4d)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_E=
NTRY_TYPE_R2)
+		set_p4d(p4d, __p4d(_REGION2_ENTRY_EMPTY));
+}
+
+static inline void pgd_clear(pgd_t *pgd)
+{
+	if ((pgd_val(pgdp_get(pgd)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_E=
NTRY_TYPE_R1)
+		set_pgd(pgd, __pgd(_REGION1_ENTRY_EMPTY));
 }
=20
 /*
@@ -1169,7 +1199,7 @@ pte_t ptep_xchg_lazy(struct mm_struct *, unsigned l=
ong, pte_t *, pte_t);
 static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
-	pte_t pte =3D *ptep;
+	pte_t pte =3D ptep_get(ptep);
=20
 	pte =3D ptep_xchg_direct(vma->vm_mm, addr, ptep, pte_mkold(pte));
 	return pte_young(pte);
@@ -1230,7 +1260,7 @@ static inline pte_t ptep_get_and_clear_full(struct =
mm_struct *mm,
 	pte_t res;
=20
 	if (full) {
-		res =3D *ptep;
+		res =3D ptep_get(ptep);
 		set_pte(ptep, __pte(_PAGE_INVALID));
 	} else {
 		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
@@ -1259,7 +1289,7 @@ static inline pte_t ptep_get_and_clear_full(struct =
mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
-	pte_t pte =3D *ptep;
+	pte_t pte =3D ptep_get(ptep);
=20
 	if (pte_write(pte))
 		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
@@ -1295,7 +1325,7 @@ static inline void flush_tlb_fix_spurious_fault(str=
uct vm_area_struct *vma,
 	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
 	 * A local RDP can be used to do the flush.
 	 */
-	if (cpu_has_rdp() && !(pte_val(*ptep) & _PAGE_PROTECT))
+	if (cpu_has_rdp() && !(pte_val(ptep_get(ptep)) & _PAGE_PROTECT))
 		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 302ef5781b65..db35d8fe8609 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -143,7 +143,7 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned=
 long addr,
 	rste =3D __pte_to_rste(pte);
=20
 	/* Set correct table type for 2G hugepages */
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYP=
E_R3) {
+	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_=
ENTRY_TYPE_R3) {
 		if (likely(pte_present(pte)))
 			rste |=3D _REGION3_ENTRY_LARGE;
 		rste |=3D _REGION_ENTRY_TYPE_R3;
@@ -161,7 +161,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned l=
ong addr,
=20
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *pte=
p)
 {
-	return __rste_to_pte(pte_val(*ptep));
+	return __rste_to_pte(pte_val(ptep_get(ptep)));
 }
=20
 pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
@@ -171,7 +171,7 @@ pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
 	pmd_t *pmdp =3D (pmd_t *) ptep;
 	pud_t *pudp =3D (pud_t *) ptep;
=20
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_ENTRY_TYP=
E_R3)
+	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) =3D=3D _REGION_=
ENTRY_TYPE_R3)
 		pudp_xchg_direct(mm, addr, pudp, __pud(_REGION3_ENTRY_EMPTY));
 	else
 		pmdp_xchg_direct(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_EMPTY));
@@ -209,13 +209,13 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	pmd_t *pmdp =3D NULL;
=20
 	pgdp =3D pgd_offset(mm, addr);
-	if (pgd_present(*pgdp)) {
+	if (pgd_present(pgdp_get(pgdp))) {
 		p4dp =3D p4d_offset(pgdp, addr);
-		if (p4d_present(*p4dp)) {
+		if (p4d_present(p4dp_get(p4dp))) {
 			pudp =3D pud_offset(p4dp, addr);
 			if (sz =3D=3D PUD_SIZE)
 				return (pte_t *)pudp;
-			if (pud_present(*pudp))
+			if (pud_present(pudp_get(pudp)))
 				pmdp =3D pmd_offset(pudp, addr);
 		}
 	}
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index bb29c38ae624..e6f788696dd1 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -85,7 +85,7 @@ static int walk_pte_level(pmd_t *pmdp, unsigned long ad=
dr, unsigned long end,
 		return 0;
 	ptep =3D pte_offset_kernel(pmdp, addr);
 	do {
-		new =3D *ptep;
+		new =3D ptep_get(ptep);
 		if (pte_none(new))
 			return -EINVAL;
 		if (flags & SET_MEMORY_RO)
@@ -114,15 +114,16 @@ static int split_pmd_page(pmd_t *pmdp, unsigned lon=
g addr)
 {
 	unsigned long pte_addr, prot;
 	pte_t *pt_dir, *ptep;
-	pmd_t new;
+	pmd_t new, pmd;
 	int i, ro, nx;
=20
 	pt_dir =3D vmem_pte_alloc();
 	if (!pt_dir)
 		return -ENOMEM;
-	pte_addr =3D pmd_pfn(*pmdp) << PAGE_SHIFT;
-	ro =3D !!(pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT);
-	nx =3D !!(pmd_val(*pmdp) & _SEGMENT_ENTRY_NOEXEC);
+	pmd =3D pmdp_get(pmdp);
+	pte_addr =3D pmd_pfn(pmd) << PAGE_SHIFT;
+	ro =3D !!(pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT);
+	nx =3D !!(pmd_val(pmd) & _SEGMENT_ENTRY_NOEXEC);
 	prot =3D pgprot_val(ro ? PAGE_KERNEL_RO : PAGE_KERNEL);
 	if (!nx)
 		prot &=3D ~_PAGE_NOEXEC;
@@ -142,7 +143,7 @@ static int split_pmd_page(pmd_t *pmdp, unsigned long =
addr)
 static void modify_pmd_page(pmd_t *pmdp, unsigned long addr,
 			    unsigned long flags)
 {
-	pmd_t new =3D *pmdp;
+	pmd_t new =3D pmdp_get(pmdp);
=20
 	if (flags & SET_MEMORY_RO)
 		new =3D pmd_wrprotect(new);
@@ -165,16 +166,17 @@ static int walk_pmd_level(pud_t *pudp, unsigned lon=
g addr, unsigned long end,
 			  unsigned long flags)
 {
 	unsigned long next;
+	pmd_t *pmdp, pmd;
 	int need_split;
-	pmd_t *pmdp;
 	int rc =3D 0;
=20
 	pmdp =3D pmd_offset(pudp, addr);
 	do {
-		if (pmd_none(*pmdp))
+		pmd =3D pmdp_get(pmdp);
+		if (pmd_none(pmd))
 			return -EINVAL;
 		next =3D pmd_addr_end(addr, end);
-		if (pmd_leaf(*pmdp)) {
+		if (pmd_leaf(pmd)) {
 			need_split  =3D !!(flags & SET_MEMORY_4K);
 			need_split |=3D !!(addr & ~PMD_MASK);
 			need_split |=3D !!(addr + PMD_SIZE > next);
@@ -201,15 +203,16 @@ int split_pud_page(pud_t *pudp, unsigned long addr)
 {
 	unsigned long pmd_addr, prot;
 	pmd_t *pm_dir, *pmdp;
-	pud_t new;
+	pud_t new, pud;
 	int i, ro, nx;
=20
 	pm_dir =3D vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 	if (!pm_dir)
 		return -ENOMEM;
-	pmd_addr =3D pud_pfn(*pudp) << PAGE_SHIFT;
-	ro =3D !!(pud_val(*pudp) & _REGION_ENTRY_PROTECT);
-	nx =3D !!(pud_val(*pudp) & _REGION_ENTRY_NOEXEC);
+	pud =3D pudp_get(pudp);
+	pmd_addr =3D pud_pfn(pud) << PAGE_SHIFT;
+	ro =3D !!(pud_val(pud) & _REGION_ENTRY_PROTECT);
+	nx =3D !!(pud_val(pud) & _REGION_ENTRY_NOEXEC);
 	prot =3D pgprot_val(ro ? SEGMENT_KERNEL_RO : SEGMENT_KERNEL);
 	if (!nx)
 		prot &=3D ~_SEGMENT_ENTRY_NOEXEC;
@@ -229,7 +232,7 @@ int split_pud_page(pud_t *pudp, unsigned long addr)
 static void modify_pud_page(pud_t *pudp, unsigned long addr,
 			    unsigned long flags)
 {
-	pud_t new =3D *pudp;
+	pud_t new =3D pudp_get(pudp);
=20
 	if (flags & SET_MEMORY_RO)
 		new =3D pud_wrprotect(new);
@@ -252,16 +255,17 @@ static int walk_pud_level(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
 			  unsigned long flags)
 {
 	unsigned long next;
+	pud_t *pudp, pud;
 	int need_split;
-	pud_t *pudp;
 	int rc =3D 0;
=20
 	pudp =3D pud_offset(p4d, addr);
 	do {
-		if (pud_none(*pudp))
+		pud =3D pudp_get(pudp);
+		if (pud_none(pud))
 			return -EINVAL;
 		next =3D pud_addr_end(addr, end);
-		if (pud_leaf(*pudp)) {
+		if (pud_leaf(pud)) {
 			need_split  =3D !!(flags & SET_MEMORY_4K);
 			need_split |=3D !!(addr & ~PUD_MASK);
 			need_split |=3D !!(addr + PUD_SIZE > next);
@@ -291,7 +295,7 @@ static int walk_p4d_level(pgd_t *pgd, unsigned long a=
ddr, unsigned long end,
=20
 	p4dp =3D p4d_offset(pgd, addr);
 	do {
-		if (p4d_none(*p4dp))
+		if (p4d_none(p4dp_get(p4dp)))
 			return -EINVAL;
 		next =3D p4d_addr_end(addr, end);
 		rc =3D walk_pud_level(p4dp, addr, next, flags);
@@ -313,7 +317,7 @@ static int change_page_attr(unsigned long addr, unsig=
ned long end,
=20
 	pgdp =3D pgd_offset_k(addr);
 	do {
-		if (pgd_none(*pgdp))
+		if (pgd_none(pgdp_get(pgdp)))
 			break;
 		next =3D pgd_addr_end(addr, end);
 		rc =3D walk_p4d_level(pgdp, addr, next, flags);
@@ -451,7 +455,8 @@ void __kernel_map_pages(struct page *page, int numpag=
es, int enable)
 		nr =3D min(numpages - i, nr);
 		if (enable) {
 			for (j =3D 0; j < nr; j++) {
-				pte =3D clear_pte_bit(*ptep, __pgprot(_PAGE_INVALID));
+				pte =3D ptep_get(ptep);
+				pte =3D clear_pte_bit(pte, __pgprot(_PAGE_INVALID));
 				set_pte(ptep, pte);
 				address +=3D PAGE_SIZE;
 				ptep++;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index eeadff45e0e1..803099f3db73 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -171,18 +171,19 @@ static int __ref modify_pte_table(pmd_t *pmd, unsig=
ned long addr,
 {
 	unsigned long prot, pages =3D 0;
 	int ret =3D -ENOMEM;
-	pte_t *pte;
+	pte_t *pte, entry;
=20
 	prot =3D pgprot_val(PAGE_KERNEL);
 	pte =3D pte_offset_kernel(pmd, addr);
 	for (; addr < end; addr +=3D PAGE_SIZE, pte++) {
+		entry =3D ptep_get(pte);
 		if (!add) {
-			if (pte_none(*pte))
+			if (pte_none(entry))
 				continue;
 			if (!direct)
-				vmem_free_pages((unsigned long)pfn_to_virt(pte_pfn(*pte)), get_order=
(PAGE_SIZE), altmap);
+				vmem_free_pages((unsigned long)pfn_to_virt(pte_pfn(entry)), get_orde=
r(PAGE_SIZE), altmap);
 			pte_clear(&init_mm, addr, pte);
-		} else if (pte_none(*pte)) {
+		} else if (pte_none(entry)) {
 			if (!direct) {
 				void *new_page =3D vmemmap_alloc_block_buf(PAGE_SIZE, NUMA_NO_NODE, =
altmap);
=20
@@ -212,10 +213,10 @@ static void try_free_pte_table(pmd_t *pmd, unsigned=
 long start)
 	/* We can safely assume this is fully in 1:1 mapping & vmemmap area */
 	pte =3D pte_offset_kernel(pmd, start);
 	for (i =3D 0; i < PTRS_PER_PTE; i++, pte++) {
-		if (!pte_none(*pte))
+		if (!pte_none(ptep_get(pte)))
 			return;
 	}
-	vmem_pte_free((unsigned long *) pmd_deref(*pmd));
+	vmem_pte_free((unsigned long *)pmd_deref(pmdp_get(pmd)));
 	pmd_clear(pmd);
 }
=20
@@ -226,6 +227,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigne=
d long addr,
 {
 	unsigned long next, prot, pages =3D 0;
 	int ret =3D -ENOMEM;
+	pmd_t entry;
 	pmd_t *pmd;
 	pte_t *pte;
=20
@@ -233,23 +235,24 @@ static int __ref modify_pmd_table(pud_t *pud, unsig=
ned long addr,
 	pmd =3D pmd_offset(pud, addr);
 	for (; addr < end; addr =3D next, pmd++) {
 		next =3D pmd_addr_end(addr, end);
+		entry =3D pmdp_get(pmd);
 		if (!add) {
-			if (pmd_none(*pmd))
+			if (pmd_none(entry))
 				continue;
-			if (pmd_leaf(*pmd)) {
+			if (pmd_leaf(entry)) {
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
 					if (!direct)
-						vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
+						vmem_free_pages(pmd_deref(entry), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 					pages++;
 				} else if (!direct && vmemmap_unuse_sub_pmd(addr, next)) {
-					vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
+					vmem_free_pages(pmd_deref(entry), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 				}
 				continue;
 			}
-		} else if (pmd_none(*pmd)) {
+		} else if (pmd_none(entry)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE) &&
 			    cpu_has_edat1() && direct &&
@@ -281,7 +284,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigne=
d long addr,
 			if (!pte)
 				goto out;
 			pmd_populate(&init_mm, pmd, pte);
-		} else if (pmd_leaf(*pmd)) {
+		} else if (pmd_leaf(entry)) {
 			if (!direct)
 				vmemmap_use_sub_pmd(addr, next);
 			continue;
@@ -306,9 +309,9 @@ static void try_free_pmd_table(pud_t *pud, unsigned l=
ong start)
=20
 	pmd =3D pmd_offset(pud, start);
 	for (i =3D 0; i < PTRS_PER_PMD; i++, pmd++)
-		if (!pmd_none(*pmd))
+		if (!pmd_none(pmdp_get(pmd)))
 			return;
-	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER, NULL);
+	vmem_free_pages(pud_deref(pudp_get(pud)), CRST_ALLOC_ORDER, NULL);
 	pud_clear(pud);
 }
=20
@@ -317,21 +320,22 @@ static int modify_pud_table(p4d_t *p4d, unsigned lo=
ng addr, unsigned long end,
 {
 	unsigned long next, prot, pages =3D 0;
 	int ret =3D -ENOMEM;
-	pud_t *pud;
+	pud_t *pud, entry;
 	pmd_t *pmd;
=20
 	prot =3D pgprot_val(REGION3_KERNEL);
 	pud =3D pud_offset(p4d, addr);
 	for (; addr < end; addr =3D next, pud++) {
 		next =3D pud_addr_end(addr, end);
+		entry =3D pudp_get(pud);
 		if (!add) {
-			if (pud_none(*pud))
+			if (pud_none(entry))
 				continue;
-			if (pud_leaf(*pud)) {
+			if (pud_leaf(entry)) {
 				if (IS_ALIGNED(addr, PUD_SIZE) &&
 				    IS_ALIGNED(next, PUD_SIZE)) {
 					if (!direct)
-						vmem_free_pages(pud_deref(*pud), get_order(PUD_SIZE), altmap);
+						vmem_free_pages(pud_deref(entry), get_order(PUD_SIZE), altmap);
 					pud_clear(pud);
 					pages++;
 					continue;
@@ -339,7 +343,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
 					split_pud_page(pud, addr & PUD_MASK);
 				}
 			}
-		} else if (pud_none(*pud)) {
+		} else if (pud_none(entry)) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE) &&
 			    cpu_has_edat2() && direct &&
@@ -352,7 +356,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long=
 addr, unsigned long end,
 			if (!pmd)
 				goto out;
 			pud_populate(&init_mm, pud, pmd);
-		} else if (pud_leaf(*pud)) {
+		} else if (pud_leaf(entry)) {
 			continue;
 		}
 		ret =3D modify_pmd_table(pud, addr, next, add, direct, altmap);
@@ -375,10 +379,10 @@ static void try_free_pud_table(p4d_t *p4d, unsigned=
 long start)
=20
 	pud =3D pud_offset(p4d, start);
 	for (i =3D 0; i < PTRS_PER_PUD; i++, pud++) {
-		if (!pud_none(*pud))
+		if (!pud_none(pudp_get(pud)))
 			return;
 	}
-	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER, NULL);
+	vmem_free_pages(p4d_deref(p4dp_get(p4d)), CRST_ALLOC_ORDER, NULL);
 	p4d_clear(p4d);
 }
=20
@@ -387,16 +391,17 @@ static int modify_p4d_table(pgd_t *pgd, unsigned lo=
ng addr, unsigned long end,
 {
 	unsigned long next;
 	int ret =3D -ENOMEM;
-	p4d_t *p4d;
+	p4d_t *p4d, entry;
 	pud_t *pud;
=20
 	p4d =3D p4d_offset(pgd, addr);
 	for (; addr < end; addr =3D next, p4d++) {
 		next =3D p4d_addr_end(addr, end);
+		entry =3D p4dp_get(p4d);
 		if (!add) {
-			if (p4d_none(*p4d))
+			if (p4d_none(entry))
 				continue;
-		} else if (p4d_none(*p4d)) {
+		} else if (p4d_none(entry)) {
 			pud =3D vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
 			if (!pud)
 				goto out;
@@ -420,10 +425,10 @@ static void try_free_p4d_table(pgd_t *pgd, unsigned=
 long start)
=20
 	p4d =3D p4d_offset(pgd, start);
 	for (i =3D 0; i < PTRS_PER_P4D; i++, p4d++) {
-		if (!p4d_none(*p4d))
+		if (!p4d_none(p4dp_get(p4d)))
 			return;
 	}
-	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER, NULL);
+	vmem_free_pages(pgd_deref(pgdp_get(pgd)), CRST_ALLOC_ORDER, NULL);
 	pgd_clear(pgd);
 }
=20
@@ -432,7 +437,7 @@ static int modify_pagetable(unsigned long start, unsi=
gned long end, bool add,
 {
 	unsigned long addr, next;
 	int ret =3D -ENOMEM;
-	pgd_t *pgd;
+	pgd_t *pgd, entry;
 	p4d_t *p4d;
=20
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(start | end)))
@@ -449,11 +454,12 @@ static int modify_pagetable(unsigned long start, un=
signed long end, bool add,
 	for (addr =3D start; addr < end; addr =3D next) {
 		next =3D pgd_addr_end(addr, end);
 		pgd =3D pgd_offset_k(addr);
+		entry =3D pgdp_get(pgd);
=20
 		if (!add) {
-			if (pgd_none(*pgd))
+			if (pgd_none(entry))
 				continue;
-		} else if (pgd_none(*pgd)) {
+		} else if (pgd_none(entry)) {
 			p4d =3D vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
 			if (!p4d)
 				goto out;
@@ -575,6 +581,8 @@ int vmem_add_mapping(unsigned long start, unsigned lo=
ng size)
 pte_t *vmem_get_alloc_pte(unsigned long addr, bool alloc)
 {
 	pte_t *ptep =3D NULL;
+	pud_t pud_entry;
+	pmd_t pmd_entry;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -582,7 +590,7 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool al=
loc)
 	pte_t *pte;
=20
 	pgd =3D pgd_offset_k(addr);
-	if (pgd_none(*pgd)) {
+	if (pgd_none(pgdp_get(pgd))) {
 		if (!alloc)
 			goto out;
 		p4d =3D vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
@@ -591,7 +599,7 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool al=
loc)
 		pgd_populate(&init_mm, pgd, p4d);
 	}
 	p4d =3D p4d_offset(pgd, addr);
-	if (p4d_none(*p4d)) {
+	if (p4d_none(p4dp_get(p4d))) {
 		if (!alloc)
 			goto out;
 		pud =3D vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
@@ -600,25 +608,27 @@ pte_t *vmem_get_alloc_pte(unsigned long addr, bool =
alloc)
 		p4d_populate(&init_mm, p4d, pud);
 	}
 	pud =3D pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	pud_entry =3D pudp_get(pud);
+	if (pud_none(pud_entry)) {
 		if (!alloc)
 			goto out;
 		pmd =3D vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
 		if (!pmd)
 			goto out;
 		pud_populate(&init_mm, pud, pmd);
-	} else if (WARN_ON_ONCE(pud_leaf(*pud))) {
+	} else if (WARN_ON_ONCE(pud_leaf(pud_entry))) {
 		goto out;
 	}
 	pmd =3D pmd_offset(pud, addr);
-	if (pmd_none(*pmd)) {
+	pmd_entry =3D pmdp_get(pmd);
+	if (pmd_none(pmd_entry)) {
 		if (!alloc)
 			goto out;
 		pte =3D vmem_pte_alloc();
 		if (!pte)
 			goto out;
 		pmd_populate(&init_mm, pmd, pte);
-	} else if (WARN_ON_ONCE(pmd_leaf(*pmd))) {
+	} else if (WARN_ON_ONCE(pmd_leaf(pmd_entry))) {
 		goto out;
 	}
 	ptep =3D pte_offset_kernel(pmd, addr);
--=20
2.53.0

