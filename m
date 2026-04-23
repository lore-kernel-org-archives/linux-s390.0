Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F83ED5C0;
	Thu, 23 Apr 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947973; cv=none; b=kKeRMPXKVrw1k4hV6l77ghSBL8Ih9/mJiHFx+WqU8ukMMH6080Xwfb+dzfM7w612kUOUwi18nvTNEsE122Jfx0zXxVjQRIgxLqwZfERZTH0RlI4LJf+d227LNhByQe1IllRO7bdHJeCHl+EVpOoCdT62rhF/HfmfzISMbtqGg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947973; c=relaxed/simple;
	bh=f6xKuz3iOgOJb8r6u/HIRw6VO4xkH/GXaB+zSoDUL38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYhur+frmwku5vGOCT0Tpm38SwxqPfMKAM/bpwzp9UsGVXEAH4p7+2+XRxIJB7BZVASilA8WMv+tqBvbP4t5LaAyCIFaG2UicG583S66Zrw+WPmnIutWPem9bw/m4qXfRnhcFODjPXxH5EJnLgBGVJo5xPYzxSadbSioR4V8rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sKIGJTLa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sKIGJTLa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7ofsX3514956;
	Thu, 23 Apr 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mnh0vlvI0r/BOkJZ7
	nx3dIVLo/jKCnkAMeeJ6Qv2HvQ=; b=sKIGJTLaEM2/XVrP2vQHcenkbrxREQR8W
	33qT0892M2jx5kmM6eblYlUm2XwnXxl4FhlJOpheNn2u0IeP9PHXKtPezcNElNxK
	3cGqEjKbWNH20E5gZlVhzh0Z7byHjlWg0w/qfotk4zxAtP/Pvcyg9m3ngYmyAG2c
	pSZBxYSM6Yt/gRvGE/J0bSPLKVeUPIOqp2xbteEL5uCnn0EGKlNNeea1vRO5E2iH
	lQ7ApuDEI5Jp9vqapu/ZiCDaHyPDQAXId4kQ31lYOKoHuZR76wFvYWznweFgWbwJ
	IUs8r077uo9/vf2d5oJDq3wno23gWnWLKQbQdz/4JER67eP0mXMOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28mtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NCKNdS021922;
	Thu, 23 Apr 2026 12:39:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxk6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 12:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NCdKsV45351304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 12:39:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A602005A;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD41620063;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 12:39:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH 3/3] kvm: s390: Fix lpsw/e spec exception ilc reporting
Date: Thu, 23 Apr 2026 12:36:04 +0000
Message-ID: <20260423123902.14663-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423123902.14663-1-frankja@linux.ibm.com>
References: <20260423123902.14663-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMiBTYWx0ZWRfX91+HXt27NTWQ
 H12mnjUjkV1dVZgWk9GCD6wzKhsUAYdzdsCYlzFPgrLiQYwjs2IcLgK4u9cUVLDTQ8/AqY9I48C
 bryQrAkyFhCgxCuNs76v8tiqt+KzDLHHgG6uvBc3MjJEQKkTvL+8CYqnvUZM03QIuGhmnoijD7s
 L0c/IWQwXujeipVwvLBWhZuhK3qHehLac6Mj09t3Q+cx23Y15vzNUJ1St+XWp0Sfx/FgxufVJ86
 P5/9kqzDwoV8gCFaZPJhqfm0D+abOpuQrRtC8ZbxnSj9j4z+nHYNS5ELnmfY1hNlJCBNg83yb0A
 NPVC4KiD++U6ElmVurk3OD+kHyFq9DuKwiSEHzhJw+m5hfffV8HHbC0iEZ5lqOzbClOG1yGJi+f
 cpzqHb2/syIIOWhTSsqxTe3ji7g1qdKIkE5fniWReJNwPn+qR8AYAK8kWumTgz2b0FRMQyMx02P
 ojT2NVAeCWLBRipyKJw==
X-Proofpoint-ORIG-GUID: 11iwCKEr7gLLGUttF9Keg7DBdFuv0MFx
X-Proofpoint-GUID: 11iwCKEr7gLLGUttF9Keg7DBdFuv0MFx
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea12fd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=3rFDTmF3dspFlFmVKDAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230122

On early PSW specification exception the ILC has to be 0 according to
architecture.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
---
 arch/s390/kvm/priv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 56e63679f9d1..9fd7d3f1d1e8 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -713,6 +713,7 @@ int is_valid_psw(psw_t *psw)
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
+	struct kvm_s390_pgm_info info = {};
 	psw32_t new_psw;
 	u64 addr, iaddr;
 	int rc;
@@ -738,14 +739,18 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
 	vcpu->arch.sie_block->gbea = iaddr;
 
-	if (!is_valid_psw(gpsw))
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	if (!is_valid_psw(gpsw)) {
+		info.code = PGM_SPECIFICATION;
+		info.flags = KVM_S390_PGM_FLAGS_ILC_VALID;
+		return kvm_s390_inject_prog_irq(vcpu, &info);
+	}
 
 	return 0;
 }
 
 static int handle_lpswe(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_pgm_info info = {};
 	psw_t new_psw;
 	u64 addr, iaddr;
 	int rc;
@@ -766,8 +771,11 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw = new_psw;
 	vcpu->arch.sie_block->gbea = iaddr;
 
-	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw)) {
+		info.code = PGM_SPECIFICATION;
+		info.flags = KVM_S390_PGM_FLAGS_ILC_VALID;
+		return kvm_s390_inject_prog_irq(vcpu, &info);
+	}
 
 	return 0;
 }
-- 
2.51.0

