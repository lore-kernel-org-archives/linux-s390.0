Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0940EBB0;
	Mon,  3 Aug 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760859; cv=none; b=pZHq+aq1mOlirj78oIIkiuw9ccS8BFk4A+4130fTOjz2SCEC3piUxLa7k7il0qF5avMrmVjo19A9BKOoKAGGVh1wYGTX0XLFL5CxelJG9eccXA45pv0t+Bq6mVooKr1h2ZDJnvcws1MEzpEcpq9idaTmcZh0bSD9TSr6RN/FS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760859; c=relaxed/simple;
	bh=yB18Tdk/yJv2D1uTlZXxVFQX7lyhikE6fAymjrfZIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmS9YykK3WssmE1t54W5yx7v2Us+AO3oD3wrcbwK+xa0vSdCmTxdyjvCoYmSQJOOwq2APqriEDokLGcc+7yC0q+V/IkAOzeF8+l/Ct0V/rx3tkahmv0scMryDokkF+xL7ZbgOhtPyLITWJYNsxFvZIVTJ5TyCBiGt0TqOM+L6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RSPE3w9y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RSPE3w9y"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CI1V92018764;
	Mon, 3 Aug 2026 12:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ovgPGLArufZdBlLu
	6efjoPl7/x/t4jxjAnDkdUcJ+o=; b=RSPE3w9yKUQedYtCfCNQBcBS90/isG89+
	Xepr/CWj9KppQ/L+RYLZO4Z82q11XgKOYDghB27yfM93mClg7Sgj9oCYt+3tjSdi
	+mE8vayc4Skb1S7H5U0OM0iMPTizhucmyecdxU11HQLRjv1YMWalfNKvNyIFJg0N
	Bv+/Zal1h85Rx1ZoVY8PC97X1tLPpu8Kk9Ar9kHTPWI993eqteRxBxOO2d4Ex20E
	fugTE191U/E1wyKAZARKiLJDMl2TeICbYA/DJkZLCB2RBCUpyUsP4XO3sDvgWwOs
	Klcense4jA+jvjjGXGNeT4FO0kLUblCI3wSvhODpJYRy1TK4u+zhg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rr5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBjj4016862;
	Mon, 3 Aug 2026 12:40:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwe5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CemCw16384462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11BA820040;
	Mon,  3 Aug 2026 12:40:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92B2720043;
	Mon,  3 Aug 2026 12:40:47 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 13/13] KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
Date: Mon,  3 Aug 2026 14:40:40 +0200
Message-ID: <20260803124040.126471-14-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX7PGLItcmwY9K
 kga/JXq/yFALZ5ZK/IT+dJAiiQBiYTNkQ0jtgeBuRNeb/HjqPqPdcY5/dmk1Ow1cI2dTVid7+GG
 VDrDT7C+vp60QDM5m37IkO3f4miGQio=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX7UHLa7M8jJI1
 JiUD2aOmTUoh5ErlI7RgjivujjAq0Yv4Y5y+Z3zavDbEjTVMy6N5jpxsNqZ/1v1Fh4gko5gfc5y
 W+ncxeQ333Yx/dDIMJAh0zeGA5CWKUxODzSxklZs2Ej/IAUjlAo8d2vs6oQYvBq12Bqo0Ro/vXZ
 TPNGQqMUosAQeL9VwjVMQLPyOuTLRo0lS93F8XVDoo5WLs2e8tKuzjRK4dXkU255wO45pMj4GRN
 ERTj0FDgaaxR8r12PYZV5D04tJH2OjkxhmhhuDKVcGiTzQ/n7XGap5haCh3v2Vmhy1DT930P0vT
 VCdbCoj6tGVNXkYulVKPbF/YytumEXNaoxbnPo4hrRKYCsXbY4e8envzegHr6L/mDtZ5DiHQbSN
 zgAb8UVe7oK5p45o+TMxSyV8JwvXNNfTemSNdItXwW1/WfAzTt/kkSmTnD3i7kmgOz51z0r5Cvc
 QO1XLWsr8iXNZKTaldQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a708c57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=h-RzbZz0cncsEQf3j_AA:9
X-Proofpoint-ORIG-GUID: hkv4NIendSP6O1WIOTEdEMbQZYc9doUS
X-Proofpoint-GUID: hkv4NIendSP6O1WIOTEdEMbQZYc9doUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030110

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

