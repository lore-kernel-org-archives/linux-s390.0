Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183243800B;
	Tue, 11 Aug 2026 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455420; cv=none; b=LNtvKZ10Z9ykHqC+d8S4DzlstCNu5Tt75lbvh7735JSXesDxGDc3bmJvxTluij1zpy8RNL21L/w7kl2aET4qascCkh6xDiRUG/YS0SWUDrFsi24f2qBeIhR5u65q/KzX4BO8mGGghBz2kJPlPVUNBGr5Gy3u349Ey1H4gF/5l80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455420; c=relaxed/simple;
	bh=pHCrenAwD5S5FIX1m0seyBjNYXqSGHfsbKBr7GwQyEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYRMrfKfHiQ0iIjr9XFYsMTwq+qVVC6+/KoYV/wQITa3bfkvM8DPYM5/QYmzqRlTbnga9AXJbRYgQr+3g0uwpDTg2y9gWiSKNSUBOtwP/S31ruNwdl0062T1S93Fr7KTdJ7VJn0L/yzRfiYc782zdwCfdhrnWqoxqdiO6V8LGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KyEU9YIR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KyEU9YIR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX9ED569974;
	Tue, 11 Aug 2026 13:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WaJoh0
	21r7NaNtnr3qtLTNPjGSrfXQO07qRSQpJGRl8=; b=KyEU9YIRT6JHS6hxpbqrEc
	TuJWxoQIMRLu5LVJ7+JuKSnFC9V2HldH+M/543kdsRY41DkmonL7C7v6Zf7YKw8n
	N6XnI/Hxt3acxiQO7Xpnw8rmq2vcpxdMx21J3MgtJUbj0X4ofo3AXJ1/zgM2ctiE
	oIStKB+qCNH3DM9nxQc5Sn9tRr4UYAOpAJFfrGfrBW4P7JPRfEP0F8Z8+jCJtc/X
	k3X05Mtzl26IRh4k8hksgvjxNUU4OZXPp+3swdiPemMmvktNYbcBMppXF0cCrlOU
	bnpKCMbApoSU9QE6tzN75UvKwZIrbL/nxI2cQhT6jbwaO6IXkiPIOTpnu0d0Rnyg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4frm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQFN3025567;
	Tue, 11 Aug 2026 13:36:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0vau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaUhH17367326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69FC720043;
	Tue, 11 Aug 2026 13:36:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C95B82004D;
	Tue, 11 Aug 2026 13:36:29 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:29 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:18 +0200
Subject: [PATCH v3 03/20] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-3-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=pHCrenAwD5S5FIX1m0seyBjNYXqSGHfsbKBr7GwQyEg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqpG9Ko9m7kn9U7hw8eIGlZUST2UennvmvOUfe3PBi
 yIpnmm/OkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZjI8ZMMf3i/S9y5GnJD7AWb
 wOqYP0def77UYuI8o+ys+9+Fk8o5fGoZGW44t1heXb+s4kDvCsld6maZjQnLpt9j37Lm6a4vy/T
 4XrIDAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2563 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aPtVb-VRJjWQdk5PnbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vA_ghd-km9rccwH3AyEuzaTi6g-DccuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXyO0DcPT2AP0L
 QNrMW7NhUjZiC1yBm07LrJTpP5JTNKj3MQ1SGc7szXbJI/dADQqSd4xs04yI4paBrQE0Cc5kXX0
 tbJAq4t1XfTXv7p7OIOQETNljnmDjLR52dbk5+ci4hE3We33sT+4RiqgvafqpqCoWo1d2Ie1JOk
 WGCoyczo/GXR0C/moGl2QEFKTwBPMOi5MrWFsvtiHcT3IDaOgFlzSHLNHyimY3+tHpjqFLdlXlL
 WF5MKQEsIP2cmYbF3vyUGhvJAIQOY09OwDBmuSV2okF5Lh3PiMzDE/OpdciutBqbI/jnU+Fi1Q3
 EKFzHYi9yJ9+ac5QmpDwG8yGmSKX9+IAOWE4JkCAn5v812QJZmFjEEhYsUD3sw4F2RjP1P1pz5B
 EF/0lCISk+epgqUb893LdgKbsX1JNGyD0uKSE7DoyJ3YNyDvbG7D1UMJ4C/c4LjZgifpEyhu6fs
 DDa4bWl8o2pwLkhYNbA==
X-Proofpoint-ORIG-GUID: vA_ghd-km9rccwH3AyEuzaTi6g-DccuD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXwnERBbE3Cn/X
 sA+HS3q62Zugak8aw4kTUFXPrLPOmasW1uu2fywQYjth5mhfb3FfcSQvZM/KcR9gMLsvNf9Nc7j
 FFsw+jzbcBNcENqG0CIUR1Um17E9dB8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

Add sensing of the VSIE Interpretation Extension Facility as
vsie_interp_extf from SCLP. This facility is introduced with IBM Z
gen17.
Along with the new facility add a KVM struct member use_ssca that we
enable when the vsie_interp_extf is available.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/include/asm/sclp.h     | 1 +
 arch/s390/kvm/kvm-s390.c         | 1 +
 drivers/s390/char/sclp_early.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eaa34c5bd3c1..872a9df4372c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -672,6 +672,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_ssca;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index f2d490558054..d790a5995103 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -102,6 +102,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_interp_extf : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4b1ef955c7e8..908823dd36cd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3378,6 +3378,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
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

