Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6C44AB8A;
	Wed, 26 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756731; cv=none; b=XtaJGDtIiMyMkLtzvRNKu7Dd335P4YHVU8A9goDvoJQw2mff6Ve3PLkRPN+kWsU5w2sMq+mL0p4HeodHvX1Zped+wOMgDtbaFI8DnfQgEw9aB+SJBWHzoPccj9yern1lUh62wiNzRzfL3Wua2uUh//grAJvPE2Meolw4qREcOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756731; c=relaxed/simple;
	bh=x9xdSjbyG421knKQsJE0As0Fzfy3RA3/kmy4Qmy3OmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZXhlA4lp7gmwsV1UfWVRNCt3cnU6FKrQ/RhxV8I9lDofU7Gx8NJdsC5v2oYpNFkJfBAq+Hz1zft0pgUVOIenpvojDqntrlmKuWvcg+9zAUWJ7gKBOgpqENfxohVBugB6gtuIeMyJ3eo935tSvlKt8xGdN3tbiYQaTEUnc0CKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r+61Iqfp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r+61Iqfp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1cWZ070316;
	Wed, 26 Aug 2026 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q7CDrL
	/fnNEkoDfZR9EjqdANiAN9ufFElc3qpXLTj2w=; b=r+61IqfpUrgWVDRHRmVDXE
	jCCBSXTd3q06euxgOETIU3rTawHyWMV2EGvZ8yp9ls4htSX1gnw520qrxR9O4zQE
	PPnA905M6a2+Z1VTw+eopFW1R9BN188qguFdRD7d5fV2k4BWeSDkMpcK7/7rRIcZ
	BtV0VIYlU8ViPxp639/2stDAMFs7OJY7hNo82HzW3moMWQEwEH8i/BgitYIBILf2
	cnSYgEdi9Desswh4+mP+Fzr6jTGjQerprVFbtBKUv+lgsbN9nJWvfF36Xq4zbLzX
	726b4XQH7Ne3bzhPn5aLB41qtano/IdcEBCH2kfNz60tDWXYoEnidMmDY4W48Vgw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxf4er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuK9r000467;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyab0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5HCt43778342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87A6C20040;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58AC42004D;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:05 +0200
Subject: [PATCH v5 03/21] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-3-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=x9xdSjbyG421knKQsJE0As0Fzfy3RA3/kmy4Qmy3OmI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKt2b5Z0V5M+4zY5WbjPOP+V+xLuPe+fuhcH105dx
 CQYUWTaUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwEQ+5TIyHGqV9uN7Gfx9iaGx
 FvfPrmmbU4qf3FuQzTnd+WB3+sr5NYwMHdsMrylE32UW/nxJYf3jm1w3Txzfv5D7ne+h8xPPh/z
 iYwYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXwayytIbxg0Do
 yuqM6K6dGpF6Fqep/4VWDqIa/znx5j/Uy1ij7jVTbTKu/EnwHHU+aQ4NaW+L45hTCHWivKEqOvt
 /yrtA+ITyJZwz7cpVxA+wBOBDAvohAw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f00b2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aPtVb-VRJjWQdk5PnbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CLtsJU8FVMrXn7iaPkIRX2D-JDXI4vSf
X-Proofpoint-GUID: R4O4Ds-5ECgd4HsflqfnYeSqcQyAc2oZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX0MqKPiJhD1Sm
 bjT6igPGAFu+4FDUlUCTHihUgJJLDY81cU6EoZm/JiazrkDiQsAo25eSvoJQag9h9OcPYaBkg31
 5nLImh1WIkfN4xtcBl4n3rDWu9h8wPv7QhQMl6yVDZy4AlHU/XNknQ0XyVXrRdLWc0GjdAcY/Ud
 0tgaYS+yDUucunA9EdKlZ7gjeffrg5RlEQtQP7FkuMqO70PsI2x6MBuAaWr8BNRrG0eLp+x9dos
 Meod/Qwum4NAcUTNUQpccolRKG2jG5YirqLkIj/U7KlltXsXGORPWR4GaQKXiGcKkkNt4XwAEDU
 slFPEdl2CKdykt01lboO/6YcVuzR1TTYfmgfNTjVwd8hrIabNziLeOVxA1dsZFpf8BXMwbZTnCR
 xmmiWQB0Ctyb2RjmmlQCPlvaIZ3pS6co4KYUjxmW2kZzaCZU+ns92FHrCPJvi7Y6CEKNqiI0QRn
 IMnWFFlxLBX/E044SDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260125

Add sensing of the VSIE Interpretation Extension Facility as
vsie_interp_extf from SCLP. This facility is introduced with IBM Z
gen17.
Along with the new facility add a KVM struct member use_ssca that we
enable when the vsie_interp_extf is available.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h | 1 +
 arch/s390/include/asm/sclp.h          | 1 +
 arch/s390/kvm/s390/s390.c             | 1 +
 drivers/s390/char/sclp_early.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..6fdac144ca3a 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -623,6 +623,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_ssca;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 44066550b9b1..9e960c09ce0b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -105,6 +105,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_interp_extf : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221..ae0177d74b11 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3359,6 +3359,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..40e6e346ee08 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -56,6 +56,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_diag318 = !!(sccb->byte_134 & 0x80);
 		sclp.has_diag320 = !!(sccb->byte_134 & 0x04);
 		sclp.has_iplcc = !!(sccb->byte_134 & 0x02);
+		sclp.has_vsie_interp_extf = !!(sccb->byte_134 & 0x01);
 	}
 	if (sccb->cpuoff > 137) {
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);

-- 
2.55.0

