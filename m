Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517F45A28C;
	Wed, 12 Aug 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542773; cv=none; b=bV3PKmQ7Udp2YxUwVc1+E3Ox7/ZsW8EY7a0jj4Mcx6H8SI6xv0n9Smwwpsv4lthS8dSrg39iuacALuqSnT+ZZ1eq43/EuiIF4BIchDzv0u9OxrQrtxM9gWv+4Hmyrc1rfKzRzzTmHNCNT5ZmFvPIJqZFldZ15m+V7OOFCqpsSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542773; c=relaxed/simple;
	bh=gt3oFXVsO9ZKmnbuTcmUbo2xjAXRTQ2Ryh6cdULM1CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgcArWNdFfJbahsWY8GV+9Ps+cE5bS/DhaRiysirhvbmgWy+vGb2Xw//uh9ChmDoxxeGcku0XhD/scRP4tsu1/ME3g1pLx9LEd2T+suMBYnchGmHsJk3C5mxf75Q6wPxll3d/2OZMCBC8B4yFjKQUnhVYsmBRQvQ45SnDmlG2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q9eGeFH4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q9eGeFH4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3XHD3304229;
	Wed, 12 Aug 2026 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UOKLS2
	blBwvhyJFRg3UuOsYnC8xhL6ZlkBabsPInew8=; b=Q9eGeFH4mqEEsvh8aT/1KX
	/HTZbxnVdBiquA+mpUHz9m89BVyBVw85D58JqexGYR0YsmQoRLdzWq6ZLmVneLBi
	JIUgaBHS73GlHgvsP/PlkQ/60VPloA8n87iFYvKtINLHo6S1Nx/MvJjNlWPEyqDL
	3LYR3ONyD0IZYogyemD4SJ31BYXlSuLpeFq/3AQNKl7zeEYbHs04AIZxDpsflFZi
	JSfgmzADSljyG1XWfV9N9jlRD4NwBNf8zqzLSqvjbS0gS+L0wnH+1claqnCP6i/7
	N5xeLxozOsQBtK0gyb7hpFQpBIfJ1pP+RO5LHGI+p0eRk0VXtER2JZk2qnDkCpMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9trn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfd6D004194;
	Wed, 12 Aug 2026 13:52:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w6c4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqbRL40894964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03B9920040;
	Wed, 12 Aug 2026 13:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C983C2004B;
	Wed, 12 Aug 2026 13:52:36 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:36 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:30 +0200
Subject: [PATCH v4 01/20] KVM: s390: vsie: Add SCAO read and write helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-1-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=gt3oFXVsO9ZKmnbuTcmUbo2xjAXRTQ2Ryh6cdULM1CE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYse/Dy2k/tpUePCTSKGfKVxGiUvM10dPFMNH0zbb
 D1p3yrNjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbiu4qRYXrrZT/7DeZGc1h2
 2nAlGjTc4Kq32Ff2/1TjXW3PpD3c7owMM60NT7h0BZ9s2BiXdjwtfuK+lbvfJbff8y29y/Um6FI
 LLwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX4Qj3lD0aBT29
 3wMoYUUrQjO0ubMQar7SW4W8AS+1Ydfi1YA855AtkVo78cwM0x3voyVrxfL8EZTh56GURLp3bDE
 7KQ78pTMCnPgxgLzfnaRe+E2wVCaw7pBlOZwu5PCIyzdtKuFXpPY82gpf0s6o4IioqjTpNFHzJl
 zLNLSABBXw/QS+vYItnwRa9Y86NIam3q0QDI3fJ1AiHqtCBscmEIW9F0Lr22eXowHmmXcKYaEbs
 xyOexm6kCJOUcX5gVw+1VQHnCH4e9v6Ty71dZ9DLirr5ZaarKFLTqEfaXnsNeZvxPTy1QiwCz92
 IhpfBd7nTdfrGWOBGmFH90GphWa/ZUb550Y/FGk881kQueU+1IagyCNlDQ7szZVfvhPBeGccI42
 Sma5lklsVD7qkCPpmjQbaPQ5je5pg8qsxPIYLVfugmHMbC7vMhdC3AWduEQyWMs8hW5xTUyZrTz
 5TiNUoe/3I1BYcKBkwg==
X-Proofpoint-ORIG-GUID: kGmtFoxdGuUTBzybs4Pqdc4tqsiqHKS3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX7dCrDwD4shgD
 gdFLWs9lo3DbfoR2yYnG8ZldY74IAlXwSW2ta0VHpHchvB7e9BT4R8t/YTYU4d40KRq/L0ZOW4y
 XouIGuodvpr3y88GhBjNPU7vU7HGSes=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c7aaa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Nr3O2JU5-Eb54A3yC_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kGmtFoxdGuUTBzybs4Pqdc4tqsiqHKS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120110

Introduce some small helper functions to get and set the system control
area origin address from the SIE control block.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..7bf3e921ca9a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -72,6 +72,22 @@ struct vsie_page {
 
 static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 
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

