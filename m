Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528795;
	b=1R1Xc8sGmgOoO5CRt8d1WIxZIeqwHmAxqiamUFhdFEjt+FxnSRJ4yaq9Ztf385o0QjwT
	 H43EwYaY3tgneyFmFwIKTlbpB774qYTEws5/vYowDp3CAuJldklmBFwjuKQ5WzJK8WGM0
	 L/ijhZvJ+iKl3KOIaH8bqriFIIWIHRJrIZYlOyzgwpuO/KSHuAsRCP3DjWZ8vgweqnJiO
	 oXVnde9E1PGgQ7SQTPZYPQxMWuIiSoDJZ9dvHriit59RL4OO/hVGDPFS+JsqvHWj32t+M
	 /PN8xdA/gxKHYdeOsm4kp1DfynppDXj70QmGIvmW/EGkPfV9+VGOJGnESerUKXzsWyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0lhunb/hI4kx+9bxqLbunuEz4VXLwPOnpkBJ8qyr13g=;
	b=fhfGb9uVxJI8yq/7wHDvgtRpyy34m6oIVl34ixEplw1qOgIEL9DTSWynz3olvUA0hSQS
	 Ljd7ons1XjdClDIaYKbRfbw4ZADUUZUhpAknJ8ZA9PDSjaPxYA1ZO6mD3QiA1oJr4RueC
	 Lpyd6OknExqiw31KzfmSwI/68357XOzLru4XWQItV0+58dLrcXzdfB0nQw5ZWQ1dipTkN
	 eyv2EBTG9C/75QcaDFGExZdf28fap6NzBCt9wkdt0+pJmpD7IOyd+o+b8FU1oXlB+yYvp
	 23yfwAloTVNRLz7w1xJQBWarmGhjmdQTLjRG2cu0bWdEFffvv+sKZ75+m3g/YA1Fk4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="jI/KIBCw";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF74606A330;
	Tue, 24 Nov 2026 13:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF74606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jI/KIBCw
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4clW979934;
	Tue, 24 Nov 2026 13:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0lhunb/hI4kx+9bxq
	LbunuEz4VXLwPOnpkBJ8qyr13g=; b=jI/KIBCwh0HK8191RCYU4r26Z9fzdKiGx
	Lr2iDw9aKrmMfQNCl/yJTWaA1eMPPypGgVUKE8/kD1yS02q6MVYYd8Lurhrl9RyZ
	h6kKHASXRRZ1JyMucIDP0XBNMEn9vaXNEKGnXYZ9/XeSphF7l1/VpBtjVV/kfiS9
	z+ynS6krbh7DwUI2mlbGruRv2G68tPewzov0a4grM6DotM+QMbi+vmrHLjaEEw8Q
	71PtMAtkVd+RbzXmZNPp55fbb5Hdlwr8sTKg8lOwbiYYsY5SGSDti4uaFNF/xGYU
	Hs30pXSY4N46jhDUY35GlQPvCvg3UsGWn1ePYH0IX/UUZyhi39p8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4fdvb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCoQsA3374782;
	Tue, 24 Nov 2026 13:59:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkr62r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxngE10027404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26A6C2004E;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F053F2004F;
	Tue, 24 Nov 2026 13:59:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 13:59:48 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] s390/mm: Remove gmap_asce from mm_context_t
Date: Tue, 24 Nov 2026 14:59:44 +0100
Message-ID: <20261124135948.1295745-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135948.1295745-1-hca@linux.ibm.com>
References: <20261124135948.1295745-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfXzN90qjq2CBMW
 Q02xqfkKzOLxnHMp9kXjIAFhdf9UNxwITumMC4VrRMH75YxwuIfzD30+7+GFYSX0stEGaEEX0we
 ASI1GuFolN4bq6clHeNLoq3L5XRYeFQ=
X-Proofpoint-GUID: 9DHFRaj24QIgDiuy3iNSgwm3WMlLqSNb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX+1iCWvqwrMol
 0KvbMU1sN9kJz32j82xU/MQW9/yZrsNFgE9ETHRJRJgBSjcJC7Q7DW6U9HrZeDLOxpRPrTwiQTp
 yKp1M9zA0wnp2yombdohS5KJHEDcEYprC7Iit8ASOKfrVkhm4mUEAXqYurng/K3vJatiEikjxTc
 z0vnB/O8K13872qVfiTPuxs7xRWo3eNaJyCSBJeuGSERXkpTQTgFjsJHrrODwRnqC0agIMHX3eV
 JcpKrrX8RFHhftsZGShnWzmZ3ech//zrpDTWN54IaH1UK13QoqxEWMnq9lvsFWlTeN40MEav7qt
 lk7EehfO2c89Xco+AgLaM2BQnkBWYLoBfKNkTmyrjHymS2UhVj23cFZ3IljzwMDQvPDF3X4sJgA
 Xmwvf70eyYl1bfC4dL6Au7ChR1mP/DJNOxuxoQS80k+YxF/AfiRYsjLGkW3ZVTiJ1rHufKW8VyZ
 GORWYszcSh/tkscmUwg==
X-Proofpoint-ORIG-GUID: 9DHFRaj24QIgDiuy3iNSgwm3WMlLqSNb
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b059859 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=zdn79pWY1b4fLKOH2O0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240053

After the gmap rework mm->context.gmap_asce is always 0.
Remove it, and simplify the mm code accordingly.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/mmu.h         |  1 -
 arch/s390/include/asm/mmu_context.h |  1 -
 arch/s390/include/asm/tlbflush.h    | 12 +---------
 arch/s390/mm/pgtable.c              | 34 +++++------------------------
 4 files changed, 7 insertions(+), 41 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index d4fd7bf3692e..3bf06dcba050 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -12,7 +12,6 @@ typedef struct {
 	atomic_t flush_count;
 	unsigned int flush_mm;
 	struct list_head gmap_list;
-	unsigned long gmap_asce;
 	unsigned long asce;
 	unsigned long asce_limit;
 	unsigned long vdso_base;
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index bd1ef5e2d2eb..4e5da0017c15 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -27,7 +27,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	cpumask_clear(&mm->context.cpu_attach_mask);
 	atomic_set(&mm->context.flush_count, 0);
 	atomic_set(&mm->context.protected_count, 0);
-	mm->context.gmap_asce = 0;
 	mm->context.flush_mm = 0;
 #if IS_ENABLED(CONFIG_KVM)
 	mm->context.allow_cow_sharing = 1;
diff --git a/arch/s390/include/asm/tlbflush.h b/arch/s390/include/asm/tlbflush.h
index 163ccbbe8c47..ca517013b5d0 100644
--- a/arch/s390/include/asm/tlbflush.h
+++ b/arch/s390/include/asm/tlbflush.h
@@ -46,22 +46,12 @@ static inline void __tlb_flush_global(void)
  */
 static inline void __tlb_flush_mm(struct mm_struct *mm)
 {
-	unsigned long gmap_asce;
-
 	preempt_disable();
 	atomic_inc(&mm->context.flush_count);
 	/* Reset TLB flush mask */
 	cpumask_copy(mm_cpumask(mm), &mm->context.cpu_attach_mask);
 	barrier();
-	gmap_asce = READ_ONCE(mm->context.gmap_asce);
-	if (gmap_asce != -1UL) {
-		if (gmap_asce)
-			__tlb_flush_idte(gmap_asce);
-		__tlb_flush_idte(mm->context.asce);
-	} else {
-		/* Global TLB flush */
-		__tlb_flush_global();
-	}
+	__tlb_flush_idte(mm->context.asce);
 	atomic_dec(&mm->context.flush_count);
 	preempt_enable();
 }
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index da076928b63b..561d280d485f 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -39,41 +39,19 @@ EXPORT_SYMBOL_GPL(pgprot_writecombine);
 static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, int nodat)
 {
-	unsigned long opt, asce;
-
-	if (machine_has_tlb_guest()) {
-		opt = 0;
-		asce = READ_ONCE(mm->context.gmap_asce);
-		if (asce == 0UL || nodat)
-			opt |= IPTE_NODAT;
-		if (asce != -1UL) {
-			asce = asce ? : mm->context.asce;
-			opt |= IPTE_GUEST_ASCE;
-		}
-		__ptep_ipte(addr, ptep, opt, asce, IPTE_LOCAL);
-	} else {
+	if (machine_has_tlb_guest())
+		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
+	else
 		__ptep_ipte(addr, ptep, 0, 0, IPTE_LOCAL);
-	}
 }
 
 static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr,
 				    pte_t *ptep, int nodat)
 {
-	unsigned long opt, asce;
-
-	if (machine_has_tlb_guest()) {
-		opt = 0;
-		asce = READ_ONCE(mm->context.gmap_asce);
-		if (asce == 0UL || nodat)
-			opt |= IPTE_NODAT;
-		if (asce != -1UL) {
-			asce = asce ? : mm->context.asce;
-			opt |= IPTE_GUEST_ASCE;
-		}
-		__ptep_ipte(addr, ptep, opt, asce, IPTE_GLOBAL);
-	} else {
+	if (machine_has_tlb_guest())
+		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
+	else
 		__ptep_ipte(addr, ptep, 0, 0, IPTE_GLOBAL);
-	}
 }
 
 static inline pte_t ptep_flush_direct(struct mm_struct *mm,
-- 
2.53.0

