Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F543E074;
	Tue, 11 Aug 2026 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455429; cv=none; b=qWM+fExqnNdcj5hS2D+3smgT6Y9NtY4JoxmC02gH2PzfswqVzCAaG3l4KN/CwhpW45gVGY+Y/Onj6eoIpkczULyHq06hPZHOZ2t04GUxrh6nEovNcFWSiSyjOddWBmZiRPPiLGL+lRK7M0R/YuWxoGMIhBoCWHmaDwlbe25/3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455429; c=relaxed/simple;
	bh=O7SL02TT8NHppOgjP8Vqtbxt9/IOiKhI7TMJciscvls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=et8ggUPjk5yPn5vTvoJI+cyhPqvACNyw8Iuc/wCU880sD49wVljuZK4zlyRV9ScDfzOUiJAeITWUPfPkiz+tf65AaTrGYe245IHTTb4r65OnNDk7Lq27uODBbuDBBB9BmgRvAVT4YiG+Jtm9aE0T/T6lVBSYE/jowLfUov9P7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XRj1xomE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XRj1xomE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX5HK3634496;
	Tue, 11 Aug 2026 13:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XERgtJ
	aujzI76yTWAGyFdJElEeoffQDG8xdh8pspT7M=; b=XRj1xomEmZRfxmZFF9PFY5
	zzHYKURsEwiWydFf5aCfczmtFj50l+/Jm0ZEn5DtdMEfvWqX2WYO4EHhQ4/VJYsn
	1l0YPbr4VHYDdwR2C8RQtiZTgCx3tCAhyvzuw1ooAY5UlNsWxw6H9ocNF03FsM9A
	uczdAK+vr/WfGQrmoxvfUEf8Ofs1m3acTugyA5HOaioWliXa7eyan7lv1egFdfjh
	iqMjVmL0jt4epQBmp4XAUWbRddQ9bclLscuXu2lSdbj5i6ysIs2AX8jR0de/nJHY
	3A5KdzWV8wX87mr2gyJvr9JsB3dlp10kLJCXVSwuJfZAGr146t1Zk6kRcCNIMVXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23nuq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQEIh008250;
	Tue, 11 Aug 2026 13:36:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq185f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaTpa28115272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5DCF2004E;
	Tue, 11 Aug 2026 13:36:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D35E2004D;
	Tue, 11 Aug 2026 13:36:29 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:29 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:17 +0200
Subject: [PATCH v3 02/20] KVM: s390: vsie: Move SCAO validation into a
 function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-2-45aa1ab07c7c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2730;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=O7SL02TT8NHppOgjP8Vqtbxt9/IOiKhI7TMJciscvls=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqpEGOV523jq8GqsOiLJEL96VoBbNcnlLvMzNxectL
 2QERFR0lLIwiHExyIopslSLW+dV9bUunXPQ8hrMHFYmkCEMXJwCMJEF/YwM7aJ5Ux9euvL471Qn
 76XHojvuihXZ8n31/dy/QUbJad9DFoa/gtVPLt/9sZ1zuVnPCnX1O7y2057uT74tIfqs+vC7rk9
 RnAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b2562 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXweq//oj3DdQE
 +uiSM+4X8UcwWquXFOV8vkatsgXLOtAFSrBcAzpuWpnz3+KcdJP/hUoI8cxKB7FFTc37NyUBAmM
 LiEcZIKQhhjEj4FvQtpIqNFc89ARrt9wQz8Loq9IPkEi2ZrROC/g/2HeM6zPl/fyeCMUChxskBn
 uLCKlFH1o0U//8QYpHNSTeRy3n1tbG4OHXK0PMvqLbHqqjrpFKNA829EsQVF8pGph/aTClhCBx3
 28rKpNGJufVhxzoEL75rOuFl4BnfWpCedsxbxrboQUCgaNe8X9HLm2dl9dpkWAwcvQjY7BQSV0A
 OdwuiC2reyWzc/q/4Ct0c9AEyw4UOZzH8MU/8Q/0N80BIk0zvs24Pl2eRDoL7h5Qzr5waOUpCbT
 r8DGlqxe9m+Sh55K4qx+58WJILRK2QVYoV+/xSAjhS+52ghlCcKyVwZPzkYr52zQBKavHsHIYHO
 lfnvsEGIvPCbVzzha4A==
X-Proofpoint-ORIG-GUID: hiEhF6vxP9F4b_rbgbajGygklXGWcho4
X-Proofpoint-GUID: hiEhF6vxP9F4b_rbgbajGygklXGWcho4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX5z18gw9YrdEF
 UonJKDyhiyDYsosiCP9Fy+iQKW5/GC3fZ094/qJYWGPFoTWYw0ELu59Wu17GL8ZuAH8u6ab4E7w
 BADNkiGsXKzUcekzHnCN6AZh1pCvTJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

Improve readability as well as allow re-use in coming patches.

In particular add the logic to be able to check the validity of BSCA and
ESCA origin addresses.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 010327a6ebee..6aa44362033c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
+{
+	return (scb->ecb2 & ECB2_ESCA);
+}
+
 static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_block *scb)
 {
 	unsigned long vsie_sca = READ_ONCE(scb->scaol) & ~0xfUL;
@@ -97,6 +102,25 @@ static int set_validity_icpt(struct kvm_s390_sie_block *scb,
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
@@ -787,20 +811,14 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
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
+		rc = validate_scao(vcpu, scb_s, gpa);
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

