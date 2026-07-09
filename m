Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC13859F7;
	Thu,  9 Jul 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610143; cv=none; b=twC++DCPnmzTivmvKszY2LepS8VAE0cLuFk6Qg4BDfS9UGkj2rwgaxMjzquUozQ/6VuNR1COBBJAjstdhk3nSEG3s2x0y2zEMUq+lcYjRTouD4m3mV+Ctxem/2dF30NkKsMg6vvaEhHVLCIsb2fMel9NfsnEKc+4TzZBGpkm04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610143; c=relaxed/simple;
	bh=RsyBxyWTFFAHIqTMxIZtk4vRgEw3t3o13D34GwBCY5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkENGuzsEKs1MuNtJqxImjzxIZWCkRM7b4FQSlw4dQ7+99zIGBwHAo8tUdt77gbgI3qgllk5uHXnUeyVzB+MNmkTTEyzEX72inCbCue/cbMiDHqR5xG09PwGTd9DYBpW8v6BlRUn6IkBod42kYC4r29LmFg4NASlVVX1QyxS1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hnSRo5L8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hnSRo5L8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EICLo2171212;
	Thu, 9 Jul 2026 15:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+qA2Ue
	qOjECQmjfKKXthhnr7Qpaf+EjNcbzaMd2kGNU=; b=hnSRo5L8JClRzF12Xv1rvO
	55aRI4dNKgwimTjvlEex7tawYmp5U5XYTF3UCTiBSXxsmKFzTItpQKbmVqjzqyyA
	9ICALndkCOkewAH+fnG80M6dC8wfkuQ3uI6R5C3fMi0nBKIeqc7HD5c7LSBtLGDj
	/xqjejga9gQdi3cN9neYWmCtnYlQqnl03ZX86anm21ikgPAmSpVQMynqgKpSTMkU
	13NPpvBvH2a8KGVJBWuZprlGDRUi7INbdIjKhk71WYThZAoJjaHgaNR1LryuzM+E
	PAmb3SVtEVKYz4k2rGFXmWDO6u7bacxqXU6dphiv7GyhTDbwXFkOBTp/akFm7w+A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw52bw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EneS9028371;
	Thu, 9 Jul 2026 15:15:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdwd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFXQu46530942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 880DE20040;
	Thu,  9 Jul 2026 15:15:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94E220043;
	Thu,  9 Jul 2026 15:15:32 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:32 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:21 +0200
Subject: [PATCH 21/21] KVM: s390: vsie: Enable VSIE SIGPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-21-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RsyBxyWTFFAHIqTMxIZtk4vRgEw3t3o13D34GwBCY5Q=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u9lUVk6Zk3S8dap7WvOuY2dW2jyrWr3fZeH+Jf5fp
 12s2RAa2FHKwiDGxSArpshSLW6dV9XXunTOQctrMHNYmUCGMHBxCsBEjOQZGbbb/2F/0BItsmrH
 msA1E7aJbz7VspS7UOtu96Jfge6XrugxMtx4NPmFafrUJw+YQkN/RlrvE1XWU/fc/unmv0ef3mV
 zT2EDAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mPk1BiyFoNzxIAEW_4oR0u25ztNWQbqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX+2dct6lgONl/
 U1A0kp1qRAjIxHXgKZuKHPk9+/8fCJM73mGpvIeMmwjat11wz6R7SZlNRoOFJCFxO7UT+YNIpvu
 lSBY6zjrmSpLPsbx8ZYs8LpAM3ZHNahenOnC0nQkiRqAJVT9m+uPyP2W56oRc/3kVKhu9AGK0ib
 iXL6aTXrI6CP6XuHJNRn+UH3WrUzW42kSjRYe727jxRUY5XfkdBLFpyGIC6lRqdd3lbrLXist25
 p9h/ap7VcV+XbxI1w0TemoQVVQ+lxOSZdKkdHCIE4VtMuX4Rr3ypc1KIuJDauwrjpumTzPJ6piO
 J0pbg+Q06emO3Dn48HyyTfJ4BhDenDLjhEYJ/BT+/RAhN6GRcWeKWvIt0WmOLEu4f8R0swE9kST
 CYpRz9MyKQWOD2WB48R7IL9FZKWfs3dJOU6vfMTuUkX3pEFsYgJdvlLiB+88xLHAb5vpa/A1eWn
 42IMHIN6U1/903rImGA==
X-Proofpoint-ORIG-GUID: mPk1BiyFoNzxIAEW_4oR0u25ztNWQbqZ
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4fbb1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=8TOZlKUxrBMHRcGzoGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX+Oem68YKD1jw
 PGHBdey4TVFOlfWM88zFJDIbIWLBDef9+pE//Ps1Bl5XlpDedYuD4Adx4cj7t8LAdS2wecZAAF/
 tW/YMF+OQwCjc2Q13NparWocraCWOPg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Finally enable code paths actually configuring and using VSIE SIGPI.
SIGP can be globally disabled in the KVM module configuration but will
be enabled by default if the machine (IBM z16 onwards) supports it.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 481e566fe228..854de405d08c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -247,6 +247,11 @@ static int async_destroy = 1;
 module_param(async_destroy, int, 0444);
 MODULE_PARM_DESC(async_destroy, "Asynchronous destroy for protected guests");
 
+/* allow vsie sigpi */
+static bool vsie_sigpi = true;
+module_param(vsie_sigpi, bool, 0444);
+MODULE_PARM_DESC(vsie_sigpi, "VSIE SIGPI");
+
 #define HMFAI_DWORDS 16
 /*
  * Base feature mask that defines default mask for facilities. Consists of the
@@ -476,6 +481,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
 	if (sclp.has_astfleie2)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	if (sclp.has_vsie_sigpif && vsie_sigpi)
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
 
@@ -3382,7 +3386,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.use_vsie_sigpif = sclp.has_vsie_sigpif;
+	kvm->arch.use_vsie_sigpif = sclp.has_vsie_sigpif && vsie_sigpi;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)

-- 
2.55.0

