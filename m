Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C7134CCF;
	Thu,  9 Jul 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610132; cv=none; b=DmFB7tU7bD0+fruNtQ7fz+8Mz1Wtl6PpqWVT8++ec5JZ/SPe70oX1vI0g124Uz5lQ5qSsKbLoIEDmW+GiIm2n2jLvtIWThhFCyEqJFhki+MpFsre9RjGofVtiHGaeX/MBzs6Dj2MNwwfFbx4labueHpWaI8aa1Ym/1OlvuK+dTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610132; c=relaxed/simple;
	bh=e8eblGb7mUV/OmNeVUpkOh8VeP6vLV3/oNsGSHvDtVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLa+rX8CrSA51al1JrSspd4idWi2UHRuh8OqcuZBQCEi1WC41QWPLvvjaKc2sr3pJEhWZ+cgT84DCxegOreGRpaCCYpwkUzkHsGVoTXM+u4gC47mvA5n23u/nZbnEwUmumIi3tGHA9obg1sGQ7wMvGaRVFiYxS9GGE5XCflMygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZQHv5k3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZQHv5k3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EINwx2914202;
	Thu, 9 Jul 2026 15:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kLKXMo
	Yq1wFYCxkieEhwNNF425Pmy+H9vB/TlvtoZvM=; b=iZQHv5k3G8XVh6jiTN2K/d
	x05feq1KTgl+QZwzwakSV5zAPsTpvgOLqgDxYXtFc3SCCd2qFsCWLlGf0oMdy7ZL
	HoWnDkdWjMRHCejpGRmZFCF0ofmuy9g0FZdgBov+ZyvzbvtLzgGSIKKgrGi3POmH
	J/fxz9u88GCL2pDH752BJCYwLti68W+KB0N51lTPsuYFCPsh6Z9+PaxUPWhAstxH
	ojvQG5C02JO56oGHuamrhyeEbvCI6ubgu5zjBC5CicEAyzXzoec2IsGQ2JZLSyKi
	yb02AqiAVOGOuxR3VkF3BcbyjLIe3grv4JdqJXRpn9EExVi+oV+i4mw6N3T9hM9Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur22va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EncfE028351;
	Thu, 9 Jul 2026 15:15:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdwc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFM5k24248740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3EF20065;
	Thu,  9 Jul 2026 15:15:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BEF82004B;
	Thu,  9 Jul 2026 15:15:21 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:21 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:04 +0200
Subject: [PATCH 04/21] KVM: s390: vsie: Add SCAO read and write helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-4-ea9f12066408@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=e8eblGb7mUV/OmNeVUpkOh8VeP6vLV3/oNsGSHvDtVc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5l71rv7T5qgKrnqnMbyrf03O+95pAcuOFi4dZaNy
 G3J4ztudZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRO2GMDFcv61mt+7r958cb
 av4Ruz8YW8tcapHKemy0ffu0GseieXMY/kr/2nLahNvVQ2j1fq0Dr/f2if7Y6FywXPRn0b1Vxfw
 X9BgB
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXz33L9l5Ouu/a
 CyYmWPO0gkME+2TvSo1MwB+hWzGBSyo5lXBlHHhKhokdD7Pb+FIJPZc7KouKjvxLnb2yr4s4R1U
 tXEEgLKXrr/cedn8K+YOiJOLx2lMBgs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwSjz7mwFJ2L9
 nI33jyfNOM9v76UKZQSsdAXAnUECyxtQq15EslqFKb+GHFezpxmGHOmHpZoH8B9TAhPjM5/XEtJ
 uGGuS9q5UkuZ/NzaM/5RzkZ0z6VqdQ5aNeAXRRbU2OVtcCQvVCNO/B2dWEt4fOm4+xuQtBHG/uE
 p1DieZZLxkIBDa2sNodqHp7NW9oBPo0bHVWs5vEPkZw/Cz7SZrGG7+RnrWuNdM7RFbJddoc3q4N
 8h7kft7AFTG+xSMGn4Sp/WHUvZRCFOZPZ/7wYANP8kXr2N5kpSNznWE4vsGAC8RgevjHrdg4Cf5
 mHJwwJ3j3Gyf+efB1W3GsnX/z0mEFkQldV5EIAa11HhmfBoitsnUSQhBCKHrPLgZDm7FugZiP1f
 dZI+kDywV6DBDyIz50BCRBsUzlh7+ybaPYud7uE0LQM/BC+KK+hQvVj9b8rCVvg5EkNV6bLcfxz
 vZoAfYUomfPBCn2st4Q==
X-Proofpoint-GUID: e52V7wnrVycIqyEeYAnwXK4IykD72itB
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbb0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Nr3O2JU5-Eb54A3yC_IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e52V7wnrVycIqyEeYAnwXK4IykD72itB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Introduce some small helper functions to get and set the system control
area origin address from the SIE control block.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 937f9c99bc00..aa0cebece2d5 100644
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
@@ -712,12 +728,11 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	hpa_t hpa;
 
-	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
+	hpa = read_scao(vcpu->kvm, scb_s);
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

