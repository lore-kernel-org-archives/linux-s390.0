Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E33A0B31;
	Tue, 28 Jul 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258448; cv=none; b=NgMGLScLJ5zsusgWee1uIG821nzqHXPVPrg7ng2GUZO27BzayW9YmxHNauvt91JhCoAkRtqpjG43cJI5WsDgV6HQoeBJOT+mhBsodtwlrzacDYU1w9kIwST5J/JQBDVMm564m6NkOTmXbtOvHgoh/E8fayb5DtvCdo33r7F7EOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258448; c=relaxed/simple;
	bh=4GQTRd/KjGQtTSA1uclx1Q9WSg3wHSB+soVA4LjQeaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGjN4lOFoYjtRzkFdId/d76HxQshnosaKCRzN430wukJ+LubPxuQ5j9fTVbBkYGKr4qMNUADuOwUDiTZtky2ecGI2yoLl5lbxGGZDdNfxJNh+WkaAuUlzbJjlIxc7tvH/HLB34qFeRiKXpAKG3xCkF9Gv9xoAx1/F25l/48RTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THB9pemT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THB9pemT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElfVS1459257;
	Tue, 28 Jul 2026 17:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bZJIXhis6uwWZhkKB
	j1GP/P99SeMVTR0iGZp3M7GnbI=; b=THB9pemTIAqqJ8dqXxW3zg+S1TFIbuU7F
	hsyKsrc/xFGKLRbnWtN/llzgOmRfOYzB27Ivb5kUmFe2TzheuIs3rcCr6L8HUmfO
	HefS6lWtVz024cx2w5hEkYQDzr940JPlmOcmbxLlt0YzwKGGuygW2L49+M9OKpUM
	vi8vMXIUv2ieLxVpb0Sb96hDZ8oMZjpPx/CZRs4z56VplxkIOVpqbTAkf63UwnmF
	Y25BGIuhlVNg6OJs5ySJFafKhUoyV1yG38tN8tzvVVqg7nJC6GfLhllILtuZpX80
	UkhJi0kVVNcqXisxOJuWgTLxfkGcHEiARaHm0G8Avw/n9Zk773Ttg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7egy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuFJI029483;
	Tue, 28 Jul 2026 17:07:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7Gm831130072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5748A20049;
	Tue, 28 Jul 2026 17:07:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4169B20040;
	Tue, 28 Jul 2026 17:07:15 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 07/13] KVM: s390: Return -EINTR if a signal was pending while faulting-in
Date: Tue, 28 Jul 2026 19:07:02 +0200
Message-ID: <20260728170708.294400-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IkkELecizcEamqnRh5Ew2ewr6yEa7qxz
X-Proofpoint-ORIG-GUID: IkkELecizcEamqnRh5Ew2ewr6yEa7qxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX1fdDdwmXUrFZ
 CvLNkpGd7B9pv8ipIOWMkyhAVuw9fVkUPu59kI3QSArkqVBtBffvzbrFaBhX5ownnL7g4mjuZ9r
 wIatK+09aVeeYZ4BL3ZPrbiE7it76ynUEhJwBRILD4lsBURYgg/Q1X3Rg8/VWlqkCGwh2r1dua4
 H8dlAiRCkz35LnRHHsuEXDPMLobsKX2De3szVE4wSVPlZSXSe9oibgygkAqS/AXj7Pk1QcT6VRa
 YvY+s1FEbAusTWnpPA5LufKsNNgv0nwd/YZBcOA0OUVeDiWGEJZbGEoK+hi954ev/87QnOms8uG
 FSnsHKGIV8PyhoCasALpQ6zz3+FFCd1at39gxWUwTTeYAdtYcBA5kKE0i0vGODUd4u962NSW8Ik
 ti/WwgCsLdVvrjXYqwD75cj7B4i37gDigTY7dO+oB3+eITAixvfbl35odOBzS7TiWUPECPt8kAE
 OvjujCA85Eie/tWFTMw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68e1cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=RGiYNUh6OUVCWQtPJLkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXwbRxa3nexyZk
 im7/jPkNeoE0fMkGQrNQKF0fdoZNKCRYLjo1dgclbWt7PZtzUn1cF6B9PxW2RsluvwFSTMpj4Kc
 xqNRsoNMakRS1YzwagdU2YK/28DORQA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN.

Also fix unpack_one() and handle_mvpg_pei() so that they can handle
-EINTR properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c   |  4 ++--
 arch/s390/kvm/intercept.c | 23 +++++++++++++----------
 arch/s390/kvm/pv.c        |  2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..4ff4c5970956 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -92,8 +92,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
 		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1980df61ef30..a40fe2a10cbf 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -369,27 +369,30 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	do {
-		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
-	} while (rc == -EAGAIN);
-	if (rc)
-		return rc;
-
-	/* Ensure that the source is paged-in, no actual access -> no key checking */
+	/* Ensure that the destination is paged-in, no actual access -> no key checking */
 	rc = guest_translate_address_with_key(vcpu, vcpu->run->s.regs.gprs[reg1],
 					      reg1, &dstaddr, GACC_STORE, 0);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
+	/*
+	 * If an error happens below, the instruction needs to be retried.
+	 * Positive error codes are impossible; addressing exceptions would
+	 * have been discovered and reported above.
+	 */
+	kvm_s390_retry_instr(vcpu);
+
 	do {
-		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
+		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
 	} while (rc == -EAGAIN);
 	if (rc)
 		return rc;
 
-	kvm_s390_retry_instr(vcpu);
+	do {
+		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
+	} while (rc == -EAGAIN);
 
-	return 0;
+	return rc;
 }
 
 static int handle_partial_execution(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

