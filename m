Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770947;
	b=Z+xK9lpQomtT8ra7hwnpnsOMet7HKsaHwWcyTL1MuxrGWpdCMNRYPPyfjxHNGPEzefVl
	 PuirSX+jsBan8SxmQ+9oX+J7Txi9d2keiljajzBZ+Yd2JkJ0KPhJEFyLyDs3VB4kyUGDF
	 ZlGnc+lOVcEnXk4CV1TBsVfwFowSo0F2pwpL01xcidmitR6b5B3UrQfICTW8+cRrqkDDa
	 NKRHnw88i2TjnMMSgSUnhrpsTjWPiyq9i3plb6SC1f1M89rV9G578zQ5OGZjtF54lNTyK
	 5D0wTHDnTtZQjiyzErDFWHMlYrO1fYl28J5SeGp+i6k7ooxcy7siLoitLPfmKawxSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=78JrFq5aExg/7zMRcSgpF/bIWA9lp16cov1aY/jcVB8=;
	b=gLJMXnD49acksiD1ZQNgjJVMnwqq1E7hdr9jRrecjC2BvlCtudW3OfgMDUTsOXOZ6S5Y
	 OaG+wq2fI+Wq3R89k5DyNnSrkNzfgGYZfL9jRUPK+GVmUgbHp5FGDRnHBXHb5O0RKJCoj
	 U9/UYcTeH4Zil/7hcho9yx/KDz0mTpuHihjEMSLFqxL8CJOHdVwSz5tmqz6AmBkozzKaR
	 QP7Nl0H/pLzTTLHOPnKq0Y8wiY6cv8EubdQ8vRWo+wwvCJ+SLss9w+6KLzjY9dtZHKEo6
	 DL8opOAFkkUISjkKAo5lWe0BCWm+mo4vTDv6HGBuKSVSVpEQdWQfcg5xA6yVhqtVKoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="GBG/IQ73";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939C606A32C;
	Fri, 23 Oct 2026 15:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5939C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GBG/IQ73
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEWOt3113947;
	Fri, 23 Oct 2026 15:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=78JrFq5aExg/7zMRc
	SgpF/bIWA9lp16cov1aY/jcVB8=; b=GBG/IQ73mkKOH4qRmu2NYLKOtHcKZjkJB
	Y69Q4lAAcsbkZdPAponHAEtkowb77bvhehVPSlY4a2pK/d3Vjmoq33+9+7h4J8Gh
	qgHGsZfCJmT7H65FQb24mRMjjrPGyYBLIBAHB9dOKiW0U/Q8DdWfOQQwyXu0oPo5
	1GoX/+TRVIEdXwGBTHWWAWu4ZfwZUf5Xqdb+SimSrUJTUNCr+7sFHCfGkrLyc2DM
	EBPCCmTtRDe/vwTPh1GgGaxXKlLv3qLQ2AK6HHxO+QqxpxDrPWOP3/lY/v4Tgr05
	O/D7be9zNFt/zfrnNgvgwgrXgXnBAjnX56LHc91CTTS+FskiBfi0w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b5j18-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE66sj2165779;
	Fri, 23 Oct 2026 15:55:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg25h57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtWeS31851214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2EC420040;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90E492004B;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 05/10] KVM: s390: Replace ASCE usage with a struct with more flags
Date: Fri, 23 Oct 2026 17:55:26 +0200
Message-ID: <20261023155531.206113-6-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb837d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CnZTriogqvabBJrd8TwA:9
 a=no00TtT2FGoh-0HS:21
X-Proofpoint-ORIG-GUID: t26KUhYw6KaW2t3TnRTPv18UKLgaDXHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX+a7J1+Ci5zu6
 Cf2CKolPtn2P8Y4u8+le1eJziILO9pCjzvP6UNM24WOQVmXRoidSoSWOPUxT33N4eF9QHDgRvVo
 Hl/vkY1LhCreWkdkAZ2uPok/zTQ0d4iuOkZfgdyGpe0PF41VLRBf81GX9f8Cc4mR5qynRqwGZhr
 QIc9DbyB8uTKyNzK41N+InUm9Bn86cJ9A1H0XjgPaaZwAhpV5aB3eBEBswwjv7IgRkxXT/QTChE
 A3BJgA+xgQ/YRge1JTC+DQMmImhs06fTYZYNI1GUC6D3+QS/auOH/sktS9rRaCGFWPItrC8DzQm
 dNwIS0agrSLCwqELe+phr6HmMPxZXSRMgJq2J3CZWkBfj2NJFBkysdmTXGOJfFFdt2y48Die2QY
 3qBhx+qQhnOlr2k3+wN0yvXm00lZ6dp01uVlhC3/NRmpa5oW9ThKrnSFBPhNp84I5hJHpBGkGcG
 DkhmYZj5hFbR2EfADWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfXy5IKJDk4A0WC
 fheQOznbBqzzWv1S+wFTcs7Urd0JXU8CuWt4AROfgVp/WqRKF9H86VCVBbMzVpRTtdOBjC45o7y
 5zYixMZU3cyhNh8NQEI/P3GmcyQPbNc=
X-Proofpoint-GUID: t26KUhYw6KaW2t3TnRTPv18UKLgaDXHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061

Replace usage of simple ASCEs with a struct that contains the ASCE, a
pointer to the table, and some flags.

This way, there will be no need to manually pass the various flags in
addition to the ASCE where needed. Walking the DAT tables will also not
need to first convert the physical address to virtual.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c     | 158 ++++++++++++++++++-----------------
 arch/s390/kvm/gmap/dat.h     |  93 ++++++++++++---------
 arch/s390/kvm/gmap/gmap.c    | 114 +++++++++++++------------
 arch/s390/kvm/gmap/gmap.h    |  27 ++----
 arch/s390/kvm/gmap/kvm_mmu.c |   6 +-
 arch/s390/kvm/s390/gaccess.c |  26 +++---
 arch/s390/kvm/s390/priv.c    |  15 ++--
 arch/s390/kvm/s390/pv.c      |  11 +--
 arch/s390/kvm/s390/s390.c    |  35 ++++----
 arch/s390/kvm/s390/vsie.c    |   3 +-
 10 files changed, 252 insertions(+), 236 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 48bb97ae4dd1..807a4ef84a07 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -102,34 +102,37 @@ void dat_free_level(struct crst_table *table, bool owns_ptes)
 	dat_free_crst(table);
 }
 
-int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, int newtype)
+int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, struct dat_tables *datt, int newtype)
 {
 	struct crst_table *table;
 	union crste crste;
 
-	while (asce->dt > newtype) {
-		table = dereference_asce(*asce);
+	while (datt->asce.dt > newtype) {
+		table = datt->table;
 		crste = table->crstes[0];
 		if (crste.h.fc)
 			return 0;
 		if (!crste.h.i) {
-			asce->rsto = crste.h.fc0.to;
+			datt->asce.rsto = crste.h.fc0.to;
 			dat_free_crst(table);
+			datt->table = phys_to_virt(datt->asce.val & _ASCE_ORIGIN);
 		} else {
 			crste.h.tt--;
 			crst_table_init((void *)table, crste.val);
 		}
-		asce->dt--;
+		datt->asce.dt--;
 	}
-	while (asce->dt < newtype) {
-		crste = _crste_fc0(asce->rsto, asce->dt + 1);
+	while (datt->asce.dt < newtype) {
+		crste = _crste_fc0(datt->asce.rsto, datt->asce.dt + 1);
 		table = dat_alloc_crst_noinit(mc);
 		if (!table)
 			return -ENOMEM;
 		crst_table_init((void *)table, _CRSTE_HOLE(crste.h.tt).val);
 		table->crstes[0] = crste;
-		asce->rsto = __pa(table) >> PAGE_SHIFT;
-		asce->dt++;
+
+		datt->asce.rsto = __pa(table) >> PAGE_SHIFT;
+		datt->asce.dt++;
+		datt->table = table;
 	}
 	return 0;
 }
@@ -160,7 +163,7 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
 }
 
 union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
-			    union asce asce, bool uses_skeys)
+			    struct dat_tables datt)
 {
 	union pte old = READ_ONCE(*ptep);
 
@@ -174,12 +177,13 @@ union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, g
 		unsigned long opts = IPTE_GUEST_ASCE | (pgste.nodat ? IPTE_NODAT : 0);
 
 		if (machine_has_tlb_guest())
-			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts, asce.val, IPTE_GLOBAL);
+			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts,
+				    datt.asce.val, IPTE_GLOBAL);
 		else
 			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, 0, 0, IPTE_GLOBAL);
 	}
 
-	if (uses_skeys) {
+	if (datt.uses_skeys) {
 		if (old.h.i && !new.h.i)
 			/* Invalid to valid: restore storage keys from PGSTE. */
 			dat_set_storage_key_from_pgste(new, pgste);
@@ -205,7 +209,7 @@ union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, g
  * Return: 0 in case of success, -ENOMEM if running out of memory.
  */
 static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t gfn,
-			 union asce asce, bool uses_skeys)
+			 struct dat_tables datt)
 {
 	union pgste pgste_init;
 	struct page_table *pt;
@@ -242,13 +246,13 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.vsie_gmem = old.s.fc1.vsie_notif;
-			pgste_init.pcl = uses_skeys && init.h.i;
+			pgste_init.pcl = datt.uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
 			dat_init_page_table(pt, init.val, 0);
 		}
 
-		if (dat_pmdp_xchg_atomic(pmdp, old, new, gfn, asce)) {
+		if (dat_pmdp_xchg_atomic(pmdp, old, new, gfn, datt.asce)) {
 			if (!pgste_init.pcl)
 				return 0;
 			for (i = 0; i < _PAGE_ENTRIES; i++) {
@@ -274,7 +278,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
  * Return: %0 in case of success, %-ENOMEM if running out of memory.
  */
 static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
-			   gfn_t gfn, union asce asce, bool uses_skeys)
+			   gfn_t gfn, struct dat_tables datt)
 {
 	struct crst_table *table;
 	union crste old, new, init;
@@ -282,7 +286,7 @@ static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
 
 	old = READ_ONCE(*crstep);
 	if (is_pmd(old))
-		return dat_split_ste(mc, &crstep->pmd, gfn, asce, uses_skeys);
+		return dat_split_ste(mc, &crstep->pmd, gfn, datt);
 
 	BUG_ON(!mc);
 
@@ -307,7 +311,7 @@ static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
 		} else {
 			crst_table_init((void *)table, init.val);
 		}
-		if (dat_crstep_xchg_atomic(crstep, old, new, gfn, asce))
+		if (dat_crstep_xchg_atomic(crstep, old, new, gfn, datt.asce))
 			return 0;
 		old = READ_ONCE(*crstep);
 	}
@@ -321,7 +325,7 @@ static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
  * @mc: Cache to use to allocate dat tables, if needed; can be NULL if neither
  *      %DAT_WALK_SPLIT or %DAT_WALK_ALLOC is specified in @flags.
  * @gfn: Guest frame.
- * @asce: The ASCE of the address space.
+ * @datt: The DAT tables of the address space.
  * @flags: Flags from WALK_* macros.
  * @walk_level: Level to walk to, from LEVEL_* macros.
  * @last: Will be filled the last visited non-pte DAT entry.
@@ -337,7 +341,6 @@ static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
  * * %DAT_WALK_ANY: return successfully even if the requested level could not be reached
  * * %DAT_WALK_CONTINUE: walk to the requested level with the specified flags, and then try to
  *                       continue walking to ptes with only DAT_WALK_ANY
- * * %DAT_WALK_USES_SKEYS: storage keys are in use
  *
  * Context: called with kvm->mmu_lock held.
  *
@@ -350,12 +353,11 @@ static int dat_split_crste(struct kvm_s390_mmu_cache *mc, union crste *crstep,
  * * %-ENOENT if the requested level could not be reached for other reasons
  * * %-ENOMEM if running out of memory while allocating or splitting a table
  */
-int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, int flags,
+int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, struct dat_tables datt, int flags,
 		   int walk_level, union crste **last, union pte **ptepp)
 {
 	union vaddress vaddr = { .addr = gfn_to_gpa(gfn) };
 	bool continue_anyway = flags & DAT_WALK_CONTINUE;
-	bool uses_skeys = flags & DAT_WALK_USES_SKEYS;
 	bool ign_holes = flags & DAT_WALK_IGN_HOLES;
 	bool allocate = flags & DAT_WALK_ALLOC;
 	bool split = flags & DAT_WALK_SPLIT;
@@ -368,15 +370,15 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 
 	*last = NULL;
 	*ptepp = NULL;
-	if (WARN_ON_ONCE(unlikely(!asce.val)))
+	if (WARN_ON_ONCE(unlikely(!datt.asce.val)))
 		return -EINVAL;
-	if (WARN_ON_ONCE(unlikely(walk_level > asce.dt)))
+	if (WARN_ON_ONCE(unlikely(walk_level > datt.asce.dt)))
 		return -EINVAL;
-	if (!asce_contains_gfn(asce, gfn))
+	if (!dat_tables_contain_gfn(datt, gfn))
 		return PGM_ADDRESSING;
 
-	table = dereference_asce(asce);
-	if (asce.dt >= ASCE_TYPE_REGION1) {
+	table = datt.table;
+	if (datt.asce.dt >= ASCE_TYPE_REGION1) {
 		*last = table->crstes + vaddr.rfx;
 		entry = READ_ONCE(**last);
 		if (WARN_ON_ONCE(entry.h.tt != TABLE_TYPE_REGION1))
@@ -388,7 +390,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		if (entry.pgd.h.i) {
 			if (!allocate)
 				return any ? 0 : -ENOENT;
-			rc = dat_split_crste(mc, *last, gfn, asce, uses_skeys);
+			rc = dat_split_crste(mc, *last, gfn, datt);
 			if (rc)
 				return rc;
 			entry = READ_ONCE(**last);
@@ -396,7 +398,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		table = dereference_crste(entry.pgd);
 	}
 
-	if (asce.dt >= ASCE_TYPE_REGION2) {
+	if (datt.asce.dt >= ASCE_TYPE_REGION2) {
 		*last = table->crstes + vaddr.rsx;
 		entry = READ_ONCE(**last);
 		if (WARN_ON_ONCE(entry.h.tt != TABLE_TYPE_REGION2))
@@ -408,7 +410,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		if (entry.p4d.h.i) {
 			if (!allocate)
 				return any ? 0 : -ENOENT;
-			rc = dat_split_crste(mc, *last, gfn, asce, uses_skeys);
+			rc = dat_split_crste(mc, *last, gfn, datt);
 			if (rc)
 				return rc;
 			entry = READ_ONCE(**last);
@@ -416,7 +418,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		table = dereference_crste(entry.p4d);
 	}
 
-	if (asce.dt >= ASCE_TYPE_REGION3) {
+	if (datt.asce.dt >= ASCE_TYPE_REGION3) {
 		*last = table->crstes + vaddr.rtx;
 		entry = READ_ONCE(**last);
 		if (WARN_ON_ONCE(entry.h.tt != TABLE_TYPE_REGION3))
@@ -433,7 +435,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		if (entry.pud.h.i && !entry.pud.h.fc) {
 			if (!allocate)
 				return any ? 0 : -ENOENT;
-			rc = dat_split_crste(mc, *last, gfn, asce, uses_skeys);
+			rc = dat_split_crste(mc, *last, gfn, datt);
 			if (rc)
 				return rc;
 			entry = READ_ONCE(**last);
@@ -441,7 +443,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 		if (walk_level <= TABLE_TYPE_SEGMENT && entry.pud.h.fc) {
 			if (!split)
 				return -EFBIG;
-			rc = dat_split_crste(mc, *last, gfn, asce, uses_skeys);
+			rc = dat_split_crste(mc, *last, gfn, datt);
 			if (rc)
 				return rc;
 			entry = READ_ONCE(**last);
@@ -465,7 +467,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 	if (entry.pmd.h.i && !entry.pmd.h.fc) {
 		if (!allocate)
 			return any ? 0 : -ENOENT;
-		rc = dat_split_ste(mc, &(*last)->pmd, gfn, asce, uses_skeys);
+		rc = dat_split_ste(mc, &(*last)->pmd, gfn, datt);
 		if (rc)
 			return rc;
 		entry = READ_ONCE(**last);
@@ -473,7 +475,7 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 	if (walk_level <= TABLE_TYPE_PAGE_TABLE && entry.pmd.h.fc) {
 		if (!split)
 			return -EFBIG;
-		rc = dat_split_ste(mc, &(*last)->pmd, gfn, asce, uses_skeys);
+		rc = dat_split_ste(mc, &(*last)->pmd, gfn, datt);
 		if (rc)
 			return rc;
 		entry = READ_ONCE(**last);
@@ -555,7 +557,7 @@ static long dat_crste_walk_range(gfn_t start, gfn_t end, struct crst_table *tabl
  * _dat_walk_gfn_range() - Walk DAT tables.
  * @start: The first guest page frame to walk.
  * @end: The guest page frame immediately after the last one to walk.
- * @asce: The ASCE of the guest mapping.
+ * @datt: The DAT tables of the guest mapping.
  * @ops: The gmap_walk_ops that will be used to perform the walk.
  * @flags: Flags from WALK_* (currently only WALK_IGN_HOLES is supported).
  * @priv: Will be passed as-is to the callbacks.
@@ -566,29 +568,28 @@ static long dat_crste_walk_range(gfn_t start, gfn_t end, struct crst_table *tabl
  *         given ASCE unless the DAT_WALK_IGN_HOLES flag is specified,
  *         otherwise it returns whatever the callbacks return.
  */
-long _dat_walk_gfn_range(gfn_t start, gfn_t end, union asce asce,
+long _dat_walk_gfn_range(gfn_t start, gfn_t end, struct dat_tables datt,
 			 const struct dat_walk_ops *ops, int flags, void *priv)
 {
-	struct crst_table *table = dereference_asce(asce);
 	struct dat_walk walk = {
 		.ops	= ops,
-		.asce	= asce,
+		.datt	= datt,
 		.priv	= priv,
 		.flags	= flags,
 		.start	= start,
 		.end	= end,
 	};
 
-	if (WARN_ON_ONCE(unlikely(!asce.val)))
+	if (WARN_ON_ONCE(unlikely(!datt.asce.val)))
 		return -EINVAL;
-	if (!asce_contains_gfn(asce, start))
+	if (!dat_tables_contain_gfn(datt, start))
 		return (flags & DAT_WALK_IGN_HOLES) ? 0 : -EFAULT;
 
-	return dat_crste_walk_range(start, min(end, asce_end(asce)), table, &walk);
+	return dat_crste_walk_range(start, min(end, dat_tables_end(datt)), datt.table, &walk);
 }
 
 #if KVM_S390_MANAGES_S390_GUEST
-int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
+int dat_get_storage_key(struct dat_tables datt, gfn_t gfn, union skey *skey)
 {
 	union crste *crstep;
 	union pgste pgste;
@@ -597,7 +598,7 @@ int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
 
 again:
 	skey->skey = 0;
-	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
+	rc = dat_entry_walk(NULL, gfn, datt, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
 
@@ -631,7 +632,7 @@ static void dat_update_ptep_sd(union pgste old, union pgste pgste, union pte *pt
 		__atomic64_or(_PAGE_SD, &ptep->val);
 }
 
-int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t gfn,
 			union skey skey, bool nq)
 {
 	union pgste pgste, old;
@@ -640,7 +641,7 @@ int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gf
 	int rc;
 
 again:
-	rc = dat_entry_walk(mc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
+	rc = dat_entry_walk(mc, gfn, datt, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -693,7 +694,7 @@ static bool page_cond_set_storage_key(phys_addr_t paddr, union skey skey, union
 	return true;
 }
 
-int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
+int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, struct dat_tables datt, gfn_t gfn,
 			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc)
 {
 	union pgste pgste, old;
@@ -703,7 +704,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	int rc;
 
 again:
-	rc = dat_entry_walk(mmc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
+	rc = dat_entry_walk(mmc, gfn, datt, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -751,7 +752,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	return rc;
 }
 
-int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
+int dat_reset_reference_bit(struct dat_tables datt, gfn_t gfn, union skey *skey)
 {
 	union pgste pgste, old;
 	union crste *crstep;
@@ -760,7 +761,7 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 
 	skey->skey = 0;
 again:
-	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
+	rc = dat_entry_walk(NULL, gfn, datt, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
 
@@ -828,7 +829,7 @@ static long dat_reset_skeys_crste(union crste *crstep, gfn_t gfn, gfn_t next, st
 	return 0;
 }
 
-long dat_reset_skeys(union asce asce, gfn_t start)
+long dat_reset_skeys(struct dat_tables datt, gfn_t start)
 {
 	const struct dat_walk_ops ops = {
 		.pte_entry = dat_reset_skeys_pte,
@@ -836,7 +837,8 @@ long dat_reset_skeys(union asce asce, gfn_t start)
 		.pud_entry = dat_reset_skeys_crste,
 	};
 
-	return _dat_walk_gfn_range(start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, NULL);
+	return _dat_walk_gfn_range(start, dat_tables_end(datt), datt, &ops,
+				   DAT_WALK_IGN_HOLES, NULL);
 }
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
@@ -852,7 +854,7 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 		return 0;
 
 	pgste = pgste_get_lock(ptep);
-	pgste = __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->asce, false);
+	pgste = __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->datt);
 	pgste.cmma_d = 0;
 	pgste_set_unlock(ptep, pgste);
 
@@ -872,7 +874,7 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 
 	/* This table entry needs to be updated. */
 	if (walk->start <= gfn && walk->end >= next) {
-		if (!dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce))
+		if (!dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->datt.asce))
 			return -EINVAL;
 		/* A lower level table was present, needs to be freed. */
 		if (!crste.h.fc && !crste.h.i) {
@@ -889,7 +891,7 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 		return 0;
 	/* Split (install a lower level table), and handle things there. */
 	if (mc)
-		return dat_split_crste(mc, crstep, gfn, walk->asce, false);
+		return dat_split_crste(mc, crstep, gfn, walk->datt);
 	/* A large page should never cross memslots boundaries */
 	return -EINVAL;
 }
@@ -899,9 +901,9 @@ static const struct dat_walk_ops dat_slot_ops = {
 	.crste_ops = { _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, },
 };
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end)
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t start, gfn_t end)
 {
-	return _dat_walk_gfn_range(start, end, asce, &dat_slot_ops,
+	return _dat_walk_gfn_range(start, end, datt, &dat_slot_ops,
 				   DAT_WALK_IGN_HOLES | DAT_WALK_ANY, mc);
 }
 
@@ -982,7 +984,7 @@ static const struct dat_walk_ops test_age_ops = {
 
 /**
  * dat_test_age_gfn() - Test young.
- * @asce: The ASCE whose address range is to be tested.
+ * @datt: The DAT tables whose address range is to be tested.
  * @start: The first guest frame of the range to check.
  * @end: The guest frame after the last in the range.
  *
@@ -990,9 +992,9 @@ static const struct dat_walk_ops test_age_ops = {
  *
  * Return: %true if any page in the given range is young, otherwise %false.
  */
-bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
+bool dat_test_age_gfn(struct dat_tables datt, gfn_t start, gfn_t end)
 {
-	return _dat_walk_gfn_range(start, end, asce, &test_age_ops, 0, NULL) > 0;
+	return _dat_walk_gfn_range(start, end, datt, &test_age_ops, 0, NULL) > 0;
 }
 
 #if KVM_S390_MANAGES_S390_GUEST
@@ -1009,7 +1011,7 @@ static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 			break;
 		newcrste = oldcrste;
 		newcrste.s.fc1.prefix_notif = 1;
-	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->datt.asce));
 	*n = 2;
 	return 0;
 }
@@ -1029,7 +1031,7 @@ static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wa
 	return 0;
 }
 
-int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+int dat_set_prefix_notif_bit(struct dat_tables datt, gfn_t gfn)
 {
 	static const struct dat_walk_ops ops = {
 		.pte_entry = dat_set_pn_pte,
@@ -1039,7 +1041,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
 
 	int n = 0;
 
-	_dat_walk_gfn_range(gfn, gfn + 2, asce, &ops, DAT_WALK_IGN_HOLES, &n);
+	_dat_walk_gfn_range(gfn, gfn + 2, datt, &ops, DAT_WALK_IGN_HOLES, &n);
 	if (n != 2)
 		return -EAGAIN;
 	return 0;
@@ -1047,7 +1049,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
 
 /**
  * dat_perform_essa() - Perform ESSA actions on the PGSTE.
- * @asce: The asce to operate on.
+ * @datt: The DAT tables to operate on.
  * @gfn: The guest page frame to operate on.
  * @orc: The specific action to perform, see the ESSA_SET_* macros.
  * @state: The storage attributes to be returned to the guest.
@@ -1060,14 +1062,15 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
  * * %0 if the page state has been altered, but the page is not to be added to the CBRL
  * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
  */
-int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
+int dat_perform_essa(struct dat_tables datt, gfn_t gfn, int orc,
+		     union essa_state *state, bool *dirty)
 {
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
 	int res = 0;
 
-	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
+	if (dat_entry_walk(NULL, gfn, datt, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
 		*state = (union essa_state) { .exception = 1 };
 		return -1;
 	}
@@ -1155,13 +1158,13 @@ static long dat_reset_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct da
 	return 0;
 }
 
-long dat_reset_cmma(union asce asce, gfn_t start)
+long dat_reset_cmma(struct dat_tables datt, gfn_t start)
 {
 	const struct dat_walk_ops dat_reset_cmma_ops = {
 		.pte_entry = dat_reset_cmma_pte,
 	};
 
-	return _dat_walk_gfn_range(start, asce_end(asce), asce, &dat_reset_cmma_ops,
+	return _dat_walk_gfn_range(start, dat_tables_end(datt), datt, &dat_reset_cmma_ops,
 				   DAT_WALK_IGN_HOLES, NULL);
 }
 
@@ -1195,7 +1198,7 @@ static long __dat_peek_cmma_crste(union crste *crstep, gfn_t gfn, gfn_t next, st
 	return 0;
 }
 
-int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
+int dat_peek_cmma(gfn_t start, struct dat_tables datt, unsigned int *count, u8 *values)
 {
 	const struct dat_walk_ops ops = {
 		.pte_entry = __dat_peek_cmma_pte,
@@ -1207,7 +1210,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
 	struct dat_get_cmma_state state = { .values = values, };
 	int rc;
 
-	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
+	rc = _dat_walk_gfn_range(start, start + *count, datt, &ops, DAT_WALK_DEFAULT, &state);
 	*count = state.end >= start ? state.end - start : 0;
 	/* Return success if at least one value was saved, otherwise an error. */
 	return (rc == -EFAULT && *count > 0) ? 0 : rc;
@@ -1241,7 +1244,8 @@ static long __dat_get_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct da
 	return 0;
 }
 
-int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values, atomic64_t *rem)
+int dat_get_cmma(struct dat_tables datt, gfn_t *start, unsigned int *count,
+		 u8 *values, atomic64_t *rem)
 {
 	const struct dat_walk_ops ops = { .pte_entry = __dat_get_cmma_pte, };
 	struct dat_get_cmma_state state = {
@@ -1251,10 +1255,10 @@ int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values,
 		.start = -1,
 	};
 
-	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, &state);
+	_dat_walk_gfn_range(*start, dat_tables_end(datt), datt, &ops, DAT_WALK_IGN_HOLES, &state);
 	/* If no dirty pages were found, wrap around and continue searching */
 	if (*start && state.start == -1)
-		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
+		_dat_walk_gfn_range(0, *start, datt, &ops, DAT_WALK_IGN_HOLES, &state);
 
 	if (state.start == -1) {
 		*count = 0;
@@ -1289,7 +1293,7 @@ static long __dat_set_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct da
 /**
  * dat_set_cmma_bits() - Set CMMA bits for a range of guest pages.
  * @mc: Cache used for allocations.
- * @asce: The ASCE of the guest.
+ * @datt: The DAT tables of the guest.
  * @gfn: The guest frame of the fist page whose CMMA bits are to set.
  * @count: How many pages need to be processed.
  * @mask: Which PGSTE bits should be set.
@@ -1304,7 +1308,7 @@ static long __dat_set_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct da
  *
  * Return: %0 in case of success, a negative error value otherwise.
  */
-int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t gfn,
 		      unsigned long count, unsigned long mask, const uint8_t *bits)
 {
 	const struct dat_walk_ops ops = { .pte_entry = __dat_set_cmma_pte, };
@@ -1315,11 +1319,11 @@ int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 	int rc;
 
 	for (cur = ALIGN_DOWN(gfn, _PAGE_ENTRIES); cur < gfn + count; cur += _PAGE_ENTRIES) {
-		rc = dat_entry_walk(mc, cur, asce, DAT_WALK_ALLOC, TABLE_TYPE_PAGE_TABLE,
+		rc = dat_entry_walk(mc, cur, datt, DAT_WALK_ALLOC, TABLE_TYPE_PAGE_TABLE,
 				    &crstep, &ptep);
 		if (rc)
 			return rc;
 	}
-	return _dat_walk_gfn_range(gfn, gfn + count, asce, &ops, DAT_WALK_IGN_HOLES, &state);
+	return _dat_walk_gfn_range(gfn, gfn + count, datt, &ops, DAT_WALK_IGN_HOLES, &state);
 }
 #endif /* KVM_S390_MANAGES_S390_GUEST */
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 8af4409332e4..319a8670fb10 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -27,9 +27,6 @@
 /* For consistency */
 #define KVM_S390_CMMA_SIZE_MAX ((u32)KVM_S390_SKEYS_MAX)
 
-#define _ASCE(x) ((union asce) { .val = (x), })
-#define NULL_ASCE _ASCE(0)
-
 enum {
 	_DAT_TOKEN_NONE = 0,
 	_DAT_TOKEN_PIC,
@@ -55,7 +52,6 @@ enum {
 #define TABLE_TYPE_PAGE_TABLE -1
 
 enum dat_walk_flags {
-	DAT_WALK_USES_SKEYS	= 0x40,
 	DAT_WALK_CONTINUE	= 0x20,
 	DAT_WALK_IGN_HOLES	= 0x10,
 	DAT_WALK_SPLIT		= 0x08,
@@ -353,6 +349,15 @@ struct page_table {
 static_assert(sizeof(struct crst_table) == _CRST_TABLE_SIZE);
 static_assert(sizeof(struct page_table) == PAGE_SIZE);
 
+struct dat_tables {
+	union asce asce;
+	struct crst_table *table;
+	bool has_pgstes;	/* Need to use the PCL lock */
+	bool owns_ptes;		/* The ptes are owned by this instance */
+	bool uses_skeys;	/* Storage keys are in use */
+	bool uses_cmma;		/* CMMA is in use */
+};
+
 struct dat_walk;
 
 typedef long (*dat_walk_op)(union crste *crste, gfn_t gfn, gfn_t next, struct dat_walk *w);
@@ -374,7 +379,7 @@ struct dat_walk {
 	const struct dat_walk_ops *ops;
 	union crste *last;
 	union pte *last_pte;
-	union asce asce;
+	struct dat_tables datt;
 	gfn_t start;
 	gfn_t end;
 	int flags;
@@ -523,52 +528,53 @@ struct guest_fault {
 #define PTVAL_VMADDR	MKPTVAL(8, 6)
 
 union pgste __must_check __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new,
-					 gfn_t gfn, union asce asce, bool uses_skeys);
+					 gfn_t gfn, struct dat_tables datt);
 bool dat_crstep_xchg_atomic(union crste *crstep, union crste old, union crste new, gfn_t gfn,
 			    union asce asce);
-void dat_crstep_xchg(union crste *crstep, union crste new, gfn_t gfn, union asce asce);
 
-long _dat_walk_gfn_range(gfn_t start, gfn_t end, union asce asce,
+long _dat_walk_gfn_range(gfn_t start, gfn_t end, struct dat_tables datt,
 			 const struct dat_walk_ops *ops, int flags, void *priv);
 
-int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, int flags,
+int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, struct dat_tables datt, int flags,
 		   int walk_level, union crste **last, union pte **ptepp);
 void dat_free_level(struct crst_table *table, bool owns_ptes);
 struct crst_table *dat_alloc_crst_sleepable(unsigned long init);
-int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, int newtype);
+int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, struct dat_tables *datt, int newtype);
 
 #if KVM_S390_MANAGES_S390_GUEST
-int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey);
-int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+int dat_get_storage_key(struct dat_tables datt, gfn_t gfn, union skey *skey);
+int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t gfn,
 			union skey skey, bool nq);
-int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
+int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, struct dat_tables datt, gfn_t gfn,
 			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
-int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey);
-long dat_reset_skeys(union asce asce, gfn_t start);
+int dat_reset_reference_bit(struct dat_tables datt, gfn_t gfn, union skey *skey);
+long dat_reset_skeys(struct dat_tables datt, gfn_t start);
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end);
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t start, gfn_t end);
 
 #if KVM_S390_MANAGES_S390_GUEST
-int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
+int dat_set_prefix_notif_bit(struct dat_tables datt, gfn_t gfn);
 #else
-static inline int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+static inline int dat_set_prefix_notif_bit(struct dat_tables datt, gfn_t gfn)
 {
 	return 0;
 }
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
-bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
+bool dat_test_age_gfn(struct dat_tables datt, gfn_t start, gfn_t end);
 
 #if KVM_S390_MANAGES_S390_GUEST
-int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty);
-long dat_reset_cmma(union asce asce, gfn_t start_gfn);
-int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values);
-int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values, atomic64_t *rem);
-int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+int dat_perform_essa(struct dat_tables datt, gfn_t gfn, int orc,
+		     union essa_state *state, bool *dirty);
+long dat_reset_cmma(struct dat_tables datt, gfn_t start_gfn);
+int dat_peek_cmma(gfn_t start, struct dat_tables datt, unsigned int *count, u8 *values);
+int dat_get_cmma(struct dat_tables datt, gfn_t *start, unsigned int *count,
+		 u8 *values, atomic64_t *rem);
+int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, struct dat_tables datt, gfn_t gfn,
 		      unsigned long count, unsigned long mask, const uint8_t *bits);
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
@@ -597,6 +603,11 @@ static inline struct vsie_rmap *kvm_s390_mmu_cache_alloc_rmap(struct kvm_s390_mm
 	return kzalloc_obj(struct vsie_rmap, GFP_KVM_S390_MMU_CACHE);
 }
 
+static inline bool has_pgstes(struct dat_tables datt)
+{
+	return KVM_S390_MANAGES_S390_GUEST && datt.has_pgstes;
+}
+
 static inline struct crst_table *crste_table_start(union crste *crstep)
 {
 	return (struct crst_table *)ALIGN_DOWN((unsigned long)crstep, _CRST_TABLE_SIZE);
@@ -688,6 +699,11 @@ static inline gfn_t asce_end(union asce asce)
 	return 1ULL << ((asce.dt + 1) * 11 + _SEGMENT_SHIFT - PAGE_SHIFT);
 }
 
+static inline gfn_t dat_tables_end(struct dat_tables datt)
+{
+	return asce_end(datt.asce);
+}
+
 #define _CRSTE(x) ((union crste) { .val = _Generic((x),	\
 			union pgd : (x).val,		\
 			union p4d : (x).val,		\
@@ -714,6 +730,11 @@ static inline bool asce_contains_gfn(union asce asce, gfn_t gfn)
 	return gfn < asce_end(asce);
 }
 
+static inline bool dat_tables_contain_gfn(struct dat_tables datt, gfn_t gfn)
+{
+	return asce_contains_gfn(datt.asce, gfn);
+}
+
 static inline bool is_pmd(union crste crste)
 {
 	return crste.h.tt == TABLE_TYPE_SEGMENT;
@@ -879,11 +900,6 @@ static inline struct crst_table *_dereference_crste(union crste crste)
 		union pgd : _dereference_crste(_CRSTE(x)),	\
 		union crste : _dereference_crste(_CRSTE(x))))
 
-static inline struct crst_table *dereference_asce(union asce asce)
-{
-	return phys_to_virt(asce.val & _ASCE_ORIGIN);
-}
-
 static inline void asce_flush_tlb(union asce asce)
 {
 	__tlb_flush_idte(asce.val);
@@ -920,19 +936,18 @@ static inline void pgste_set_unlock(union pte *ptep, union pgste pgste)
 	WRITE_ONCE(*pgste_of(ptep), pgste);
 }
 
-static inline void dat_ptep_xchg(union pte *ptep, union pte new, gfn_t gfn, union asce asce,
-				 bool has_skeys)
+static inline void dat_ptep_xchg(union pte *ptep, union pte new, gfn_t gfn, struct dat_tables datt)
 {
 	union pgste pgste;
 
 	pgste = pgste_get_lock(ptep);
-	pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, asce, has_skeys);
+	pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, datt);
 	pgste_set_unlock(ptep, pgste);
 }
 
-static inline void dat_ptep_clear(union pte *ptep, gfn_t gfn, union asce asce, bool has_skeys)
+static inline void dat_ptep_clear(union pte *ptep, gfn_t gfn, struct dat_tables datt)
 {
-	dat_ptep_xchg(ptep, _PTE_EMPTY, gfn, asce, has_skeys);
+	dat_ptep_xchg(ptep, _PTE_EMPTY, gfn, datt);
 }
 
 static inline void dat_free_pt(struct page_table *pt)
@@ -999,15 +1014,15 @@ static inline int get_level(union crste *crstep, union pte *ptep)
 	return ptep ? TABLE_TYPE_PAGE_TABLE : crstep->h.tt;
 }
 
-static inline int dat_delete_slot(union asce asce, gfn_t start, unsigned long npages)
+static inline int dat_delete_slot(struct dat_tables datt, gfn_t start, unsigned long npages)
 {
-	return dat_set_slot(NULL, asce, start, start + npages);
+	return dat_set_slot(NULL, datt, start, start + npages);
 }
 
-static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start,
-				  unsigned long npages)
+static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, struct dat_tables datt,
+				  gfn_t start, unsigned long npages)
 {
-	return dat_set_slot(mc, asce, start, start + npages);
+	return dat_set_slot(mc, datt, start, start + npages);
 }
 
 static inline bool crste_is_ucas(union crste crste)
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index bf7f27d6be96..cb8f247cff60 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -46,8 +46,8 @@ static int gmap_limit_to_type(gfn_t limit)
  */
 struct gmap *gmap_new(struct kvm *kvm, gfn_t limit)
 {
+	struct gmap *gmap __free(kfree) = NULL;
 	struct crst_table *table;
-	struct gmap *gmap;
 	int type;
 
 	type = gmap_limit_to_type(limit);
@@ -64,27 +64,27 @@ struct gmap *gmap_new(struct kvm *kvm, gfn_t limit)
 	refcount_set(&gmap->refcount, 1);
 
 	table = dat_alloc_crst_sleepable(_CRSTE_EMPTY(type).val);
-	if (!table) {
-		kfree(gmap);
+	if (!table)
 		return NULL;
-	}
 
-	gmap->asce.val = __pa(table);
-	gmap->asce.dt = type;
-	gmap->asce.tl = _ASCE_TABLE_LENGTH;
-	gmap->asce.x = 1;
-	gmap->asce.p = 1;
-	gmap->asce.s = 1;
+	gmap->datt.table = table;
+	gmap->datt.asce.val = __pa(table);
+	gmap->datt.asce.dt = type;
+	gmap->datt.asce.tl = _ASCE_TABLE_LENGTH;
+	gmap->datt.asce.x = 1;
+	gmap->datt.asce.p = 1;
+	gmap->datt.asce.s = 1;
 	gmap->kvm = kvm;
-	set_bit(GMAP_FLAG_OWNS_PAGETABLES, &gmap->flags);
+	gmap->datt.owns_ptes = true;
+	gmap->datt.has_pgstes = KVM_S390_MANAGES_S390_GUEST && !(sclp.has_kss && cpu_has_edat2());
 
-	return gmap;
+	return_ptr(gmap);
 }
 
 static void gmap_add_child(struct gmap *parent, struct gmap *child)
 {
 	KVM_BUG_ON(is_ucontrol(parent) && parent->parent, parent->kvm);
-	KVM_BUG_ON(is_ucontrol(parent) && !owns_page_tables(parent), parent->kvm);
+	KVM_BUG_ON(is_ucontrol(parent) && !parent->datt.owns_ptes, parent->kvm);
 	KVM_BUG_ON(!refcount_read(&child->refcount), parent->kvm);
 	lockdep_assert_held(&parent->children_lock);
 
@@ -105,8 +105,11 @@ static void gmap_add_child(struct gmap *parent, struct gmap *child)
 	else
 		clear_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &child->flags);
 
-	if (kvm_is_ucontrol(parent->kvm))
-		clear_bit(GMAP_FLAG_OWNS_PAGETABLES, &child->flags);
+	if (kvm_is_ucontrol(parent->kvm)) {
+		child->datt.owns_ptes = false;
+		child->datt.uses_skeys = true;
+	}
+	child->datt.has_pgstes = true;
 	list_add(&child->list, &parent->children);
 }
 
@@ -139,7 +142,7 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 		if (rc)
 			return rc;
 		scoped_guard(write_lock, &gmap->kvm->mmu_lock)
-			rc = dat_set_asce_limit(mc, &gmap->asce, type);
+			rc = dat_set_asce_limit(mc, &gmap->datt, type);
 	} while (rc == -ENOMEM);
 
 	return 0;
@@ -196,15 +199,15 @@ void gmap_dispose(struct gmap *gmap)
 	/* No VSIE shadow block is allowed to use this gmap */
 	KVM_BUG_ON(!list_empty(&gmap->scb_users), gmap->kvm);
 	/* The ASCE must be valid */
-	KVM_BUG_ON(!gmap->asce.val, gmap->kvm);
+	KVM_BUG_ON(!gmap->datt.asce.val, gmap->kvm);
 	/* The refcount must be 0 */
 	KVM_BUG_ON(refcount_read(&gmap->refcount), gmap->kvm);
 
 	/* Flush tlb of all gmaps */
-	asce_flush_tlb(gmap->asce);
+	asce_flush_tlb(gmap->datt.asce);
 
 	/* Free all DAT tables. */
-	dat_free_level(dereference_asce(gmap->asce), owns_page_tables(gmap));
+	dat_free_level(gmap->datt.table, gmap->datt.owns_ptes);
 
 	/* Free additional data for a shadow gmap */
 	if (is_shadow(gmap))
@@ -232,21 +235,25 @@ void gmap_dispose(struct gmap *gmap)
 int s390_replace_asce(struct gmap *gmap)
 {
 	struct crst_table *table;
-	union asce asce;
 
 	/* Replacing segment type ASCEs would cause serious issues */
-	if (gmap->asce.dt == ASCE_TYPE_SEGMENT)
+	if (gmap->datt.asce.dt == ASCE_TYPE_SEGMENT)
 		return -EINVAL;
 
 	table = dat_alloc_crst_sleepable(0);
 	if (!table)
 		return -ENOMEM;
-	memcpy(table, dereference_asce(gmap->asce), sizeof(*table));
 
 	/* Set new table origin while preserving existing ASCE control bits */
-	asce = gmap->asce;
-	asce.rsto = virt_to_pfn(table);
-	WRITE_ONCE(gmap->asce, asce);
+	scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
+		memcpy(table, gmap->datt.table, sizeof(*table));
+		if (gmap->datt.asce.dt == ASCE_TYPE_SEGMENT) {
+			dat_free_crst(table);
+			return -EINVAL;
+		}
+		gmap->datt.asce.rsto = virt_to_pfn(table);
+		gmap->datt.table = table;
+	}
 
 	return 0;
 }
@@ -308,7 +315,7 @@ static long gmap_clear_young_pte(union pte *ptep, gfn_t gfn, gfn_t end, struct d
 		new.h.p = 1;
 
 		new.s.prefix_notif = 0;
-		pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, walk->asce, uses_skeys(p->gmap));
+		pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, walk->datt);
 	}
 	p->young = 1;
 	pgste_set_unlock(ptep, pgste);
@@ -338,7 +345,7 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-	} while (!dat_crstep_xchg_atomic(crstep, crste, new, gfn, walk->asce));
+	} while (!dat_crstep_xchg_atomic(crstep, crste, new, gfn, walk->datt.asce));
 
 	priv->young = 1;
 	return 0;
@@ -365,7 +372,7 @@ bool gmap_age_gfn(struct gmap *gmap, gfn_t start, gfn_t end)
 		.young = false,
 	};
 
-	_dat_walk_gfn_range(start, end, gmap->asce, &ops, 0, &priv);
+	_dat_walk_gfn_range(start, end, gmap->datt, &ops, 0, &priv);
 
 	return priv.young;
 }
@@ -454,7 +461,7 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t
 
 	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
 
-	_dat_walk_gfn_range(start, end, gmap->asce, &ops, 0, &priv);
+	_dat_walk_gfn_range(start, end, gmap->datt, &ops, 0, &priv);
 	return false;
 }
 
@@ -536,7 +543,7 @@ void gmap_sync_dirty_log(struct gmap *gmap, gfn_t start, gfn_t end)
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 
-	_dat_walk_gfn_range(start, end, gmap->asce, &walk_ops, 0, gmap);
+	_dat_walk_gfn_range(start, end, gmap->datt, &walk_ops, 0, gmap);
 }
 
 static int gmap_handle_minor_crste_fault(struct gmap *gmap, struct guest_fault *f)
@@ -618,7 +625,7 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 
-	rc = dat_entry_walk(NULL, fault->gfn, gmap->asce, DAT_WALK_LEAF, TABLE_TYPE_PAGE_TABLE,
+	rc = dat_entry_walk(NULL, fault->gfn, gmap->datt, DAT_WALK_LEAF, TABLE_TYPE_PAGE_TABLE,
 			    &fault->crstep, &fault->ptep);
 	/* If a PTE or a leaf CRSTE could not be reached, slow path. */
 	if (rc)
@@ -692,7 +699,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 	union pgste pgste;
 	int rc = 0;
 
-	rc = dat_entry_walk(mc, f->gfn, gmap->asce, DAT_WALK_ALLOC_CONTINUE, level,
+	rc = dat_entry_walk(mc, f->gfn, gmap->datt, DAT_WALK_ALLOC_CONTINUE, level,
 			    &f->crstep, &f->ptep);
 	if (rc == -ENOMEM)
 		return rc;
@@ -766,10 +773,10 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 	int rc;
 
 	if (force_alloc)
-		rc = dat_entry_walk(mc, p_gfn, gmap->parent->asce, DAT_WALK_ALLOC,
+		rc = dat_entry_walk(mc, p_gfn, gmap->parent->datt, DAT_WALK_ALLOC,
 				    TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	else
-		rc = dat_entry_walk(mc, p_gfn, gmap->parent->asce, DAT_WALK_ALLOC_CONTINUE,
+		rc = dat_entry_walk(mc, p_gfn, gmap->parent->datt, DAT_WALK_ALLOC_CONTINUE,
 				    TABLE_TYPE_SEGMENT, &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -782,7 +789,7 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 		dat_set_ptval(pt, PTVAL_VMADDR, p_gfn >> (_SEGMENT_SHIFT - PAGE_SHIFT));
 		newcrste = _crste_fc0(virt_to_pfn(pt), TABLE_TYPE_SEGMENT);
 	}
-	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
+	rc = dat_entry_walk(mc, c_gfn, gmap->datt, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -790,7 +797,7 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 		oldcrste = READ_ONCE(*crstep);
 		if (oldcrste.val == newcrste.val)
 			break;
-	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, c_gfn, gmap->asce));
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, c_gfn, gmap->datt.asce));
 	return 0;
 }
 
@@ -799,7 +806,7 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce, DAT_WALK_CONTINUE,
+	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->datt, DAT_WALK_CONTINUE,
 			    TABLE_TYPE_SEGMENT, crstepp, &ptep);
 	if (rc || (!ptep && !crste_is_ucas(**crstepp)))
 		return -EREMOTE;
@@ -893,10 +900,11 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
+	rc = dat_entry_walk(NULL, c_gfn, gmap->datt, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
 	if (rc)
 		return;
-	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY, c_gfn, gmap->asce))
+	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY,
+				       c_gfn, gmap->datt.asce))
 		;
 }
 
@@ -921,7 +929,7 @@ static long _gmap_split_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 			gmap_unmap_prefix(gmap, gfn, next);
 		if (crste.s.fc1.vsie_notif)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
-		if (dat_crstep_xchg_atomic(crstep, crste, newcrste, gfn, walk->asce))
+		if (dat_crstep_xchg_atomic(crstep, crste, newcrste, gfn, walk->datt.asce))
 			break;
 		crste = READ_ONCE(*crstep);
 	}
@@ -942,7 +950,7 @@ void gmap_split_huge_pages(struct gmap *gmap)
 
 	do {
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
-			start = _dat_walk_gfn_range(start, asce_end(gmap->asce), gmap->asce,
+			start = _dat_walk_gfn_range(start, dat_tables_end(gmap->datt), gmap->datt,
 						    &ops, DAT_WALK_IGN_HOLES, gmap);
 	} while (start);
 }
@@ -957,16 +965,17 @@ static int _gmap_enable_skeys(struct gmap *gmap)
 	if (uses_skeys(gmap))
 		return 0;
 
-	set_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
+	gmap->datt.uses_skeys = true;
+	gmap->datt.has_pgstes = true;
 	rc = gmap_helper_disable_cow_sharing();
 	if (rc) {
-		clear_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
+		gmap->datt.uses_skeys = false;
 		return rc;
 	}
 
 	do {
 		scoped_guard(write_lock, &gmap->kvm->mmu_lock)
-			start = dat_reset_skeys(gmap->asce, start);
+			start = dat_reset_skeys(gmap->datt, start);
 	} while (start);
 	return 0;
 }
@@ -1021,7 +1030,7 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interr
 
 	do {
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
-			start = _dat_walk_gfn_range(start, end, gmap->asce, &ops,
+			start = _dat_walk_gfn_range(start, end, gmap->datt, &ops,
 						    DAT_WALK_IGN_HOLES, NULL);
 		if (interruptible && fatal_signal_pending(current))
 			return -EINTR;
@@ -1073,14 +1082,13 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	union pgste pgste;
 	union pte *ptep;
 	union pte pte;
-	int flags, rc;
+	int rc;
 
 	if (KVM_BUG_ON(!is_shadow(sg) || level <= TABLE_TYPE_PAGE_TABLE, sg->kvm))
 		return -EINVAL;
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
-	rc = dat_entry_walk(mc, p_gfn, sg->parent->asce, flags,
+	rc = dat_entry_walk(mc, p_gfn, sg->parent->datt, DAT_WALK_SPLIT_ALLOC,
 			    TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -1141,8 +1149,8 @@ void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
 
 	do {
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
-			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
-						  DAT_WALK_IGN_HOLES,
+			gfn = _dat_walk_gfn_range(gfn, dat_tables_end(gmap->datt), gmap->datt,
+						  &ops, DAT_WALK_IGN_HOLES,
 						  &gmap->kvm->arch.cmma_dirty_pages);
 	} while (gfn);
 }
@@ -1160,15 +1168,15 @@ static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 		align = 1UL << (11 * level + _SEGMENT_SHIFT);
 	kvm_s390_vsie_gmap_notifier(sg, ALIGN_DOWN(gaddr, align), ALIGN(gaddr + 1, align));
 	sg->invalidated = true;
-	if (dat_entry_walk(NULL, r_gfn, sg->asce, 0, level, &crstep, &ptep))
+	if (dat_entry_walk(NULL, r_gfn, sg->datt, 0, level, &crstep, &ptep))
 		return;
 	if (ptep) {
 		if (READ_ONCE(*ptep).val != _PTE_EMPTY.val)
-			dat_ptep_xchg(ptep, _PTE_EMPTY, r_gfn, sg->asce, uses_skeys(sg));
+			dat_ptep_xchg(ptep, _PTE_EMPTY, r_gfn, sg->datt);
 		return;
 	}
 
-	crste = dat_crstep_clear_atomic(crstep, r_gfn, sg->asce);
+	crste = dat_crstep_clear_atomic(crstep, r_gfn, sg->datt.asce);
 	if (crste_leaf(crste) || crste.h.i)
 		return;
 	if (is_pmd(crste))
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 4042e1d4e77c..c40a49b30618 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -18,28 +18,20 @@
  * enum gmap_flags - Flags of a gmap.
  *
  * @GMAP_FLAG_SHADOW: The gmap is a vsie shadow gmap.
- * @GMAP_FLAG_OWNS_PAGETABLES: The gmap owns all dat levels; normally 1, is 0
- *                             only for ucontrol per-cpu gmaps, since they
- *                             share the page tables with the main gmap.
  * @GMAP_FLAG_IS_UCONTROL: The gmap is ucontrol (main gmap or per-cpu gmap).
  * @GMAP_FLAG_ALLOW_HPAGE_1M: 1M hugepages are allowed for this gmap,
  *                            independently of the page size used by userspace.
  * @GMAP_FLAG_ALLOW_HPAGE_2G: 2G hugepages are allowed for this gmap,
  *                            independently of the page size used by userspace.
  * @GMAP_FLAG_PFAULT_ENABLED: Pfault is enabled for the gmap.
- * @GMAP_FLAG_USES_SKEYS: If the guest uses storage keys.
- * @GMAP_FLAG_USES_CMM: Whether the guest uses CMMA.
  * @GMAP_FLAG_EXPORT_ON_UNMAP: Whether to export guest pages when unmapping.
  */
 enum gmap_flags {
 	GMAP_FLAG_SHADOW = 0,
-	GMAP_FLAG_OWNS_PAGETABLES,
 	GMAP_FLAG_IS_UCONTROL,
 	GMAP_FLAG_ALLOW_HPAGE_1M,
 	GMAP_FLAG_ALLOW_HPAGE_2G,
 	GMAP_FLAG_PFAULT_ENABLED,
-	GMAP_FLAG_USES_SKEYS,
-	GMAP_FLAG_USES_CMM,
 	GMAP_FLAG_EXPORT_ON_UNMAP,
 };
 
@@ -49,7 +41,7 @@ enum gmap_flags {
  * @flags: GMAP_FLAG_* flags.
  * @edat_level: The edat level of this shadow gmap.
  * @kvm: The vm.
- * @asce: The ASCE used by this gmap.
+ * @datt: The DAT tables used by this gmap.
  * @list: List head used in children gmaps for the children gmap list.
  * @children_lock: Protects children and scb_users.
  * @children: List of child gmaps of this gmap.
@@ -64,7 +56,7 @@ struct gmap {
 	unsigned char edat_level;
 	bool invalidated;
 	struct kvm *kvm;
-	union asce asce;
+	struct dat_tables datt;
 	struct list_head list;
 	spinlock_t children_lock;	/* Protects: children, scb_users */
 	struct list_head children;
@@ -116,12 +108,12 @@ void gmap_split_huge_pages(struct gmap *gmap);
 
 static inline bool uses_skeys(struct gmap *gmap)
 {
-	return test_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
+	return has_pgstes(gmap->datt) && gmap->datt.uses_skeys;
 }
 
 static inline bool uses_cmm(struct gmap *gmap)
 {
-	return test_bit(GMAP_FLAG_USES_CMM, &gmap->flags);
+	return has_pgstes(gmap->datt) && gmap->datt.uses_cmma;
 }
 
 static inline bool pfault_enabled(struct gmap *gmap)
@@ -139,11 +131,6 @@ static inline bool is_shadow(struct gmap *gmap)
 	return test_bit(GMAP_FLAG_SHADOW, &gmap->flags);
 }
 
-static inline bool owns_page_tables(struct gmap *gmap)
-{
-	return test_bit(GMAP_FLAG_OWNS_PAGETABLES, &gmap->flags);
-}
-
 static inline struct gmap *gmap_put(struct gmap *gmap)
 {
 	if (refcount_dec_and_test(&gmap->refcount))
@@ -247,7 +234,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
 		SetPageDirty(pfn_to_page(newpte.h.pfra));
 	pgste.zero = 0;
-	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
+	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->datt);
 }
 
 static inline union pgste gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
@@ -305,7 +292,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
-		if (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce))
+		if (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->datt.asce))
 			return false;
 		/*
 		 * Return false even if the swap was successful, as it only
@@ -319,7 +306,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
 		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
-	return dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+	return dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->datt.asce);
 }
 
 static inline bool __must_check gmap_crstep_xchg_atomic(struct gmap *gmap, union crste *crstep,
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index c2ffb5e59ec6..784c4aae5995 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -72,7 +72,7 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
-		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+		if (!dat_tables_contain_gfn(kvm->arch.gmap->datt, new->base_gfn + new->npages - 1))
 			return -EINVAL;
 	}
 
@@ -102,9 +102,9 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		kvm_s390_update_cmma_dirty(kvm, old);
 		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
-			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->datt, old->base_gfn, old->npages);
 		if (!rc && (change == KVM_MR_MOVE || change == KVM_MR_CREATE))
-			rc = dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npages);
+			rc = dat_create_slot(mc, kvm->arch.gmap->datt, new->base_gfn, new->npages);
 	}
 	/*
 	 * Can only be triggered if dat_{create,delete}_slot() found an
diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
index 8dc5b93ef01c..eff16f9edfad 100644
--- a/arch/s390/kvm/s390/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -653,7 +653,7 @@ static int vm_check_access_key_gpa(struct kvm *kvm, u8 access_key,
 	int r;
 
 	scoped_guard(read_lock, &kvm->mmu_lock)
-		r = dat_get_storage_key(kvm->arch.gmap->asce, gpa_to_gfn(gpa), &storage_key);
+		r = dat_get_storage_key(kvm->arch.gmap->datt, gpa_to_gfn(gpa), &storage_key);
 	if (r)
 		return r;
 	if (access_key == 0 || storage_key.acc == access_key)
@@ -712,7 +712,7 @@ static int vcpu_check_access_key_gpa(struct kvm_vcpu *vcpu, u8 access_key,
 	 * assume that this cannot fail
 	 */
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		r = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gpa), &storage_key);
+		r = dat_get_storage_key(vcpu->arch.gmap->datt, gpa_to_gfn(gpa), &storage_key);
 	if (r)
 		return r;
 	/* access key matches storage key -> allow */
@@ -1286,7 +1286,7 @@ static int walk_guest_tables(struct gmap *sg, unsigned long saddr, struct pgtwal
 		return -EAGAIN;
 	kvm = parent->kvm;
 	WARN_ON(!kvm);
-	asce = sg->guest_asce;
+	asce.val = sg->guest_asce.val;
 	entries = get_entries(w);
 
 	w->level = LEVEL_MEM;
@@ -1452,7 +1452,7 @@ static int _do_shadow_pte(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_t
 	newpte = _pte(f->pfn, 0, !p, 0);
 	if (!pgste_get_trylock(ptep, &pgste))
 		return -EAGAIN;
-	pgste = __dat_ptep_xchg(ptep, pgste, newpte, gpa_to_gfn(raddr), sg->asce, uses_skeys(sg));
+	pgste = __dat_ptep_xchg(ptep, pgste, newpte, gpa_to_gfn(raddr), sg->datt);
 	pgste_set_unlock(ptep, pgste);
 
 	return 0;
@@ -1495,7 +1495,7 @@ static int _do_shadow_crste(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_
 		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
-	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gfn, sg->asce))
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, r_gfn, sg->datt.asce))
 		;
 	return 0;
 }
@@ -1504,9 +1504,9 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			      unsigned long saddr, struct pgtwalk *w)
 {
 	struct guest_fault *entries;
-	int flags, i, hl, gl, l, rc;
 	union crste *table, *host;
 	union pte *ptep, *ptep_h;
+	int i, hl, gl, l, rc;
 
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
@@ -1515,8 +1515,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	ptep_h = NULL;
 	ptep = NULL;
 
-	rc = dat_entry_walk(NULL, gpa_to_gfn(saddr), sg->asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE,
-			    &table, &ptep);
+	rc = dat_entry_walk(NULL, gpa_to_gfn(saddr), sg->datt, DAT_WALK_ANY,
+			    TABLE_TYPE_PAGE_TABLE, &table, &ptep);
 	if (rc)
 		return rc;
 
@@ -1547,7 +1547,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 			return -EAGAIN;
 	}
 
-	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
+	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->datt, DAT_WALK_LEAF,
 			    TABLE_TYPE_PAGE_TABLE, &host, &ptep_h);
 	if (rc)
 		return rc;
@@ -1557,16 +1557,16 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	l = min3(gl, hl, w->level);
 
 real_address_space:
-	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
 	/* If necessary, create the shadow mapping */
 	if (l < gl) {
-		rc = dat_entry_walk(mc, gpa_to_gfn(saddr), sg->asce, flags, l, &table, &ptep);
+		rc = dat_entry_walk(mc, gpa_to_gfn(saddr), sg->datt, DAT_WALK_SPLIT_ALLOC, l,
+				    &table, &ptep);
 		if (rc)
 			return rc;
 	}
 	if (l < hl) {
-		rc = dat_entry_walk(mc, entries[LEVEL_MEM].gfn, sg->parent->asce,
-				    flags, l, &host, &ptep_h);
+		rc = dat_entry_walk(mc, entries[LEVEL_MEM].gfn, sg->parent->datt,
+				    DAT_WALK_SPLIT_ALLOC, l, &host, &ptep_h);
 		if (rc)
 			return rc;
 	}
diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b3cb2c2c3aa7..1d9e81f6429b 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -276,7 +276,7 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
 	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr), &key);
+		rc = dat_get_storage_key(vcpu->arch.gmap->datt, gpa_to_gfn(gaddr), &key);
 	if (rc > 0)
 		return kvm_s390_inject_program_int(vcpu, rc);
 	if (rc < 0)
@@ -308,7 +308,7 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
 	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr), &skey);
+		rc = dat_reset_reference_bit(vcpu->arch.gmap->datt, gpa_to_gfn(gaddr), &skey);
 	if (rc > 0)
 		return kvm_s390_inject_program_int(vcpu, rc);
 	if (rc < 0)
@@ -360,7 +360,7 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 
 	while (start != end) {
 		scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
-			rc = dat_cond_set_storage_key(vcpu->arch.mc, vcpu->arch.gmap->asce,
+			rc = dat_cond_set_storage_key(vcpu->arch.mc, vcpu->arch.gmap->datt,
 						      gpa_to_gfn(start), key, &oldkey,
 						      m3 & SSKE_NQ, m3 & SSKE_MR, m3 & SSKE_MC);
 		}
@@ -1118,7 +1118,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc)
 				return rc;
 			scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
-				rc = dat_cond_set_storage_key(vcpu->arch.mc, vcpu->arch.gmap->asce,
+				rc = dat_cond_set_storage_key(vcpu->arch.mc, vcpu->arch.gmap->datt,
 							      gpa_to_gfn(start), key,
 							      NULL, nq, mr, mc);
 			}
@@ -1167,7 +1167,7 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	gfn = vcpu->run->s.regs.gprs[r2] >> PAGE_SHIFT;
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
-	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
+	nappended = dat_perform_essa(vcpu->arch.gmap->datt, gfn, orc, &state, &dirtied);
 	vcpu->run->s.regs.gprs[r1] = state.val;
 	if (nappended < 0)
 		return 0;
@@ -1199,7 +1199,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 	lockdep_assert_held(&vcpu->kvm->mmu_lock);
 
 	for (i = 0; i < len; i++) {
-		if (dat_entry_walk(NULL, gpa_to_gfn(cbrl[i]), vcpu->arch.gmap->asce,
+		if (dat_entry_walk(NULL, gpa_to_gfn(cbrl[i]), vcpu->arch.gmap->datt,
 				   0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep))
 			continue;
 		if (!ptep || ptep->s.pr)
@@ -1238,6 +1238,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
+		WRITE_ONCE(vcpu->arch.gmap->datt.has_pgstes, true);
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
 		 * the SIE block and in the mm_context, and we are not doing
@@ -1247,7 +1248,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		 * value really needs to be written to; if the value is
 		 * already correct, we do nothing and avoid the lock.
 		 */
-		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
+		WRITE_ONCE(vcpu->arch.gmap->datt.uses_cmma, true);
 		/*
 		 * If we are here, we are supposed to have CMMA enabled in
 		 * the SIE block. Enabling CMMA works on a per-CPU basis,
diff --git a/arch/s390/kvm/s390/pv.c b/arch/s390/kvm/s390/pv.c
index b18abd0e29ef..d565b02e47b1 100644
--- a/arch/s390/kvm/s390/pv.c
+++ b/arch/s390/kvm/s390/pv.c
@@ -487,7 +487,7 @@ int kvm_s390_pv_set_aside(struct kvm *kvm, u16 *rc, u16 *rrc)
 		return -EINVAL;
 
 	/* Guest with segment type ASCE, refuse to destroy asynchronously */
-	if (kvm->arch.gmap->asce.dt == TABLE_TYPE_SEGMENT)
+	if (kvm->arch.gmap->datt.asce.dt == TABLE_TYPE_SEGMENT)
 		return -EINVAL;
 
 	priv = kzalloc_obj(*priv);
@@ -500,7 +500,7 @@ int kvm_s390_pv_set_aside(struct kvm *kvm, u16 *rc, u16 *rrc)
 		priv->stor_var = kvm->arch.pv.stor_var;
 		priv->stor_base = kvm->arch.pv.stor_base;
 		priv->handle = kvm_s390_pv_get_handle(kvm);
-		priv->old_gmap_table = (unsigned long)dereference_asce(kvm->arch.gmap->asce);
+		priv->old_gmap_table = (unsigned long)kvm->arch.gmap->datt.table;
 		if (s390_replace_asce(kvm->arch.gmap))
 			res = -ENOMEM;
 	}
@@ -626,7 +626,8 @@ int kvm_s390_pv_deinit_cleanup_all(struct kvm *kvm, u16 *rc, u16 *rrc)
 	 * cleanup has been performed.
 	 */
 	if (need_zap && mmget_not_zero(kvm->mm)) {
-		gmap_pv_destroy_range(kvm->arch.gmap, 0, asce_end(kvm->arch.gmap->asce), false);
+		gmap_pv_destroy_range(kvm->arch.gmap, 0, dat_tables_end(kvm->arch.gmap->datt),
+				      false);
 		mmput(kvm->mm);
 	}
 
@@ -664,7 +665,7 @@ int kvm_s390_pv_deinit_aside_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 		return -EINVAL;
 
 	/* When a fatal signal is received, stop immediately */
-	if (gmap_pv_destroy_range(kvm->arch.gmap, 0, asce_end(kvm->arch.gmap->asce), true))
+	if (gmap_pv_destroy_range(kvm->arch.gmap, 0, dat_tables_end(kvm->arch.gmap->datt), true))
 		goto done;
 	if (kvm_s390_pv_dispose_one_leftover(kvm, p, rc, rrc))
 		ret = -EIO;
@@ -737,7 +738,7 @@ int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 	/* Inputs */
 	uvcb.guest_stor_origin = 0; /* MSO is 0 for KVM */
 	uvcb.guest_stor_len = kvm->arch.pv.guest_len;
-	uvcb.guest_asce = kvm->arch.gmap->asce.val;
+	uvcb.guest_asce = kvm->arch.gmap->datt.asce.val;
 	uvcb.guest_sca = virt_to_phys(kvm->arch.sca);
 	uvcb.conf_base_stor_origin =
 		virt_to_phys((void *)kvm->arch.pv.stor_base);
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index dafcd104d316..280310870dac 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -563,25 +563,23 @@ static int kvm_s390_keyop(struct kvm_s390_mmu_cache *mc, struct kvm *kvm, int op
 			  unsigned long addr, union skey skey)
 {
 	gfn_t gfn = gpa_to_gfn(addr);
-	union asce asce;
 	int r;
 
 	guard(read_lock)(&kvm->mmu_lock);
-	asce = kvm->arch.gmap->asce;
 
 	switch (op) {
 	case KVM_S390_KEYOP_SSKE:
-		r = dat_cond_set_storage_key(mc, asce, gfn, skey, &skey, 0, 0, 0);
+		r = dat_cond_set_storage_key(mc, kvm->arch.gmap->datt, gfn, skey, &skey, 0, 0, 0);
 		if (r == 0 || r == 1)
 			return skey.skey;
 		break;
 	case KVM_S390_KEYOP_ISKE:
-		r = dat_get_storage_key(asce, gfn, &skey);
+		r = dat_get_storage_key(kvm->arch.gmap->datt, gfn, &skey);
 		if (!r)
 			return skey.skey;
 		break;
 	case KVM_S390_KEYOP_RRBE:
-		r = dat_reset_reference_bit(asce, gfn, &skey);
+		r = dat_reset_reference_bit(kvm->arch.gmap->datt, gfn, &skey);
 		if (!r)
 			return skey.skey;
 		break;
@@ -1001,7 +999,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
 		do {
 			scoped_guard(read_lock, &kvm->mmu_lock)
-				start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
+				start_gfn = dat_reset_cmma(kvm->arch.gmap->datt, start_gfn);
 		} while (start_gfn);
 		ret = 0;
 		break;
@@ -1048,7 +1046,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (ret)
 			break;
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
-		VM_EVENT(kvm, 3, "New guest asce: 0x%p", (void *)kvm->arch.gmap->asce.val);
+		VM_EVENT(kvm, 3, "New guest asce: 0x%p", (void *)kvm->arch.gmap->datt.asce.val);
 		break;
 	}
 	default:
@@ -2174,7 +2172,7 @@ static int kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 
 	scoped_guard(read_lock, &kvm->mmu_lock) {
 		for (i = 0; i < args->count; i++) {
-			r = dat_get_storage_key(kvm->arch.gmap->asce,
+			r = dat_get_storage_key(kvm->arch.gmap->datt,
 						args->start_gfn + i, keys + i);
 			if (r)
 				break;
@@ -2241,7 +2239,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 			break;
 		scoped_guard(read_lock, &kvm->mmu_lock) {
 			for (i = 0 ; i < args->count; i++) {
-				r = dat_set_storage_key(mc, kvm->arch.gmap->asce,
+				r = dat_set_storage_key(mc, kvm->arch.gmap->datt,
 							args->start_gfn + i, keys[i], 0);
 				if (r)
 					break;
@@ -2295,10 +2293,10 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 
 	scoped_guard(read_lock, &kvm->mmu_lock) {
 		if (peek)
-			ret = dat_peek_cmma(args->start_gfn, kvm->arch.gmap->asce, &args->count,
+			ret = dat_peek_cmma(args->start_gfn, kvm->arch.gmap->datt, &args->count,
 					    values);
 		else
-			ret = dat_get_cmma(kvm->arch.gmap->asce, &args->start_gfn, &args->count,
+			ret = dat_get_cmma(kvm->arch.gmap->datt, &args->start_gfn, &args->count,
 					   values, &kvm->arch.cmma_dirty_pages);
 	}
 
@@ -2354,12 +2352,13 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 		if (r)
 			return r;
 		scoped_guard(read_lock, &kvm->mmu_lock) {
-			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
+			r = dat_set_cmma_bits(mc, kvm->arch.gmap->datt, args->start_gfn,
 					      args->count, args->mask, bits);
 		}
 	} while (r == -ENOMEM);
 
-	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
+	WRITE_ONCE(kvm->arch.gmap->datt.has_pgstes, true);
+	WRITE_ONCE(kvm->arch.gmap->datt.uses_cmma, true);
 
 	return r <= 0 ? r : -EFAULT;
 }
@@ -3357,7 +3356,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 			goto out_err;
 		set_bit(GMAP_FLAG_IS_UCONTROL, &kvm->arch.gmap->flags);
 	} else {
-		struct crst_table *table = dereference_asce(kvm->arch.gmap->asce);
+		struct crst_table *table = kvm->arch.gmap->datt.table;
 
 		crst_table_init((void *)table, _CRSTE_HOLE(table->crstes[0].h.tt).val);
 	}
@@ -4335,7 +4334,7 @@ static int kvm_s390_fixup_prefix(struct kvm_vcpu *vcpu)
 		return rc;
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_set_prefix_notif_bit(vcpu->kvm->arch.gmap->asce, gfn);
+		rc = dat_set_prefix_notif_bit(vcpu->kvm->arch.gmap->datt, gfn);
 	return rc;
 }
 
@@ -4813,7 +4812,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 
 		sie_return = kvm_s390_enter_exit_sie(vcpu->arch.sie_block,
 						     vcpu->run->s.regs.gprs,
-						     vcpu->arch.gmap->asce.val);
+						     vcpu->arch.gmap->datt.asce.val);
 
 		__enable_cpu_timer_accounting(vcpu);
 		guest_timing_exit_irqoff();
@@ -5776,7 +5775,7 @@ void kvm_s390_update_cmma_dirty(struct kvm *kvm, const struct kvm_memory_slot *o
 
 	if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
 		_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
-				    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
+				    kvm->arch.gmap->datt, &ops, DAT_WALK_IGN_HOLES,
 				    &kvm->arch.cmma_dirty_pages);
 	}
 }
@@ -5842,7 +5841,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	scoped_guard(read_lock, &kvm->mmu_lock)
-		return dat_test_age_gfn(kvm->arch.gmap->asce, range->start, range->end);
+		return dat_test_age_gfn(kvm->arch.gmap->datt, range->start, range->end);
 }
 
 /**
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..3b5c322bf8b4 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1232,7 +1232,8 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
 			goto xfer_to_guest_mode_check;
 		}
 		guest_timing_enter_irqoff();
-		sie_return = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
+		sie_return = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs,
+						     sg->datt.asce.val);
 		guest_timing_exit_irqoff();
 		local_irq_enable();
 	}
-- 
2.56.0

