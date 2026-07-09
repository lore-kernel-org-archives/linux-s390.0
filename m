Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5D3644D1;
	Thu,  9 Jul 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610134; cv=none; b=B0apl5DtcaoPSnaNI4F2nqMVJUdyQ1VjgxWn0isnMn3O6RKZnUJmcOdawVFRvKpyK4BZqlBNGGFXZMQfUXTPUzs+y3NQSijUBsK2a0pnC8WiI4CbSxcqr9ZTOyr8sNVji2ikyY6C8YnGDiH3TipWLJlXeGbRJU1RpliNMUQFxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610134; c=relaxed/simple;
	bh=lSfugQ4ox7yX2nnWxqWBpN7wKn3z9f15Vyp5RTqZ4eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bp6GHNZpmYI7kwfvV3UC1Gc1qRhYmFD0CXuz1p8wqQ+fWrHYj7S9E5ynbiq2YfIMxoUINe6PcuvRE+3f2+yWW36at9BSXk9PRFRsoSLBYIgonU1G/2dtOfXjnFmFbyhs9kKWhKfutthPn/I7b9DN+cZzjOQ29JzxUWXNem+5zEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/2Z0Jos; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/2Z0Jos"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIsia1497586;
	Thu, 9 Jul 2026 15:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LYdFtn
	F6aDHhBjRop2U8bDyUfD7nTU+X2RnSuvHMXYo=; b=c/2Z0JosCtfwDfxPfvXrzg
	UpAxBB1W/9mS3WQHFdkf8qrA2Tjp0Rc7lBXrsNikdpWEgvnPdDnkyMtsWSxR7N5e
	Ss2rmqwy2quFJXT6ewsmdiuZnCj6WHqrhWuqOON2v0+0N1KkpVO6t6b9tVxk5WkP
	2q/+ypoeTAAv0EK/YMa7a1cnsDvZPU78XpGddey4vpWNLBkas0LhaAVpFr51vBBL
	sKJwt8VUShRDlwtYzfpU1EjMpUvehY1TOaY40PJhaEI4zODDp5tvmGmKoHD1Eaml
	QYVyb5YmnqUhS//Kv9MPhRcGJ4FbFxhHyJ95srFZ0R4+DMqAleNdGTzOak7htjWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt2m0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4csr009437;
	Thu, 9 Jul 2026 15:15:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgdfmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFNw143778362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CF5E20043;
	Thu,  9 Jul 2026 15:15:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C89C42004B;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:06 +0200
Subject: [PATCH 06/21] KVM: s390: vsie: Add vsie_sigpif detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-6-ea9f12066408@linux.ibm.com>
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
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=lSfugQ4ox7yX2nnWxqWBpN7wKn3z9f15Vyp5RTqZ4eY=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5mvX2KrKtpjpCatffyGQGPC25q1ryXDsgMyTcoTF
 18uf7u1o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImUbGX4n9u3Se0Rw9zwu1m7
 vM8rti/+vMZjCWd/nW/Ojs1TXjrnmjP8D9Teaez5N//kGeNKlgVNcd+V2HUt1iyv6T7pJXPUfNJ
 fdgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XyC3TzLHrbqGmIk14fB0rLO4qOGeifos
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX3n7D/TRAD1LR
 /bFW4vImO7BmgJ2gvHl2h6unVsw8LWO2MkD6aoazadMFCZx+5BwIDpocHsDNIXEmg+Js3VIP9nD
 XqbC1QdNu4Y6KHqd/OTpGekcvu4K9cc=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4fbb10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=HhGY3ygtAZ2b3DQUAK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XyC3TzLHrbqGmIk14fB0rLO4qOGeifos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX+BXFDq6S1v4U
 pxQCcufYsSVmWmgIc78GLTOXJI+rZnCXAq3Zat2vPjmANnGy6X8/yPw1YrGWQsHIyxW46/Wy/ol
 4NNYj40KHJ3+xE0uh1SY7pO5aEfsLHiHpd49NX/2hs9y+ZRgBZE1OpTfke7n1qsDfcA4fJdMD1A
 K7C7aVO3YnNaJSg5vDxPSTsL6ld8b+y8JjJIXJUmiEJTSLXkZaWVs/dy1Hep7CFQi1Ph0EfM9hK
 aSqoyQNuyKNs6Y6Mp+NLHuxfMyOMS7o/k+H71Gvi8Zr7CTZx4lmLIhW80ucNkx20tvZu3Z7T4GD
 w6boqimsnJEbyR9SaKjbyidqu9hHJYX5dCnzx6ByHjio0zggXN/7Km7MKV3HE7B0//laGkHxqWT
 BrLiqyXhGLWGwaMPaxJRlOYM24Kf13uiOOAF27VRzai+eEMPJhc8o95sVRLRHWzEJ1m6TxIwkMi
 68BBAyM5ODfnqV3sCmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146

Add sensing of the VSIE Interpretation Extension Facility as vsie_sigpif
from SCLP. This facility is introduced with IBM Z gen17.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/include/asm/sclp.h     | 1 +
 arch/s390/kvm/kvm-s390.c         | 1 +
 drivers/s390/char/sclp_early.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eaa34c5bd3c1..f10f8940bd48 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -672,6 +672,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_vsie_sigpif;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index f2d490558054..094b378f997b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -102,6 +102,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_sigpif : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4b1ef955c7e8..6749198bac3f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3378,6 +3378,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
+	kvm->arch.use_vsie_sigpif = sclp.has_vsie_sigpif;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..9ea840d80711 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -56,6 +56,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_diag318 = !!(sccb->byte_134 & 0x80);
 		sclp.has_diag320 = !!(sccb->byte_134 & 0x04);
 		sclp.has_iplcc = !!(sccb->byte_134 & 0x02);
+		sclp.has_vsie_sigpif = !!(sccb->byte_134 & 0x01);
 	}
 	if (sccb->cpuoff > 137) {
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);

-- 
2.55.0

