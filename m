Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007D44780B;
	Wed, 12 Aug 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542772; cv=none; b=U/wtZ/DAIpZsSG043u6o3/eFSLOmkdm2TgRpi2xi/BrqTgXiNa8sioCDOgQgmNHss6/d7LYkoV/JzExo+iLiMHDZqdYIzAY1s9z6egJ9lXXfubu3rqngAO5ShiHoE4PHhv7/GdHs9be9UGNZ/a3APyHfduGLgvoeVR2kpgvccuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542772; c=relaxed/simple;
	bh=eb0Fpb73s/V2Ziu/1ghbtVFhMimxN65j9P9amV89XTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scz/u9NvdODFKKhfWQB7SKPEtvYeiMkZIv47w1/Bih0YB846dcWJJi4s40JuBsRe0JWrJqkMoQvIr2rn+q3t+QoUhDZZXDf4Ifht5H7qlwVMSoVZvCkl0/Wqwse5h0BURfseEdYirW/mKX59nQoUHP96sPIAeWYU6zPKMe0H28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/nmCcQl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/nmCcQl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3qP43334582;
	Wed, 12 Aug 2026 13:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LmiYG0
	U+CbvGGEA893juaQfaY3soZFMUr/tKsBzWIlY=; b=R/nmCcQlEGeX2E42JoxABZ
	GF5LMXenyOWyWauJKM8+mcxCGyJH5gFL100BAQ8HaBpDGZLpgK6bChYl77fLz8bl
	VHAbxSoBSmLJIbDmJlmo5gbIBcIpCGVg+1csmkwBOX0J51Q5mXgHOI7cFyvWnZv4
	bp3WXClva0m1navLjMCyMJuMyKwN3dH7x92/vsX4e0Dh2yDE+zMEiU88nLzgwWX7
	Iwrq16afS5Y8TKqAhEJ1laAyCL5GHFOCodgf65k+JW7BoCdgOn/4BcehplykREN/
	fR7Mcvfg13v0n39tCNZMbq8K2S0lKz9v+NyLA9cfwMTPMZbmnFIDOFfeJ8lvYglQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9wef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDpH7j002548;
	Wed, 12 Aug 2026 13:52:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ge4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqfZP42205540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0518020040;
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9DB320043;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:49 +0200
Subject: [PATCH v4 20/20] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-20-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=eb0Fpb73s/V2Ziu/1ghbtVFhMimxN65j9P9amV89XTE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VUum2luwz/x/f+bijElMRmUvmlivBjU+j1MrbY+sN
 /NKqw3tKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCIuEowM01lfNeaayLcn7Azp
 X+55oqn4Ven/TI6fxouXcFmZ3f0Uw8gwb9Gb9LJAWdHtl1zLRDKyfPZVf0uzWOC6VXeLvGQgqy0
 LAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c7aad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=TE0TNm_Z0-VKmVJMeCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FJFL6IOD5f2daSCdnK09hW6aKzPGDhAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX59Lz8tHeITvX
 Bi9gbvLTUsH2f4cmuuDqF9nvFe722rypun1rcKNxkF4fWhKrY7+pb5nxLcgsbEyr2XHfhU6MeeN
 xR5KJ31nSX7OWsabafK04MB/Iu4hrEzBrGDmmbgwZqiz5ccFUllhHheUGW1uCS+szgiUlAePjSm
 2bObu0wmtgaa2lrPbyywNxF9BS1DSpn6LwIdLXFZi1L2eju8RdPmBTRK6Zm063QPzuWU85itbc7
 QdO/8OSjpabSur+krvGtlM9aev+RpzV2xK03XgpneuqiSwl+UXRXd8T0ThrLNAWrInyAzw32y8t
 cfQzwUGWTfzuDRFFLf+ZosNGlLh371SSFM9HkX8AzdhJciQK8zrV487kelkBGflVJ9Dyebohsqx
 XEHKQzPm7untN7Nnf1PWfSQlhjPuX/8A3YrDLOGGHlZ9hxbphz3qSsgIpKmO2nxgJ7PQ5nbd97r
 PedrIwfJbu/TeiafGng==
X-Proofpoint-ORIG-GUID: FJFL6IOD5f2daSCdnK09hW6aKzPGDhAs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfXwjxXA76Ne1j7
 fKZvR5SzOt/mraMs0l+XNbdUn9zQZC2mfHwDO2gFHocFEezd977kZ+cARSvp5vWpMFNh/ePsVLZ
 5ora4/M9QXugo9rSb5wHmtoa4mJSfB0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120110

Finally enable code paths actually configuring and using VSIE SIGPI and
SRSI. SIGP can be globally disabled in the KVM module configuration but
will be enabled by default if the machine (IBM z17 onwards) supports it.

This feature improves guest-3 performance by allowing the hardware to
handle SIGP EXTERNAL_CALL and SENSE_RUNNING_STATUS instructions without
exiting VSIE.

Module parameter: ssca (default: true on supported hardware)

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c21603f2745b..59561d459a4f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -247,6 +247,11 @@ static int async_destroy = 1;
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
 
@@ -3389,7 +3393,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf && ssca;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)

-- 
2.55.0

