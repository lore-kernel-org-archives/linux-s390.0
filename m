Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE033AD9C;
	Mon, 10 Aug 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377275; cv=none; b=IgZf8ojOcVAasmQrIELdmeNxco66eeZFe8Qr+UsqQ0GfJ9xJsB3iPnjCU+w+giqf6v6sbroRqUFi/MF4bAlPHc4Q5cWF0pKJbwj/ruSfKgof6nZIMp5ftelYkwag10Id0xuogJaX9SzFqHfm0/rosX7KYq1vB4CQ+XMPGje6bVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377275; c=relaxed/simple;
	bh=4uD/0oR8DoXMvbC8vlCPP5G5yNpkTTfkmcTHKm6u4Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6TF/NvGbN9vERqfb2QYjhgnBnIiifYGox55qh/XmX80+9EhUpZWMJkNNZGIB/HCuJO2ZfVQfIMmfYpG7kFtUlVEHcX81yC6dcqgfOFfsvg7/9oeTsaTqwNZJDueiC56Q1XOSpMOiSu1ePVCO5btg+fgIhiYqkDee2ay2f4LlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iOqGuI5l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iOqGuI5l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWSgr930699;
	Mon, 10 Aug 2026 15:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UzIAJq
	22VV4bEDeQK9urAivnTLH21QEKOGOyooUj8CY=; b=iOqGuI5lPmc674Mh8jD4wW
	teYIEaWRj+uN0LyBFUhRVMdDi7znXZ9ZWbeq6JGvvhPkWYzIMIToERGT+Sic+IvG
	spLfyuO44Z1u2QIoDGh1C0iWX/papEvfGA0+QJH6CS7efFxrBpBaR8JoxznJI81/
	QQUZdlHOrPlVqEKykI/av5jz6DXVezJzUl4XFYn05oTeD1SzBcp6XS9AHUZM/nVf
	ZgJ1v2OI3Ljdzvx5MKwttVuV2StUcHiQAK2ud6vQ56KL3OKXVx0WjfN5BBN10LOc
	bkgdQ8QMkInG4Z5HCLq91ghvVtTBGaie9PtM92VoMHIHn9uYQOGkShEmkgP9Qjnw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23hs33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgXWA015325;
	Mon, 10 Aug 2026 15:54:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vwh55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsQAH51708412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F09420040;
	Mon, 10 Aug 2026 15:54:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72BA82004B;
	Mon, 10 Aug 2026 15:54:25 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:08 +0200
Subject: [PATCH v2 20/20] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-20-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
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
 bh=4uD/0oR8DoXMvbC8vlCPP5G5yNpkTTfkmcTHKm6u4Ag=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5QDdQWu6LGcmnTthQLf6rO9Tq9mJxr1avjHZ9+88
 mqLfjNrRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABNx38zIcP+p2dI83owD3Ynb
 jq5xaLy7wsNfWqbA/Oqq2Zev6d5Q9mNkuHHmb+HUzju5a5/WKl9PPXC7LcxX2EEkei/HYdbZL0/
 MYAQA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79f436 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TE0TNm_Z0-VKmVJMeCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX483Ank0Se6a7
 nQYOa2nSL8MGaKLh20tHWXp6p2fdn5dI/vRYtdQATRCSwXA3d6YDO5fDpEk7HeHlrAL1m1b3I1p
 8RhEv870UveYp907kyheuAcsPJJBeJmMji+dZKE5Kc5aJ7MnPK5O2ql6hsY35AfPv7ajSgVTBdx
 215ULvhLdx/lITvNcLBUeKfvkQIa94jydNS6q6ClGTflJZn/mY5oK/DkDmAV7Yyq0egOSDl159d
 0FdS0oVxO+nGb8RmanpcztFNpBeyVDfvZLhH7sBZB00ZCiu0VQDNO4fipRnh1EFxbpmmsWOXba3
 Rsf1IbFh4v/QyJDZzWvI8BkjZGBkVfygoTIOJSGGXRukdsx+A+hIgYoVLPqICpqhoKUMBpzgoDY
 vWA46kE7SWUs0WTU/8Taya33DCUcz3YhqAS9qVUnHbpm4Hoj3Ov+smfBe8nuuZAlGc17Zjzfl6b
 Fnmj1voxafHDDq8iTXQ==
X-Proofpoint-ORIG-GUID: Z2Dnwl4CPvDzkfZB45vJyd9xk-E5y6Us
X-Proofpoint-GUID: Z2Dnwl4CPvDzkfZB45vJyd9xk-E5y6Us
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX3zF1XYxPAjUW
 R20ZBigZ0gywAxKOJs/PGcEnfGb5DTkCGroxrQNhSZUN6+SteXuxpzOkw5H9dko0RavMuQor5mF
 Is7YJwXIgRahAuvBMU/sp1+eyCRioqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

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
index 95eb1494370a..f9c934fbd3c0 100644
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
@@ -476,6 +481,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
 	if (sclp.has_astfleie2)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	if (sclp.has_vsie_interp_extf && ssca)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIGPIF);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
@@ -490,9 +497,6 @@ static void __init kvm_s390_cpu_feat_init(void)
 	 * For KVM_S390_VM_CPU_FEAT_SKEY, KVM_S390_VM_CPU_FEAT_CMMA and
 	 * KVM_S390_VM_CPU_FEAT_PFMFI, all PTE.I and PGSTE bits have to be
 	 * correctly shadowed. We can do that for the PGSTE but not for PTE.I.
-	 *
-	 * KVM_S390_VM_CPU_FEAT_SIGPIF: Wrong SCB addresses in the SCA. We
-	 * cannot easily shadow the SCA because of the ipte lock.
 	 */
 }
 
@@ -3384,7 +3388,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf && ssca;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)

-- 
2.55.0

