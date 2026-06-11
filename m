Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0033304BCB;
	Thu, 11 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190088; cv=none; b=rAXgPKGO+xR0F8ShQ+/fojJiEVOrGEmC0+XGfculGWXc1Yh+v8cYayfhJVX89VtuYaDkSIbIWpjgL+Fj9ETf5vhCO33mVf098+Lxwoj1eW6ENQHD4PdXbIDvlPmZVHdJ02bHjZtdeMS8junqNQ6IxFVUMRRvOTqEwhavqIZof+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190088; c=relaxed/simple;
	bh=PYHbwsMzVgYHs6tNhh4UAxN838J3bgmDyLoFhp9E4n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntkb28es7jtCIk1R3SDOtGGuw8flk8FmpDTqa3fJeBmVoRkMH7HZw7+KLoLx/vqDKFy7m1rpO+arGa//98kH2xdHEXMa0fwX5lEX1t9hoXSukZI+3yPekNj9WVfcAHuUqJ7OwidjjewzixFPPFwLbjj7BCGDDJtmImNjQwlx7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hA8145eO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hA8145eO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCIWcK3872820;
	Thu, 11 Jun 2026 15:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kd0v5E5KWIm9je+vF
	S+MUBOhDaXY0IqQYEGbeakEEp4=; b=hA8145eOVfDxsehqBub47zA8Ryv0gWoIw
	OEKxtf0LgO+6B8JXx6SfYrtLOp27VlldNYvv2bmZlsEFAaj/CWZJCSTuYkkp9SL7
	PwvHW3ObqxOoGsWnD8UkS8V+oybYucmoV3UFAHJGNbRY6b7iXXMfsf9hv/xI3G0z
	xoFQRB9gM/YchVMps5+K97MTfN//T4b3ykIsoUn7a+yMxO00v0rgnZGXBjwKGFgH
	PncBViQqAqajOj+nkNP2jBgVx+J9Ww75+5uiehR8ltStVC1T8TDr1VA1JMfJAIlc
	RI4qJr8+h3DRDhGxhn8rOGd9T2aZOqT373lwpnOor8jv1vxBP3wBw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8evcsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEncCh026975;
	Thu, 11 Jun 2026 15:01:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08knat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1HJR42140008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4738820043;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F29C2004D;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 4/5] KVM: s390: vsie: Add missing radix_tree_preload() in _gaccess_shadow_fault()
Date: Thu, 11 Jun 2026 17:01:15 +0200
Message-ID: <20260611150116.218162-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150116.218162-1-imbrenda@linux.ibm.com>
References: <20260611150116.218162-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX5bFJwggtzyW1
 zCC/QymyxfIzYuoxLZJzLN40YV+dnDkEeDGK+iBtz7pWCW7gu7p5tszV1oDyBFRVXyZ8UioBHdT
 8IylxpcNR4cdmkowRuIL+tVchSF4Bp5sPa1bBIQSXxJrEKmbSXICcIjCMgFBi9NoSTrLWfoFSSj
 /RZMFaG2xqpSfJ/YbzCglqUa/KprOegIoaf/aG8e01G5Gm2rYJr1oDp8FOjkVb5EPDBeJHoMe/D
 +h+sRk2ZPfBpNOwEDfsbofxKv6O6kG0lhWxyuJwXDZE7AnA89VxdAd22PhqAawQ8xZnzG9kflka
 aX893dW/Mz5jCHzoJVzAx9x7Zn+naKzfBwbXL9jphFhYqXA1EBcxXjecrGFlmdSGDO5IKhHWYKB
 AWp42nDiKmfDzsSQATWbUESSUgZB5k05jOaCUWfJAc+JMIB14z62CfmeQk3BUWfmITZMWf4ia4e
 hopZMDLGk7mazXaNlQw==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2acdc4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=CEliOpxPVmbustIeOKgA:9
X-Proofpoint-ORIG-GUID: ZhOkWtEgdJcZhrwOOppKtfIUmQDSmHd7
X-Proofpoint-GUID: ZhOkWtEgdJcZhrwOOppKtfIUmQDSmHd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX52DMc2ejbPSq
 XFuQtmPgcOkRGjEsY8ADp3utAB5ghSMvwGo0lzYADst8FCN2ZiP5Tqf0B+3TXAdpRjxGhMrLJ8K
 uIpfJ2aaNftxqpd3TUyAqcZkrL8uqK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

Add missing radix_tree_preload() in _gaccess_shadow_fault() to
guarantee forward progress. The core of _gaccess_shadow_fault() has
been split into ___gaccess_shadow_fault() in order to simplify locking.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
CC: stable@vger.kernel.org # 7.1
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611104850.110313-5-imbrenda@linux.ibm.com>
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

