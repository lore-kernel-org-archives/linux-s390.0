Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC263D812D;
	Thu, 11 Jun 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174943; cv=none; b=NEJc9FHu8f60MhksLxUhsIyI3FRgAnORk61TAY4IeRgCoxZEHfNm1nc7/rJPfecp3r4qyoM9Jm2HDUbavrihLAnVsNvECu98bFsLXUlvwJwTOo+GNp1LVPav0xXTCbSAlcVP3R6pGiyPJLZl1Knv/7dREYjbEzDiW99eFOO3drg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174943; c=relaxed/simple;
	bh=9V+jA+EZhsDbrZdMt30pm/2wUmjQz0O4WZ26NGBDLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD1Ltru01JzUQ3czRZDKeC/qqxsz7b+PYh7RVt+UtPpeqjWBq3N1A3RHtWvNtbUWKRWyulrGUHhw7AYxXTWXRoyGxlPAA2jn9bnGAzmzBeAYJz7ycq44EkZ3vh1pybBHSkOlj/66W0NLLP05ZbG1kZbQ1hmJ+8fVcLjFelwnB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pB34dncZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pB34dncZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJuZ9p1364529;
	Thu, 11 Jun 2026 10:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dq1fkbnIP/oCGeQAa
	usL5YZpUFzWuls1SJ4tgpZFiiQ=; b=pB34dncZ4d+rcrCOwZhxlQ9bi++P9lzfA
	B7MS8FftGMQNym/BhB6YHEEMhwTrVy5HB/K5fX2CQg0u5GqHvRT7isrBWfJjL2GE
	byaH3pB1LK1rkUihjfks+msw779ApDVvJanXqwcpmyn6KKrKf8Cfk8m/hJGoMauy
	wmRTqgFZdKkobHwDATw+yPcBAUGykQ1LieYJgnoLkgLaHWUwEJL1MI8WSRZ+BkVa
	AUO+AcccXnjwygoSrHWqnU6sF1LT2KcmQfafy971B8osC3tjxaCKEMN9rdleeOIg
	SkEjIqoz8L22ISX5Kn7FBeaHfgqyEAnXD1ES/dsp9NJgsukmhXcPA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dtuw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAYhjj018360;
	Thu, 11 Jun 2026 10:48:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08jtbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAmqQt16777678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:48:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D2AB20040;
	Thu, 11 Jun 2026 10:48:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCC132004B;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 4/5] KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
Date: Thu, 11 Jun 2026 12:48:49 +0200
Message-ID: <20260611104850.110313-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611104850.110313-1-imbrenda@linux.ibm.com>
References: <20260611104850.110313-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zz4Ocm5pbrj5YfdLMPrTo8jHgTUcpGdk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX9w03qUpJ4kfb
 /+QoDyTt+K/XJQfr+X3ld7HQMZ1TCo3BDXynsW0aghEsQupoJtw/5ULZj2S5YjtuT4zLfF/dIAJ
 Fbu5v0n5LRINt4xNq0upUSvcbfsk2Wa1Xrd4EBe+ymuHZ903JYylU9oxqrIvysYaVXtuKL6p7cV
 P0iezi62ejuVjHT1WibyCMehn5v0jC/kE0ThkSi7agUpL3aOyFunpW3gD+VGW24UELYJYqZyfbS
 29WpvWgPy80e1y8/tzweLnSf8EpJtnRte+ExbNanhlt0SaNbMaHygArDDFl8M3/UCxXCZgWtUMC
 6RTfCsAba7vKyb+FscQlqS5T6kfQKp8ts3ta0P5CY9sxFqnS2Big9yctNcXD4G4cl/Hs7EdZUgX
 RXr7v3dv1m8E8pgWGgTOFq2f30VeX+pOp0ojtq2Pb7T7A/94D+IAg1mjh/0Zn5bxY6hlFJaxXwX
 WJmoqxld2MPj4TzSPcw==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2a929b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=CEliOpxPVmbustIeOKgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX2runJ0WQXqYT
 a/wHCEIBgZRwfgmS08GFXQSvvV4KZh5W1c9UOMW75VYqD2l8Zynxp2zKjFfDkoiideAAMAMhCy0
 BIMT7/Ms+CEte6WyPGBfUHI2ZfeHVCQ=
X-Proofpoint-ORIG-GUID: Zz4Ocm5pbrj5YfdLMPrTo8jHgTUcpGdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106

Add missing radix_tree_preload() in _gaccess_shadow_fault() to
guarantee forward progress. The core of _gaccess_shadow_fault() has
been split into ___gaccess_shadow_fault() in order to simplify locking.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gaccess.c | 57 +++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 20e28b183c1a..0584fc91606f 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1582,35 +1582,48 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	return _do_shadow_crste(sg, saddr, host, table, entries + LEVEL_MEM, w->p);
 }
 
-static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
-					unsigned long seq, struct pgtwalk *walk)
+static inline int ___gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
+					  unsigned long seq, struct pgtwalk *walk)
 {
 	struct gmap *parent;
 	int rc;
 
-	if (kvm_s390_array_needs_retry_unsafe(vcpu->kvm, seq, walk->raw_entries))
+	if (kvm_s390_array_needs_retry_safe(vcpu->kvm, seq, walk->raw_entries))
 		return -EAGAIN;
-again:
-	rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
-	if (rc)
-		return rc;
-	scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
-		if (kvm_s390_array_needs_retry_safe(vcpu->kvm, seq, walk->raw_entries))
-			return -EAGAIN;
-		parent = READ_ONCE(sg->parent);
-		if (!parent)
+	parent = READ_ONCE(sg->parent);
+	if (!parent)
+		return -EAGAIN;
+	scoped_guard(spinlock, &parent->children_lock) {
+		if (READ_ONCE(sg->parent) != parent)
 			return -EAGAIN;
-		scoped_guard(spinlock, &parent->children_lock) {
-			if (READ_ONCE(sg->parent) != parent)
-				return -EAGAIN;
-			sg->invalidated = false;
-			rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
-		}
-		if (rc == -ENOMEM)
-			goto again;
-		if (!rc)
-			kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
+		sg->invalidated = false;
+		rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
 	}
+	if (!rc)
+		kvm_s390_release_faultin_array(vcpu->kvm, walk->raw_entries, false);
+	return rc;
+}
+
+static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
+					unsigned long seq, struct pgtwalk *walk)
+{
+	int rc;
+
+	if (kvm_s390_array_needs_retry_unsafe(vcpu->kvm, seq, walk->raw_entries))
+		return -EAGAIN;
+
+	do {
+		rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+		if (rc)
+			return rc;
+		rc = radix_tree_preload(GFP_KERNEL);
+		if (rc)
+			return rc;
+		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+			rc = ___gaccess_shadow_fault(vcpu, sg, saddr, seq, walk);
+		radix_tree_preload_end();
+	} while (rc == -ENOMEM);
+
 	return rc;
 }
 
-- 
2.54.0

