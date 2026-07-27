Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAC41F342;
	Mon, 27 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164598; cv=none; b=Xw8vw2o/ShbYOg0u+Iv5ISRFKKcLcFtxEdH8W8CSMDJHUjmB6S49Ursw2PwcJwNVNohSeWsUTqE77gGGEpidDuvZKBN2wQlIZa5spme2d1rZfcF9K5K6iE5pj9SiULoDrx1WUV9pAxhCCCACj2gwg4ONgDODKAQ3fgD8wAcTUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164598; c=relaxed/simple;
	bh=0tlFsGl+x3Hlrli9Gi7EcZg6TVbNz+WPc4IUyuIjkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBkfVMeLsLfhc0xVGFJUc9AoCI+E4oTE8O8hVqeNUK1mkb14MlzizQQW6XNEc+2IXvNv6mlQP9dBlMxqIgHHo/QY8AxQWZh43+oL2418fjpcZsf/xyZdYABw3BPIyzbPzmPUgHj6tBALdT65OEyZDmDDpHcroV3J+iVPAZQj4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KUYV/GF8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KUYV/GF8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmi6U2373182;
	Mon, 27 Jul 2026 15:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oa4rPSShsjb1gbMP5
	pwYF4G9EGlS2a2WxbTtOWUJ2qo=; b=KUYV/GF8qorV00uCX+xaVsi0+LiJfjwGe
	pu6Qty68LO3kydCEFUHdJfpJyxB5DBHLkFnmD4Qn8Konx7HfVqST1grt4WF2Lrt7
	VxlBMIatfqCDe8U8KzXDCmVMvnbqeSVV16U4ILAFdzv6vmwaVc1sC1fCxDfFZcD6
	DCJWJGA9KdAjprNGc7LhA3IDCut/s5U7IZ7PICurw+iFOke3xVIS68Lo2gte6e/g
	8DXgjdhqtfLJQ6ADc+oA847phzHoFkWwdZYqBOLWUq9HYkb06GA715SFIjMJyuzu
	dUGGcuSqknD/Bg9KFZ9V//Biv6IoYgNNeMtQEO9MSvNOwHtncYTZw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw78mxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuM58015980;
	Mon, 27 Jul 2026 15:03:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5mjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF361L48955716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30070200F6;
	Mon, 27 Jul 2026 15:03:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5138E200F7;
	Mon, 27 Jul 2026 15:03:05 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:03:05 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 10/10] KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu()
Date: Mon, 27 Jul 2026 17:02:54 +0200
Message-ID: <20260727150254.236021-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFfbjfR52AjBG9fIJt8OTJ_dg0Cv--UX
X-Proofpoint-ORIG-GUID: PFfbjfR52AjBG9fIJt8OTJ_dg0Cv--UX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfXz34kMiiU93r/
 H0EPDRNYPNudeNq43+YTNdEdtCECUJEcB5r6VhdwnKavIloXyh8qIggm8Hjwxp8fm/H9VeJUcY6
 1eAF53cTHHCPkox/oTBoU/cvhpbBSb0eIjHcZ0L7gCnfURaLCG2q4swGYBM+JrcLsYhCGpa6/6h
 gqgxadrnTFsiq1V/bP8k5ONQ9p2InqZDB8NVn+XmLMgMi1hPFdys8j2qbSCEp8fcj6r69ZI59Og
 8/85mKhi+75myx3nS3XEEje8Hsk5CWHiMvG4AruZhggLpjLL2J5TPyNY/QJSvHXRwYyteV+WMS4
 icEG3YQBtbqeyVJUT5fKLBdUMguQ6b7rPRk76Ldapa1M6eT2LmfMHi8z1rL0+dmJp4Nsg4jl/hQ
 esRkTUeKbvcvWD145KVI1QM+YAneztGM2+5N6eaVwNy5lz/fP7Sv8y4Zzrfo2hbMSaFwB+HtNLM
 K1HLs4qXxdn4ZWRQUow==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a677330 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=h-RzbZz0cncsEQf3j_AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX2tZWgIWAOYJw
 uw12etFXONbkE3afsamwaFqZ52xFaj1gzS8ZK7g6fhwJZQcfafvv2C0peoBbWyTaKFjmzmTi8kN
 VzFqsC3LVU1ozQd4tP5rac4h9GUOPfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270140

If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
a PV handle and exits doing nothing otherwise. At that point, due to
not having created the protected vCPU, the PV handle will not be set,
and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
allocated memory.

Fix by factoring out the code to free and reset a PV vCPU; call it from
kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().

Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

