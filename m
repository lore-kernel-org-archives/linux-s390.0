Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D25486E4D;
	Thu, 27 Aug 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846001; cv=none; b=dsucT4meG8GEeJGdSThsGhYPuhG4b7MvY47ywzHlcyNaHGfc/0CMBNxAiw2Ge6ErYV1sfXUgapeHMd2ugFblaIeaP4Bds4Ki/O6bg4pCUog1Y3Zg31y8fLDoMnZWCJCj/OxHeOcpUsfzOxBAtrpoaw8Ne3xM5z/1DRnefA45C0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846001; c=relaxed/simple;
	bh=Sk0VS9XrvUPW7qqVEnp22/JchGdHPI5dmQKVipx7JrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbfP8KHR41uAuHhqxOnm+3XKTUcAE9+lSnIGu65Zxy1H+/EqDck10JZaDwmwd0HzVJpa4VxdrPVpSLy3qENxKbgBXSH3e7NEsn150z/88rcfhs+Nv++tJ2lurDHC5XcZ32z49tOPJXevwHhMYyMme5ZrOCS/gtQELXEKx4PjdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrdWrPpB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrdWrPpB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5TKi3245668;
	Thu, 27 Aug 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pM61a0
	tW4KPESz9o5U3D9Ty4im6w8yHG3QBphobZXL4=; b=LrdWrPpBFIjfbpDcdfR2ny
	4WZqX5MWt/o1WZvSCGVwC/S9Npd6DW4Iv5s9+V/D5/BWRtXeeEGtqtbMpeJjjh+W
	Iobz49IbcUKb38TdxqKj/Q8KDLhdLBhmceN7R+aaqTR4PuXSR4mMapuc95bSxerm
	HzRNJjufVT6Otp0D6SVeoFDD6GlpSkPrdL8Q2n/e+Jk8xQpfnqce2SAfmPtODLuB
	bGbuwISjX+qKUDCCJAAFqCZsVgq+7Bwojnm71vIV7g9/9v7Sc3Y8UkcWgJxToXoZ
	0w5J9paL/SU4LgZJGSfBZfkcn2wkqgW08dvnjH3HRDpm7j5ZCoBVQD+/C8ic1vOQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j6e2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfqrn006107;
	Thu, 27 Aug 2026 15:53:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFrAUE15991108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC91620040;
	Thu, 27 Aug 2026 15:53:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 213AD2004B;
	Thu, 27 Aug 2026 15:53:10 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:10 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:53:01 +0200
Subject: [PATCH v6 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-21-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Sk0VS9XrvUPW7qqVEnp22/JchGdHPI5dmQKVipx7JrQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYkOqVv6fvjOHP96783h8hs/SlMQJCQJa1U+XMdUt0
 d4wiUGvo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIl0n2b4n5Sn5/Hrld2PNxN8
 ShL67lcLKN8XrFNbuO4O+5OjVvyTMhkZDl87+KLt/puOzStnfdNaNkHCK5t3ilSX9nqZB44emjv
 l+AE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX5K2tyqUM/aZK
 9MGDEO1fJVnO3wuVwQ9cGFTlBdyCENCBFZfrHempGrAm/OZEEhiYCRFFYVh3XGqvMWZvMjoFOLJ
 K37gjuxeoHLG7FNDYbr6n3Hy0uF7h0Y=
X-Proofpoint-GUID: 2MZbrFwfliyYDbnBG_XagAfpH1T6XXiE
X-Proofpoint-ORIG-GUID: ToypJ8st3uI0HxSrBqd-4-0jZ46BRwhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1IM74sU+pYRM
 /aDVg+cmI20JLIHAk1uAYzlEgDR52aTFdlUfeeDklIG6zezXEDTbiSKDewldaQB+0uqUNrDYXko
 TRVq5dY7SRu/jNDpsTJA7V5epZ4zjRR8X7ijdfLixX8NK31PXfCFcW/uCaEBFze/f/vyMwZgrUm
 KAXCB/O3QFbp7NQ9pMbjtgUAh8NdHUHJzDJXaaQ7cybmfGM7CklixuIH5N10Z1ARKq6BQDnoKBJ
 HsUl79+qxdlOUd5KIl0tJXrN3RdyDUnTxR9CYB7Y2sImjWHQ6H12Qbg+ccatUcaCWTxSDGQ+hB2
 y34BtgS6LkLVypqOCkRaowPe2ezejjKmMFow84ifTv2IyskZdqFBV896OL+MlUvvSOnMZBu9eJ5
 cDLLh8t52F0s4pNbBaIwUVbcRiwksqm8mT00ix5iXOywgVC8qxZwyt7g9y+4dj4i2TPq71us9Qj
 tHItFewhx7GZXrHGj1g==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a905d6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TE0TNm_Z0-VKmVJMeCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index a1ce75be3955..ffa5bbb8713b 100644
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

-- 
2.55.0

