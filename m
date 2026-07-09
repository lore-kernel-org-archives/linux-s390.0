Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1315B135;
	Thu,  9 Jul 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610132; cv=none; b=log/knK94M7NQNRfQpV1tAOia1uG5jY6/NgQHa0N6Kr9MOxLJIe2BkpNQaN+/AvzKaYKo2wy0fmvIUFqMPLAsnJhqs5c/TGiNtydg701zGNMcINxZBPgi7HhBJqRD6snTnXiWoccXh7F/ayilGMtoWFlKufNAq3QeD+vy1r8q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610132; c=relaxed/simple;
	bh=dqUrKjawqR/cMjtXyhnBKUYru9BMwr+M6EbZaOSoMTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUx2tABzgb1JjAM7JfdOyAH6xELGH4ILeRyzgNzV6PSUoV0HR+/NV6Lkv5rWqqQSlHcMIR0ff1Pet8A1VUVMaYduCUySf+109jcL5V2/8uGkk+OOpp7avozGY56pGraEqiciXJD3S2b6Kk06FscGqztdId0jMJRz37YKB3pGb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lGDbE5U+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lGDbE5U+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIj7q1770389;
	Thu, 9 Jul 2026 15:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XeY+Fa
	q/cioSPRX9DjdR234BozEokD0XwJajB/p5K40=; b=lGDbE5U+adcbghU9J4XDSV
	R4Pk5cVPaDTgdDyGly5g1rrVRcsEE3ffwvGwv3XnwwiaXeuK1KMigm+bouxXgRtY
	ySQkxSQbUDsx8rs/VkBakyg076LUTYvRyHSW6AwLmEIG/oMv2+vHyTZty/6flj2N
	JWoLhsG73kBG9xG+vZ/CtnLjBuQ72PvdgX8/+c8b9Iyi4l++m5eNgujusEDSg/p3
	RiIK4gDPQjmzEyky0hMbLfvzGCrzpJNUsAZXw0WXfc2rxQoTsuhir194ql8XEDu/
	T5y/Sjw8lHjY75OejiAopPSUr4jDwlK8o4QNkZXR4lYprMJgC8PhDg6K7VeXXzOA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2ppr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4fVC026928;
	Thu, 9 Jul 2026 15:15:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwdvcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFMVU24248746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86262004F;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F43E2004B;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:05 +0200
Subject: [PATCH 05/21] KVM: s390: vsie: Move SCAO validation into a
 function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-5-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=dqUrKjawqR/cMjtXyhnBKUYru9BMwr+M6EbZaOSoMTI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5nFNHwKRZ8dvGBss+9Oe1KnZ4BYNrsBi4KTzZ4y/
 dRJwtIdpSwMYlwMsmKKLNXi1nlVfa1L5xy0vAYzh5UJZAgDF6cATETmPyNDw8Yv/64r8DD+O2j5
 uqLo8OpXCvw5245lHT2RaSXR0Xr1CMM/Xafl4if8t0jnqk388ISveLW18M8CzTObFy238+64tHk
 XFwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4fbb0f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=s9IE1rU8jnNbY5ds4h0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX47dvbxeJJaho
 nf/DttjQ7B+4amVkxhWJPv0loln5PBw1O5b++xFBi+jqNUTlNY4OkGkiSnUvJwtofTy0GHP6qv6
 O5kONijmD6h6zrWN16F/iA52C2N4KKpI+pBEIQlfJ1ml/fJW/NHF86+DibBnoTYdAm/r/7c8tiT
 RXqS0cfyEHBC2n0NQpD/vhg6HUSdjYrNhm/KhrdlolfTZwhPwX0M3fvDUnJXO6Huqjj5ya1M6Fi
 YYqVir3iRxodvc1gDvqzOag7pvMMdTn4XJVsTTI8sbiHXWGfsPCCyuwjzP/oUxhZfsK2lmGUZIg
 i38GPT/+Z8uESJ8CeHTwYAlhjXfZ9q6+GdWR3KUU8MPRZpfiuOTQoTGiOiQ4T2EaTbRsgAVpYAG
 JYM4uLxnfCMkpPGDyi8XmAPyWfa/WcbDqgizCLIsvhgKUKCvtXTQXRhqv8HXVnIxKzkj2oGDDtf
 P4GWyZ03RLvyRPD4xlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX7p35VI0tM2ul
 HzwCsxBn2YNSzLLGDUeXyPOWoQTdL+dBwHiF0Tt1Nzogfk3yFfsqHabBzDbv6G1KgeYwTkRkMrD
 QHxh/r3ZiD5FoI8uKr9/8MWUmTOuvus=
X-Proofpoint-GUID: a2FvJ1x14yWlzTAGW5iGEmX2_IyA9Z_w
X-Proofpoint-ORIG-GUID: a2FvJ1x14yWlzTAGW5iGEmX2_IyA9Z_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Improve readability as well as allow re-use in coming patches.

In particular add the logic to be able to check the validity of BSCA and
ESCA origin addresses.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index aa0cebece2d5..97581b748a94 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -72,6 +72,11 @@ struct vsie_page {
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 
+static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
+{
+	return (scb->ecb2 & ECB2_ESCA);
+}
+
 static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_block *scb)
 {
 	unsigned long vsie_sca = READ_ONCE(scb->scaol) & ~0xfUL;
@@ -98,6 +103,25 @@ static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 	return 1;
 }
 
+/* The sca header must not cross pages etc. */
+static int validate_scao(struct kvm_vcpu *vcpu, struct kvm_s390_sie_block *scb, gpa_t gpa)
+{
+	int offset;
+
+	if (gpa < 2 * PAGE_SIZE)
+		return set_validity_icpt(scb, 0x0038U);
+	if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
+		return set_validity_icpt(scb, 0x0011U);
+
+	if (sie_uses_esca(scb))
+		offset = offsetof(struct esca_block, cpu[0]) - 1;
+	else
+		offset = offsetof(struct bsca_block, cpu[0]) - 1;
+	if ((gpa & PAGE_MASK) != ((gpa + offset) & PAGE_MASK))
+		return set_validity_icpt(scb, 0x003bU);
+	return 0;
+}
+
 /* mark the prefix as unmapped, this will block the VSIE */
 static void prefix_unmapped(struct vsie_page *vsie_page)
 {
@@ -788,20 +812,14 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	gpa = read_scao(vcpu->kvm, scb_o);
 	if (gpa) {
-		if (gpa < 2 * PAGE_SIZE)
-			rc = set_validity_icpt(scb_s, 0x0038U);
-		else if ((gpa & ~0x1fffUL) == kvm_s390_get_prefix(vcpu))
-			rc = set_validity_icpt(scb_s, 0x0011U);
-		else if ((gpa & PAGE_MASK) !=
-			 ((gpa + offsetof(struct bsca_block, cpu[0]) - 1) & PAGE_MASK))
-			rc = set_validity_icpt(scb_s, 0x003bU);
-		if (!rc) {
-			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-			if (rc)
-				rc = set_validity_icpt(scb_s, 0x0034U);
-		}
+		rc = validate_scao(vcpu, scb_o, gpa);
 		if (rc)
 			goto unpin;
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc) {
+			rc = set_validity_icpt(scb_s, 0x0034U);
+			goto unpin;
+		}
 		vsie_page->sca_gpa = gpa;
 		write_scao(scb_s, hpa);
 	}

-- 
2.55.0

