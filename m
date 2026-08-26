Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC144E66A;
	Wed, 26 Aug 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756734; cv=none; b=OW8F1trLplM9UWoBJwZu7XLXwtgOQa82M+6VGiuH1gjy35AtID2R8xAnCjiz/pJRO8dh0LQUv9CjHKmGZjCA5CguFGInXwkZSQ8PXEYzDGF0YmiEEEP2nn4GT5t9xPSXtvxQJWOPZYP7ntyulBzaJ1ln8ybwEP6MYKz2p/uQEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756734; c=relaxed/simple;
	bh=Sk0VS9XrvUPW7qqVEnp22/JchGdHPI5dmQKVipx7JrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQNlKTbnsjurflmFGQ2/lG1iAyyI5uogvcXL0fKRANajJSC+F8Y49UpoLwbcN5VmBQVUCll9zwGQybam8iE746StlyQLPl/zqYUEu/8LMiFvLksheee7md6q6AFDJ80TpynUFs3AbZ1XvMwXc9P7v0Uab/LzvsCMMAwlJlyFg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V1orxd7x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V1orxd7x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1fXI4099699;
	Wed, 26 Aug 2026 15:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pM61a0
	tW4KPESz9o5U3D9Ty4im6w8yHG3QBphobZXL4=; b=V1orxd7xJN+st6V/sV9trm
	s5fnsINorp/1sDcghmc/1gOIbSzOvsnpCfhNhUx2o/L/QLIEVsC8LdzcBEsaWexU
	FcxX2wwMOtblTiyFvHyX6FNBlqmBqEwLNOPI3Fn1RKJKhNNbeQOViTWl/uwqah5t
	Pf3UNK+65zZOZmft5/gd2nKtSYK7Kgl0fbaHLc6ikLeFtdP9t037qMsHX0jOoU/L
	5bnY+5bzEkz9uWQpfyDCGOqFbMOFUAnIF51wSUqz4CPQiD8kjcvOQCNvXpgIItaJ
	ieKPjCbqvL1oNdgfEiSRGTrgeAz755cihFnMFU+7Bz/xONbc54UPuTPGmcb2qrXw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuQEs000769;
	Wed, 26 Aug 2026 15:05:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragjee7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5LQJ48824646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5999F2004B;
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D20C2004E;
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:23 +0200
Subject: [PATCH v5 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-21-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Sk0VS9XrvUPW7qqVEnp22/JchGdHPI5dmQKVipx7JrQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DGvC0h1aCyf/ElFtNmHyjmO+M0npdWQQ6+GEh2FMY
 loezdkdpSwMYlwMsmKKLNXi1nlVfa1L5xy0vAYzh5UJZAgDF6cATOSnFiNDqzZfwiWD59d1PmZb
 nt/0gWVXUOsiS22d2V9mmHl9S2txZ2S4+FvmTFLg1Ntbpt2vtJfPLZHwD9q6MHz7ryfr+OZs96v
 mBgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXzhhUNUeYvtPe
 Ztd2k6wIi7lK3KsL2btYZB43nRpVaW5RdfLL4AUr477vdN4Y4P58adY+qdPZR1SvMfXYooN37SI
 1emFby5CCkU46joRB9RQLj2Z1fJ+c94=
X-Proofpoint-GUID: NCHjnFh2pjytpQXrCSkmkz7Y_7RO_1O9
X-Proofpoint-ORIG-GUID: WcrfHA2WX3VPkoCEkOfZYRwqEk-llXrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXx9cYKdwACWyM
 GVSbIjVm3ZgAxZIqc5pmpmGrwUPZ0lkHLrRpCWHwvbSOQ/KC3R6JMeabzgO7Q6CC9g2gLe6t/e3
 0cswnmTz7JdEqtFuqCDq4oXUP05tI1N6BK+thMoVBGJNxPRCAXVDxaphz4hKRsoZXwTEZNxD3yt
 g74Ge75QfZbkrk01RicC0DZmZLuNtuzIANUfT65YDMEXVCffOjJrgn21FftJgEoz/A6vFg93EGm
 OKvEMx2qAxqUnVWSNyfE6IaxaWSW+edNihjl/f7ow4Xi26EycF2JMZJHbd2e7RCnySYa4Ir0NA2
 c6nFv3r3vxbRSEZEszqhi5wYwtwOxwXNAUHJWgqonc5UPSg3xhJZG5EDd/c29QRKiUSF5NC2ncv
 1AcslwwAzskRCliDzt+r0fPDUzfOYoIC/RGmrLoIBUEBn4H4caJzCw96vbDWMNIXAOketmCZiK1
 qmc6AP9SU/rWqQaRcUQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TE0TNm_Z0-VKmVJMeCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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

