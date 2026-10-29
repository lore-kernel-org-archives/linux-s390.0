Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278856;
	b=dlwS9NT0DHzPmLK9SzB83cg5/7iYRH/6Ty6W1AYdCp7bHKbi1MNtt+gINwyQb3bX8RtF
	 YZiLhdtzehxoX+AXAxySvA46t7TfwxJG3S1Ij9NDvvWAlrH5KJmmP1WmGNXyYljeAUiJb
	 BFxBYcU+gn0qyPp6bgJre/WuTlFZCy9kt0yMWEJSUnlteGslxBy6VXyTP/c95DrE1PhOJ
	 Sg/2cAneOfIfHmiUy+fQh0cxjMZDpEkiwCrWyFdRhODVRBiI8HQ0dvfqe/dTUzoZLrBwE
	 QePP/xgE9c1LJNl1e9PefWdugaZFHnEvQMiTY7Ia8Q+nAxrOXDwAIK4syiYDveSkIuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m9RfEQcx6IFJe5qSGY2P9lEqf1yRoNQu+SWjB0YqHj8=;
	b=jatk+HOFK1aF372afU4SQa4PK5or62gEMUPW5pNtoLFHYz8dHWJr/aQ0ylVA785Ss4pI
	 bOUCIf+v50MU5xsnqU2f1fHlru8o/Tm7LRKDvce4IgNXKlYHYT6eyM7PrqteAPTpPRPbz
	 3dMI5ez/6ngUOenF5mnNEOzjx7fmH9w2k/ADP7FAqKtluGFkXaKOeW9YTcXFn03HCPB/6
	 9gsW+Z+Mn3rtx3i+Qr47P9P/K6NbeI6dozc0j8qjhrY8rpDITKgM8AgIiz2ccU4jhlfCz
	 +ag2lH05C+j10CRIvdeo/wbpVQefHBaglRNDWePSrtPOWQGPBcV8yrX8e/tOaTT4qIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eJsumr5u;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEB606A322;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DEB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eJsumr5u
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiKDJ3046067;
	Thu, 29 Oct 2026 13:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m9RfEQcx6IFJe5qSG
	Y2P9lEqf1yRoNQu+SWjB0YqHj8=; b=eJsumr5uw+QawJbbTA8fz6U93k9kkK+Uk
	KGpXyyXekodoYjZ54U4HNDA4wkpv+ymM4OSExV6Ttxgpp1ZQk1gsMlkklYOhZjZ9
	g60gf9hTnGTqYj6WF460//mIr1MrR43crvDoCimLm+RTxFNyl3QO6Fvewo9STYFK
	JYvVbP1kVdwYEXQClZ1D3D5csMsgRbWWuoWwowLBbsEsZKfYwCt5I0i6qafpBcSb
	GAZ0AhNUFQ6flEy/+X2j+rp63W5byjRIRtl/OlFZ+2W+4D1WdXm5Un7ND5yhFb/e
	UwgmeTpf69ViBazsG9gr9Nu/nApy9iuOGd8N3MbG75cONmWZij0Iw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3ga19j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCntf61967900;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010r61y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0j7x44106082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 059FD20040;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98B02004B;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 1/7] KVM: s390: Fix UCONTROL inconsistencies
Date: Thu, 29 Oct 2026 14:00:38 +0100
Message-ID: <20261029130044.125032-2-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae34383 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=J4Tbm5U8bJx2TlbRrzQA:9
X-Proofpoint-ORIG-GUID: wCgdDzLv3ffAiwHGVi-52JdsU4mVf93U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX3+3D7ZkexVYa
 lq+nWZevzJn/ifhXoYz2OpxLpSgZyuPZYvbtb+/nIykg7vQbYz46dyAKp7YNMVHvZ1qdDUNYsG2
 Yz/zhBQPTXCJN+HqMF87Zh0uOp2RHPZUWX5I2WnnMLE3XAEhS6rnDYLvHoKB3Go58TPjit+mJST
 Sxic5C3B80MvYVXWUvnGXgv4aKvzXHq0buvYgmgXuT3TmZPO73mBlpsyyhq2FGRgJp70eBRXWJM
 v89AiXWkrlRn51PHvFMk9vBjkqY1PLgcCBXYqJwrCZUs/woi+Uv88tUksFhyhIjrc+u3gzoVC4u
 TSGE0uPkQJ5sk6XTV537H24q2T04+3vL0b17bi4I5lR2SHk8759sT6Y3Q1tRleh+CZ8RsN2Ql/G
 I7SXGzs6FFAJKtFKUR6vxnd5k0usuq5qUAi02xb4qbHDDRabTq+29Lk1nBEVcSQGiuK8uW1+g7+
 1FdmiTfHOe+m+DzKO3Q==
X-Proofpoint-GUID: wCgdDzLv3ffAiwHGVi-52JdsU4mVf93U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfXyKUjPLXpDXWw
 RwnGPIO98VNvefEJZNceM7+ERw/kxfs2gMCCg/1V7PaysbcJfLSv7vXA5Lh3gFBzd8nzQSmzC+u
 OaODdqx6GiY3OvxqfFpl9+X2RLlWuLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
the tl field was set to 1. This collides with the present bit, which
means that other parts of gmap would mistake the entry for a present
one.

Refactor the code to use a different combination of flags to indicate a
mapped but unallocated segment.

The new flags combination will result in several functions returning
-EFAULT when used on UCONTROL guests. This is fine, since those
interfaces should not be used for UCONTROL guests to begin with.

Proper fencing of the interfaces that are not allowed for UCONTROL
guests is outside the scope of this patch.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
---
 arch/s390/kvm/gmap/dat.h  | 16 +++++++++++-
 arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 90389d47ba4e..4665c1112bb9 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -109,6 +109,8 @@ union pte {
 #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
 #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
 #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
+#define _UCAS_ENTRY_LENGTH	0
+#define _UCAS_ENTRY_OFFSET	3
 
 /* Soft dirty, needed as macro for atomic operations on ptes */
 #define _PAGE_SD 0x002
@@ -421,6 +423,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
 	return res;
 }
 
+static inline union crste _crste_ucas(kvm_pfn_t pfn)
+{
+	union crste res = { .val = PFN_PHYS(pfn) };
+
+	res.h.i = 1;
+	res.h.tt = TABLE_TYPE_SEGMENT;
+	res.h.fc0.tl = _UCAS_ENTRY_LENGTH;
+	res.h.fc0.tf = _UCAS_ENTRY_OFFSET;
+	return res;
+}
+
 /**
  * _crste() - Useful constructor for union crste with FC=1
  * @pfn: the pfn this pte should point to.
@@ -985,7 +998,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce
 
 static inline bool crste_is_ucas(union crste crste)
 {
-	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
+	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
+	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
 #endif /* ARCH_KVM_GMAP_DAT_H */
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index bf91e3d5013b..225fdae3d57c 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -777,16 +777,14 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 	if (rc)
 		return rc;
 	if (!ptep) {
-		newcrste = _crste_fc0(p_gfn, TABLE_TYPE_SEGMENT);
-		newcrste.h.i = 1;
-		newcrste.h.fc0.tl = 1;
+		newcrste = _crste_ucas(p_gfn);
 	} else {
 		pt = pte_table_start(ptep);
 		dat_set_ptval(pt, PTVAL_VMADDR, p_gfn >> (_SEGMENT_SHIFT - PAGE_SHIFT));
 		newcrste = _crste_fc0(virt_to_pfn(pt), TABLE_TYPE_SEGMENT);
 	}
-	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
-			    &crstep, &ptep);
+	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
 	if (rc)
 		return rc;
 	do {
@@ -802,8 +800,9 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce, DAT_WALK_CONTINUE,
-			    TABLE_TYPE_SEGMENT, crstepp, &ptep);
+	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce,
+			    DAT_WALK_IGN_HOLES | DAT_WALK_ANY,
+			    TABLE_TYPE_PAGE_TABLE, crstepp, &ptep);
 	if (rc || (!ptep && !crste_is_ucas(**crstepp)))
 		return -EREMOTE;
 	if (!ptep)
@@ -840,26 +839,24 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 		if (rc <= 0)
 			return rc;
 	}
-	do {
-		scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
-			rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
-			if (rc <= 0)
-				return rc;
-			translated_address = (*gaddr & ~_SEGMENT_MASK) |
-					     (crstep->val & _SEGMENT_MASK);
-			rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
-		}
-		if (!rc) {
-			*gaddr = translated_address;
-			return 0;
-		}
-		if (rc != -ENOMEM)
-			return -EREMOTE;
-		rc = kvm_s390_mmu_cache_topup(mc);
-		if (rc)
+	rc = kvm_s390_mmu_cache_topup(mc);
+	if (rc)
+		return rc;
+
+	scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
+		rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
+		if (rc <= 0)
 			return rc;
-	} while (1);
-	return 0;
+		translated_address = (*gaddr & ~_SEGMENT_MASK) |
+				     (crstep->val & _SEGMENT_MASK);
+		rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
+	}
+
+	if (!rc)
+		*gaddr = translated_address;
+	if (!rc || rc == -ENOMEM)
+		return rc;
+	return -EREMOTE;
 }
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
@@ -896,8 +893,9 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
-	if (rc)
+	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
+	if (rc || !is_pmd(*crstep))
 		return;
 	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY, c_gfn, gmap->asce))
 		;
-- 
2.56.0

