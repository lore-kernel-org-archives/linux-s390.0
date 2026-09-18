Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438434FECC2;
	Fri, 18 Sep 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744189; cv=none; b=gnZznFE1CAB/rh8tV/poqmwPN20t4Q6wyM1SSwImf7oias//6Vs+4Li5VCWp752zYVNXhIUeoqw0p06NseNQDxpwgNnPRmpTt47x0I8uCTl354pmNzfCAlrxoCbLKWfbrGFJJcttYkeGTA+JzpahqbdSlZgVP9OettRK1x5qZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744189; c=relaxed/simple;
	bh=wgs0bhSqi5wjHhHHpXd45G31vwjQJ/Ysa7NeBvBCxu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbF1jG5FOP2TBtGTn/5lhaYG5P1FOtzG7x5/xLZht93y2f/QRJFUgaBaM0EVHvX5+UD3jFzQM8hTFvCa4UZ530HhfQRACama3e2FSIQM1H0NXDNvisCaB0NZsjSR9Zok+qCknTMeEw3hgyRaTX7J/JUcNB1eh51m9jJ9+4lC9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRYMGjgS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRYMGjgS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVWrj1235546;
	Fri, 18 Sep 2026 15:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vf/zrg
	AGhydPytczsDlAnAj3QgyjAGxxhL/LDZGtBkQ=; b=nRYMGjgSr4TJbhwXNXsHKz
	jnhDeqCWR6IjQ2V55dMkt43909eDJyLKSo4G42AmSeIkbKlFzQHPmkin+nDd+xI4
	kGglrcFeDhWR09cuDqBvRH0cJbPUFAwSh13rl49uE40lz2Z4FXXG52uAryj4fltW
	Otm/gPxBiO0Yyea8CVTuVElkzEeJ7SgzZOZOvIZAdTJAdHbMXbuuZcMb/+5uqO8O
	z+bxeDn/D9N+NQyphXKpXGht5RXLIIvMNtTU3QB5EvxThCyd5+Akak3e3pqBmAcz
	KMdxK8jz0sdkbHCR2mTfWFoETMwwSmoHK0U8eXW2FGLs5TkTdGkhNTMA9+GT8IwA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j8gf9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNq8b777341;
	Fri, 18 Sep 2026 15:09:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxxrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Z9u45089238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC4A20043;
	Fri, 18 Sep 2026 15:09:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA092004D;
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:38 +0200
Subject: [PATCH v7 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-21-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3050;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=wgs0bhSqi5wjHhHHpXd45G31vwjQJ/Ysa7NeBvBCxu4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5Tez7Rmn+XxXnFH54lrXG11a3Ya3Hzim9Pj9EZgx
 uuDIfe2dpSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARDTVGhr3vfs5rvL26vrf0
 fs1bPruUyllqU63+Tq0oXXKkVsC48CnD/6AFuQy3XM96+tusdz15trCWQWJimaDvMdOkGXlCGR+
 28QIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX7bxbqAjfju7D
 JztRSS7vbu5mjkdwjWhDwImtadlIj7hw2K4QM4t8PsvSa3hs9vA1WtcHLLaGtFGmIqNvEJgWfCw
 Lu296OnThtzsd3Z9t6CgiZ6NK+T80Xw8eJvh2SzHN9+zF22LpkgvL0cHPCM4TjMkSNuJxQZFSKW
 9u/QpmW6osGvtPDW1K0thmZiKrvN6YAM10kgPWWQMj2AIcDYInX9jQFSqadAthn3todKsnDR2S2
 xYSbJid5jFf4RN+0Ttni2SS49zErK0vIscjr6X4tx8pjEnruuuVacLi/1gil50sC0XwwXBUM0U0
 pYqbOQAIB8DPZyqcbxgej2As3awv13l6ZznCzySzQBy4qCKsCgZv+FqnjN+rQJeUI75acRBbGnO
 eJCPZqiHbrhxxE6boMkorRJVYBYWayFkkiYxmbqn+w1M2jNi0w/aWL+1juuV4m+1bJDBbqfLOy6
 DXNg3ivMJx3z2kflpJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxnRIhmR6XVaN
 UT1z3YMyxL35z0d466QmwUwwCcYl5b99cOFFrl+vAJDwg7pqalHw+ESduvnv1OZV7Ek5NFDum3z
 HbjnWjC0UXmzVZKOW41pMB1qAQkpZ98=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad5434 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6P-c9J5TAbO2NdTwIxwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4WrmhThA_6y6BBghU8iB1ekFND1l07Nd
X-Proofpoint-GUID: 0dcSKH-JVNwuOPrlfRZ-_d88S6A-Kieo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Finally enable code paths actually configuring and using VSIE SIGPI and
SRSI. SIGP can be globally disabled in the KVM module configuration but
will be enabled by default if the machine (IBM z17 onwards) supports it.

This feature improves guest-3 performance by allowing the hardware to
handle SIGP EXTERNAL_CALL and SENSE_RUNNING_STATUS instructions without
exiting VSIE.

Module parameter: ssca (default: true on supported hardware)

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 12 ++++++++----
 arch/s390/kvm/s390/vsie.c |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 1ed962520ced..0d4480bd2cac 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -248,6 +248,11 @@ static int async_destroy = 1;
 module_param(async_destroy, int, 0444);
 MODULE_PARM_DESC(async_destroy, "Asynchronous destroy for protected guests");
 
+/* allow vsie sigp and srs interpretation if available */
+static bool ssca = true;
+module_param(ssca, bool, 0444);
+MODULE_PARM_DESC(ssca, "VSIE SIGPI and SRSI using the SSCA");
+
 #define HMFAI_DWORDS 16
 /*
  * Base feature mask that defines default mask for facilities. Consists of the
@@ -477,6 +482,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
 	if (sclp.has_astfleie2)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	if (sclp.has_vsie_interp_extf && ssca)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIGPIF);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
@@ -491,9 +498,6 @@ static void __init kvm_s390_cpu_feat_init(void)
 	 * For KVM_S390_VM_CPU_FEAT_SKEY, KVM_S390_VM_CPU_FEAT_CMMA and
 	 * KVM_S390_VM_CPU_FEAT_PFMFI, all PTE.I and PGSTE bits have to be
 	 * correctly shadowed. We can do that for the PGSTE but not for PTE.I.
-	 *
-	 * KVM_S390_VM_CPU_FEAT_SIGPIF: Wrong SCB addresses in the SCA. We
-	 * cannot easily shadow the SCA because of the ipte lock.
 	 */
 }
 
@@ -3363,7 +3367,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf && ssca;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index c99cc03ecb81..04c14d33927a 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -147,6 +147,8 @@ static inline bool use_ssca(struct kvm *kvm, struct kvm_s390_sie_block *scb)
 {
 	if (!kvm->arch.use_ssca)
 		return false;
+	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_SIGPIF))
+		return false;
 	if (!(scb->eca & ECA_SIGPI) && !(scb->ecb & ECB_SRSI))
 		return false;
 	if (!read_scao(kvm, scb))

-- 
2.55.0

