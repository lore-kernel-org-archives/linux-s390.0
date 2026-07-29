Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693313C1D42;
	Wed, 29 Jul 2026 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338993; cv=none; b=BUlFUnyxYsLgpbznEhwgK5VIISwlCQjoUHEj6AijMDc5DV+JC9Mr1jMKONjkpuQrDJuLRvwdJkNVJ/UViLEOKCwtl7Sw80laGd6j82NU8lghp3ThpmULW3kBfaU5+SexQhk2z/7vJjZ1GE4a9TNWjcqYZSX1kNq41njQkeEekIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338993; c=relaxed/simple;
	bh=yB18Tdk/yJv2D1uTlZXxVFQX7lyhikE6fAymjrfZIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW1DwZLnpkf6J8VAHv50kyhNCIFVbQ85FDuXPGL86NlUWebu0XIzboKW/RsXRrHrC2VTgANowPW6SJbx/PlUM6bp2rofcF8SpfkRPSLB2fMxgBrGkWNhIqABWCxZzlGWiaUmMbkd9oQ9pA13AMrZ27RjNRmsmhM+z7qUHIaQO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2EdI+Eh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2EdI+Eh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHcGB282799;
	Wed, 29 Jul 2026 15:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ovgPGLArufZdBlLu
	6efjoPl7/x/t4jxjAnDkdUcJ+o=; b=T2EdI+Eh/QYQ+LDR+1kUa8vvEuZ7iKlS+
	XpBUjNw+L9dDVBDLZsVfYXVPDVOUhPY2FN2A5nCds/63Hs9Li+dynKQPAkLlDRN2
	uTDXcg6kkGqsoMs8mJ0rvWH934CnQEQ/memcZMPl4BjO89knZtqf1USIB+qSuCfy
	s8H1+cjwfJ3jm8sQU8kw/nCwbPwPFKAZmxkbWbC++cphNJEGTTCFql39/ZfJkeel
	Afjstj8G4n5lZ/itt0Gp2XDCWnVpPD+yRSuegIukOp7dkrBL5qT2xDFNGw/R/0oD
	/Po5jMiA1t2+y3Y8D4hYWF3tLjJCe91gU+I2bFM90evcayfyDLlIg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntkt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQGZ5028437;
	Wed, 29 Jul 2026 15:29:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw7dhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTe2G30277936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C0420040;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 913E620043;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 12/13] KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
Date: Wed, 29 Jul 2026 17:29:37 +0200
Message-ID: <20260729152938.782383-13-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX+GBHsvQhIkwY
 Kx3fUG5NkGn7p6msF1l+9LL4IBdVyL+960uHrKt2DypO8q2aSZAWjpZs0asyV3gVCxStPvaPEP+
 dQULEs8+3JKq536HPgF582Cq0R+EZkM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX3yO74TMEUdPL
 xbmpaEjYIum9fQM7FDna2l/WMfTyXGMwCclO7pWsHW5PEXdCb2+/7gvSu7wRNn0tv7U2/NBHfyM
 +OP+MfeE+e+fPlTIkMuTdYNyi147oSVvd2557HYWllU5pOtLCFZJ0Vx2YZa6AwoLC/3/3RzAz8R
 gl2TrznX44XfCCk9mrTQvJ/e71MI0KwwAR0Q4Hij5wfvxkYzRvByglO1PEckStTamBINot2UDyc
 cBo8wZC3Y6Q0OecDLsMk5hb3DG3QSxL6Tek9kltyhqs1C2Yf1LmosuZb9gG/yAyPLjoGGR0saY8
 PHjsFXhbHqtWjxEIdCQEQUJO+VbfVWxq3SyCmF6uwnrWKmxtv2a0WEAWPTldODhisp2kf5wMW33
 29uqMeWlrI4jHys/LBKeU3OdsLDmu9mp83FHcIe80cIxsTZh1xaNldBDWv0hwwHnzHje5UrgpLk
 zOKCN34gDMkD0jki0Rg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a1c6b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=h-RzbZz0cncsEQf3j_AA:9
X-Proofpoint-GUID: 7eyXYeUzm-9BlmOO9yUYnMMY_TN4hE9j
X-Proofpoint-ORIG-GUID: 7eyXYeUzm-9BlmOO9yUYnMMY_TN4hE9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
a PV handle and exits doing nothing otherwise. At that point, due to
not having created the protected vCPU, the PV handle will not be set,
and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
allocated memory.

Fix by factoring out the code to free and reset a PV vCPU; call it from
kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().

Opportunistically fix the return value of kvm_s390_pv_destroy_cpu() in
case of errors: return -EIO instead if EIO.

Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index dc204b521052..b02e0159d3cd 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -244,6 +244,24 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
 	kvm->arch.pv.stor_var = NULL;
 }
 
+static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)
+{
+	if (free_stor_base)
+		free_pages(vcpu->arch.pv.stor_base, get_order(uv_info.guest_cpu_stor_len));
+	free_page((unsigned long)sida_addr(vcpu->arch.sie_block));
+	vcpu->arch.sie_block->pv_handle_cpu = 0;
+	vcpu->arch.sie_block->pv_handle_config = 0;
+	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
+	vcpu->arch.sie_block->sdf = 0;
+	/*
+	 * The sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
+	 * Use the reset value of gbea to avoid leaking the kernel pointer of
+	 * the just freed sida.
+	 */
+	vcpu->arch.sie_block->gbea = 1;
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+}
+
 int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 {
 	int cc;
@@ -258,24 +276,9 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 	WARN_ONCE(cc, "protvirt destroy cpu failed rc %x rrc %x", *rc, *rrc);
 
 	/* Intended memory leak for something that should never happen. */
-	if (!cc)
-		free_pages(vcpu->arch.pv.stor_base,
-			   get_order(uv_info.guest_cpu_stor_len));
-
-	free_page((unsigned long)sida_addr(vcpu->arch.sie_block));
-	vcpu->arch.sie_block->pv_handle_cpu = 0;
-	vcpu->arch.sie_block->pv_handle_config = 0;
-	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
-	vcpu->arch.sie_block->sdf = 0;
-	/*
-	 * The sidad field (for sdf == 2) is now the gbea field (for sdf == 0).
-	 * Use the reset value of gbea to avoid leaking the kernel pointer of
-	 * the just freed sida.
-	 */
-	vcpu->arch.sie_block->gbea = 1;
-	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
+	kvm_s390_pv_dispose_cpu(vcpu, !cc);
 
-	return cc ? EIO : 0;
+	return cc ? -EIO : 0;
 }
 
 int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
@@ -319,9 +322,7 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
 		     uvcb.header.rrc);
 
 	if (cc) {
-		u16 dummy;
-
-		kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
+		kvm_s390_pv_dispose_cpu(vcpu, true);
 		return -EIO;
 	}
 
-- 
2.55.0

