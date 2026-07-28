Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E53A16B8;
	Tue, 28 Jul 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258450; cv=none; b=BiXQYwqgJgjSddxfEJQRq8YTGEUbR9c1jTGxc65yViEzJpGjFtd2+VJaNCasE95SzJTFPkMFAZTRJlRAUdO8CuPTSKugGRvHifL7NVucxI8KAvQA2IYxE0TWQbHbzXjBxEr5ODbTPLbpTli6xfH6MPvcOMJQjW3chLFkDHRWDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258450; c=relaxed/simple;
	bh=yB18Tdk/yJv2D1uTlZXxVFQX7lyhikE6fAymjrfZIUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGZd9VQtrjwn4n7/EeAw/GuGaZRKSY2NEhQ9eOUP2np7nrKpUnmh2jqNSviA5G7vci6/Tyz4X7fuxFJSrenQgIUL6SKLDi1zlYFiiK7ZUusf96gmjLRHxp0nWON70rtx+mxJHVioR9f3FQNQSgiljYtAoaLbrAARIT0AMuPAS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YQDufmU6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YQDufmU6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEltKx1491508;
	Tue, 28 Jul 2026 17:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ovgPGLArufZdBlLu
	6efjoPl7/x/t4jxjAnDkdUcJ+o=; b=YQDufmU6v8oZWLr2ttTznY0MCIN4VVRPB
	M8uMw+xUEgyyHETfH40ib4Q5QOkaTa5Sq/R6ypCR1W0E4FDJYJmsKgo25B2Fpdli
	QRDDRTfd+Rp5Um7Mt+2uFUd9CbHICDcYjYeUICp++1qh2ld+9pKEZpP1j8YdgLt5
	G/lAk/X5+pLenEDrox2mw/zCQ37Xzt7tZZ435Dx0NMO8JtL4CjbQYsXfcUnv7vFV
	XX7fiKTk82hkLy8yQHqdeRdKAgjIbHSnOL7C5TAXxLH/V17N3arWlSGIXbF3AGKf
	pK3h/z6Y1wp8+k/LdLHw15ftbf3ownW+lGQ94zbpO/e3M9Gs9DXXw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xphrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuGjG029496;
	Tue, 28 Jul 2026 17:07:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7J7D49807846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E7FF20049;
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E3B20040;
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 10/13] KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
Date: Tue, 28 Jul 2026 19:07:05 +0200
Message-ID: <20260728170708.294400-11-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: E2Leg-VCVD-8r19gYKQtc6u_EphjsODN
X-Proofpoint-ORIG-GUID: E2Leg-VCVD-8r19gYKQtc6u_EphjsODN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXz7Y86XsN7E2s
 +QEBB7irVDBgwkTnkNnkvtMin0wuG4xLVbd14RYq8Wryp2cXOXWYYdyxFDCz07fefPJvTeVHL4D
 HdiCAzZBj5EHQAv+3bQfbNgrWHebs2M=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e1ce cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=h-RzbZz0cncsEQf3j_AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXwgB4+zd3+Ptd
 DpWlB5SzD2EB7T3gF4rGHQBlWtDsY4mxFhgEQF/se4ITMFaKVLgx5QotLMjoIfNlS4n6uxWxQmy
 NxbEbXu7cce9TyAhjWV4fAnw5bl9eo2uzZAaPfTQ43Ius7DXPapelEYrkrkUVGx0q+cLzxTdVG4
 85bPIkP8Dwv5w3TVWhtxtO8oAEFABcOr4KsGn+cij87fSuU06cY3qB1IVgChOP9/J+VFuqu0D/M
 vzxfnLjWYZ+yYbAwtOSGiDtg17ctbpExdL0xzWC6tKrNP883WVrGVKfb94qT8bql289z09ThQKI
 rta/BA3EHSTjFR1D78vrjeE/3VPD3N9kA+6QURMZ4leILx0Zi08+smdHbbW/VSLL6xnMnpP9QdG
 ooaF08WhxCreiQH1HxGw0UhJvRWl+zbvIZRe54GGwQrhvazyQaKVM8i0664TfBBX4i9Et2JsEc+
 bi8+/sEWPeLk1DwGpBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

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

