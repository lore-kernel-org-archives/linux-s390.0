Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15832F764;
	Mon, 10 Aug 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377264; cv=none; b=raEaC9BWm8f38nT8kw/DvM9ioeo9mx2OIc4svSZuWE0K/Szum5w8tP86oYmZy/E+GceEUY8yFYCkkDeoLDJoJvJWYUcxuP3IKghIP3LmkxVGfqehbzLYwkWEA5VQPZGXb6DdO/q9PoMVbkQDwFElUE8ovoyifP5s7Cc6yyj4H5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377264; c=relaxed/simple;
	bh=8KTR8/gWyWz7zA1IFLVzOYaqW69NR0kna3/Ox2Sef4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaG+5ZvaSy3gVxzyOREM7NHG2MwSZVicrkrug73AsJqRJ0spqnT1dBm/m4l827zU4jnhvXzr+N7hN0hYDgUEb8q/oy0et8iY1XU1JRhXjCczl6tpOGn3EWFHby5aFH2RWHxyXp0WVRY+BmmRCOcGw64w3VXR5walto+nF4n8UNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMUHj2fo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMUHj2fo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWSrO1941735;
	Mon, 10 Aug 2026 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n6Cpmc
	eyfUfIrETw2OW62zodjVTw1w+L4GIJ0x/lPAA=; b=sMUHj2fooHnGDdl9PcH7uI
	cnXRYYyP+W/DL5WEY+f+Ijok8T3i3WpsEU/wySSM1/JQ11Nxqr00/MMHRYCNawCz
	tP975MfpaYpWH1mhxKP1hDkRH74T9lv+17WGf01tIji+myBpPH1w9mROXEalh8DU
	C6zu6bxWFlPV/41fyOVb+yXeRjX5fM8l31XY/QMBO8XcCfbluSbALmgYdlD+JA0J
	cb0zmZKNBHp332siKTnM34MM+6KiJ7gSD4721aAQaK9BT0ucvwtdjsu4IkbrvMtP
	FsR2jCtgqzzE7v/rFtGyRzn28P2SF3t3MsvkF7OT4pD9JiSppNd9bbj9tGfs1tNg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2rdtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgST4024455;
	Mon, 10 Aug 2026 15:54:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespwjk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsCoE47907194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3E820049;
	Mon, 10 Aug 2026 15:54:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2359F20040;
	Mon, 10 Aug 2026 15:54:12 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:12 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:49 +0200
Subject: [PATCH v2 01/20] KVM: s390: vsie: Add SCAO read and write helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-1-e8d59a2f2f70@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=8KTR8/gWyWz7zA1IFLVzOYaqW69NR0kna3/Ox2Sef4Q=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVXxRLld+0BH8w+MS7R+L/cfHiaI5fDzJdP7/Ji39cm
 1Z0/8OPjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACYi85qR4clMU6HUDLmJNjuM
 t5zwCvr77+w21rI3yzb7m2d/KnwRU8jI0Ce1+YSFQexL9rVlrV7ph+oWNV35HL/Kd4sXQ+a5gM5
 OLgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79f429 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _hDexUSzOGVPWcXgN4yA8MrkLPCqzvK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXxMqKCr+WyaKc
 2T1enn/v14wo1ejUHehLhbYnxhWeN76kRxVMnZJatubtRsYaf69S0eMXSxyDRVNzcBOwAa8+/np
 w3eZPTfcCG7c+bRoh2PkbOHjqmVoxHhxOlZ6GyBQmJE4jfYatPk3VTL74VPlUCd2vlWFenbgtv0
 RgPSbpT8fPGC96zseKZU+/XjCiUiQ/Kk29wLyaBFRiHuA5Xpfntud8FEIaULCOOsiz55oYhiMe8
 2CAqC7Lg0eod3iLhFLLZGiK0CMOgHvW/zXiFN6okIA0eFna3g7fAXrQjIFXPuhtkehdPSJVIdw2
 PYOSSwkmCOpw9i6MwEb7Jx1H6g+G2qKc3hS0EviGiA/RLQygLSHmZbq7YSPrIJ/DletmZcydja8
 sa4LcZmPujuIsh3bpJ0k5RoZGBcjDCxMHMGjRxCIfffalm8J5+EiHuo1k7q/xJKCbWyaJJUudLk
 wraigCDMIZeR6yqs5fg==
X-Proofpoint-ORIG-GUID: _hDexUSzOGVPWcXgN4yA8MrkLPCqzvK2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX6bxRaXnsZtuc
 7YK3iMIDoVEin580+dqmUMzFI2tRFmPSxzLAr1OLnT3sRi3G4/SYurzb+K708H1hI8rUia1U4XS
 /4Jo6xZo6ix21fnlpg7M2zSjtcaOZpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100134

Introduce some small helper functions to get and set the system control
area origin address from the SIE control block.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eb60a359d0aa..010327a6ebee 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
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
@@ -715,8 +731,7 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (hpa) {
 		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
 		vsie_page->sca_gpa = 0;
-		scb_s->scaol = 0;
-		scb_s->scaoh = 0;
+		write_scao(scb_s, 0);
 	}
 
 	hpa = scb_s->itdba;
@@ -770,9 +785,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = READ_ONCE(scb_o->scaol) & ~0xfUL;
-	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-		gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
+	gpa = read_scao(vcpu->kvm, scb_o);
 	if (gpa) {
 		if (gpa < 2 * PAGE_SIZE)
 			rc = set_validity_icpt(scb_s, 0x0038U);
@@ -789,8 +802,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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

