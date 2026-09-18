Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC94FECE6;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744181; cv=none; b=CrPajFI0K7gkLYN0Z7JJe+uiSJZNmi6yFB0jvOVKqUVgT0W09wuRTPDLZmPwV1/K1o0oANU/7cy/bUQHXKOwmjCe5hozYBVXjQVIiOThdyVSFU4LKzYopKUnqrAFFZd1P0RDPJNsHdgyuQf/1kD9PuTIO9dcPkAKjgqtyrt1a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744181; c=relaxed/simple;
	bh=WyVRCelqJ8S/PhTpT/QOTuqtiO/ioAIjKqgMjkienlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+9Nzl0Jjr+IGE3C3AZ/S/4kiJnPi4FrmEiV688Fpfto7bhTzJSTBnuTZ5Xbguz+INNtujRd7Vo3bE0td7Y3rZ1pdGxAGqNjAy8R+2unK5gChUqQ6jeZDhVi7qzAqp0tKnj4N0wNV7Y5cb0vYpDAXP8Heh69HedfEWD6zjbDCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhlwGw/G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhlwGw/G"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVOEK3708366;
	Fri, 18 Sep 2026 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ffR+w3
	MGZwZ4bcInK9HUfFIXDFMxPCS/HKM2DX5YUeQ=; b=MhlwGw/Gnn8EHNpbgUg37f
	KZsfko8Z7puNKxHWJ7CSYn4UkgFM6p6X+kaazEod+bgSaS7QBfXZ7atOeHqqqm/N
	YgMQ9xuDQmf9UEbqUn4GjSDILHdrSHc3mEOhZo+ccCzvnDD2ifbldjnn/kltD42k
	Bqj1+/nOdacBHIWa6Z3lPw8Lc+mHcOigdB1tkTV8rpg8wQu8ArDkRjhpTb4Lwbd+
	PD+q04n+yMK0gBpEm8OPYDv0IA1j4H9cfRKK/4VZYw3ukFUSevCRqAyxwGlXyXlr
	cgZyX99qoS2Qfp4499hpJnqJwxT0bcae7Q/hMQEwsFUQWmgMMOfsktydyfryPSfA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqrspu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqgU739423;
	Fri, 18 Sep 2026 15:09:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q8m98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9OMY25625254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4029B20040;
	Fri, 18 Sep 2026 15:09:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFAC2004B;
	Fri, 18 Sep 2026 15:09:23 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:18 +0200
Subject: [PATCH v7 01/21] KVM: s390: vsie: Add SCAO read and write helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-1-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=WyVRCelqJ8S/PhTpT/QOTuqtiO/ioAIjKqgMjkienlQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRqbItFLj9oLRPJWZNyyejJk6id5XKz4rI0Hk86a
 anV3rW8o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImY2zD8Zr+tfeKRj4jVV5F7
 K7Q5Y7ZVBc07UL/+9Mb0fSdOyxnvPcvIMM1f8kgV02yjztBZf4yCCpNYfjIdYk4RLlrFuMAsZWo
 IJwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX7E708eyTKNmN
 y5BtcXWfFDrkbheAEMBBpzRg/CQ2CplI+seOc9IbX+pYCMqzqPhFJUVqS70W9MY2vhPYxAbQZYm
 TCrPTtEn9BCh8nP0v4SB6o2/nB8UN2nmmmxyYYqRaRxlmQyHG9UUW9PdgHfQDzc3vd2mxGGh/oa
 ay7WKAiLXPIPN5E37K+JKPPnu9BFmkNrNQhThTUFmGNaacltt/PKGirGOZ+MOmH4wUt4omsACIH
 /dpMWRP4Kn3XRZCCAk5Vc/MGMqt72mWgJJFQ+z6/rEuaRAsAlrAgMusSH8FgpmurUKefEwBQwuJ
 iCkDlhRANom9MOzyg3RzEuyIOeWl93XAqlCtvwysk9Atc/TTG00lPxpu3ByB1bzoOIG423Uuo6I
 MzWRZbG59EsYNG6MxG47Dbu6XMRgLZiUxPBJ5o5IT3+55pnPUk0uaGSWslEjofvIcdbyI1NRjUr
 WWluLGkbhT+phxg7hhQ==
X-Proofpoint-GUID: tr6sXsAx-7SAxH7ldGBYMGXdO6Kc-VYe
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad5429 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: maZeH-CI7fwOI8xzxhWbfCVa3aQkWQMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxqaz5h78OscW
 tt82UeuqouRtHbcT+xUgF+Ssq063qAWZIWS+I5HPGahg9vjR3eIUNZPOlYqcuTWYta+UrBUaKja
 E07sqdUXyOCtBMtV/1HVIEyAkBCqppw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Introduce some small helper functions to get and set the system control
area origin address from the SIE control block.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..61096ee991c8 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -71,6 +71,22 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_block *scb)
+{
+	unsigned long vsie_sca = READ_ONCE(scb->scaol) & ~0xfUL;
+
+	if (test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
+		vsie_sca |= (u64)READ_ONCE(scb->scaoh) << 32;
+
+	return vsie_sca;
+}
+
+static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
+{
+	scb->scaoh = (u32)((u64)hpa >> 32);
+	scb->scaol = (u32)(u64)hpa;
+}
+
 /* trigger a validity icpt for the given scb */
 static int set_validity_icpt(struct kvm_s390_sie_block *scb,
 			     __u16 reason_code)
@@ -716,8 +732,7 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (hpa) {
 		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
 		vsie_page->sca_gpa = 0;
-		scb_s->scaol = 0;
-		scb_s->scaoh = 0;
+		write_scao(scb_s, 0);
 	}
 
 	hpa = scb_s->itdba;
@@ -771,9 +786,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = READ_ONCE(scb_o->scaol) & ~0xfUL;
-	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-		gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
+	gpa = read_scao(vcpu->kvm, scb_o);
 	if (gpa) {
 		if (gpa < 2 * PAGE_SIZE)
 			rc = set_validity_icpt(scb_s, 0x0038U);
@@ -790,8 +803,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		if (rc)
 			goto unpin;
 		vsie_page->sca_gpa = gpa;
-		scb_s->scaoh = (u32)((u64)hpa >> 32);
-		scb_s->scaol = (u32)(u64)hpa;
+		write_scao(scb_s, hpa);
 	}
 
 	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;

-- 
2.55.0

