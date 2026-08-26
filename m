Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BE40B6E2;
	Wed, 26 Aug 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756728; cv=none; b=QYeoflPhjDSiYhLMF2ODX3INwZO2e+DndPLmAXW/lMAs6lI8pm+mfCwhlxZfNc8DY82ySEhSyrptJiV6n4D5EPghO1tJX9j+iZHPEtuq7bavXWEWMQSu9nOD7yeSz7CLZmTIPy23JPmPn1JLSG1t+8iNkMiZ7iJ1WhzF/ExsCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756728; c=relaxed/simple;
	bh=WyVRCelqJ8S/PhTpT/QOTuqtiO/ioAIjKqgMjkienlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtUoSz098/dgr1vH7N1F0lVi6tbSXJ18z3V4D414UK+LhO66lxtDoJ/zSOBLlvQgIB5hTW7BbTlrTLY+ZOweXuuSx3yIYHnG7IiM+0sNCKHEpCMPcIb0MMelQPX6TN3oEFdhq1F5rwNjSJMEw3ZADl2X+qC8/xL+ldL8K3Q+4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/VeWcFG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/VeWcFG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1XRF4184954;
	Wed, 26 Aug 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ffR+w3
	MGZwZ4bcInK9HUfFIXDFMxPCS/HKM2DX5YUeQ=; b=I/VeWcFGLVzBjLtpWmjsNI
	YmTEpHs409W/mBePggFCppQa6Eanu3iKnxa0+97a7ADbgNrVu+E8HTpfYLtc+R27
	sIzSJoMETZNAhPgHGSsytN39reAwb2aLca7DKbfBplTiJD6D4OW7uW4xoH7AMZ2w
	4f0SdRH2AhCxLeDE3wPAQrI9A+iV2RWH6tdm7qmcPOTu4tiDqKuXgp3LR69tQAs4
	4RtfpFQw49TUNm1fLKesiDSaEe0vVneLeDeFodOeDNmg4AB0yevKugm4VKqJOIM4
	7/h/fe/FNYHM7wOWtPueW5t2thLPkHWLCa9Zy+6J9RirnhXbvdC+AV03g44pJhKA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73947ew1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuH8V020654;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwaq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5HsU43778336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A6262004B;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E50632004D;
	Wed, 26 Aug 2026 15:05:16 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:16 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:03 +0200
Subject: [PATCH v5 01/21] KVM: s390: vsie: Add SCAO read and write helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-1-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=WyVRCelqJ8S/PhTpT/QOTuqtiO/ioAIjKqgMjkienlQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKu+zxd4sGmS5oVzE2ZuOCu7IGJ92dZaZv3UwgzrX
 Sy8XEX2HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAExEcBnDf79ijmVPf7e3XJia
 WK0a/yPLxSdZaea/P0yVHRUySoHxXxn+ac07r7xGNDdc9MntSYcnR3Qtk3766WzmDJNDpT9jfDt
 msQEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Ha-89tj4ndmt_Itqzk7Xjpy5-Skz-uH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX+SOZzb5TZPaR
 xnnuwy7K+BotIS2NQP8qex53LM5V7MSkUE644AD5bgiqVoExiv/IVGggv1zXjLCEU8FOmQ0GKxD
 vAi/P03B8WsnjF6L3KS/AmTJxieHVdoNIbrMT1nhFTmmYu4OxnRSbV3LLxBaA1D6DUPn6e/Oo0h
 fZgatDY9UFzA/EP5g/YlRj9EuYE1zqOIW1HeuQ9tpOebRyMSfI1gV98rAGjlJAjmbnpGUIeXPvy
 E5NUCaksRkYfz9V9dNhnPGaSOiCVs8MEKRgOpUinLajoRj9CEssLujXN8AKuB48t0z6WckmtQTv
 WFqc1SgYHUJAby7VP4AqXGWDUkgN/pJI0DDiNqlDVe5au/GLzp9GxX8Q9bJdqo/C1LGHxtEcWVO
 FUMFQkUiV5SUhS7V2RsXrDp7OjKbBjcR7Hn6CmO9GJVPBuOsdyFSCWRvEVGj4nWlxsSklqQ3w2u
 +xvsO5O4HmepyzmtYaA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f00b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX6qj2tV7ycXst
 fmVsnDISMlq15EQCDqPsRyfo0OJRc6ObCHEgkzBzqlDwcv3NcRf1zX0VYmHuv1TZNej/4lRpsUn
 kkJLQLSvMu7z4rEWLzZOHLRoKsUMA+U=
X-Proofpoint-ORIG-GUID: yNBwUa6ei61-gbaQnrALYU_gzAsuABsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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

