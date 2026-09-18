Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF65013D1;
	Fri, 18 Sep 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744192; cv=none; b=Kd/Y5Or8BuAHaJchJtbzfCDHeCXwNnhjx06dzV7p1Hq//qTdDmO8vMOsXcJwPCZCSVnA1vqsQDko96QqBw0xPLdYxbh2Nj/iVwLxDS+99YkeL18H/JJWFAEjWigsHbQ8iEgSiQ3OvpVtG8Ytt3PHpOe67uOot1n71KsYPzvirw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744192; c=relaxed/simple;
	bh=Xl/IVPjeWMVMgIyZV2GvUtopczkskX2ss7OUApwATC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIO+YVVeox2VkPeO0Sso1UsxOPmj0cuRSwiLFnACUqQyc/X2arM77jeY3EHoZlUG3bGJ8qZcfivr76uU3V8LzRwa1lvZV8Ku4TYuuGBpPAtGVmpQPjU/BbcnChYJ7QombXYGLwPbUGhQeQuiDPoCaEwnljXeGpb5evn1ffAhvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gEUzRKlD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gEUzRKlD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVqTh217736;
	Fri, 18 Sep 2026 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ymFlJj
	ltUcjYYNyKKwhv2MiDvnpOhraIgt7iptWV5BU=; b=gEUzRKlDCQu4WZPBrZw4TR
	6wDxxNczp5ToShxnoekgSE2wxjbvfKODzGl9v/KG5qkrvFrEiPSkgwog54ldoAD8
	CLGjpf3PJYG8IfRvBujDRg6Ocv4ZSUAyRW/2zEJzR+ybzI1xmgdLuRHqLyrN7Taz
	OpVF26J/pXrB/wynIMlAont3N82QGtjCh7LGvn839f7JSJ0feqhQSP3nqtYvVgTY
	NVlHCHTRgvjcR4r0RNPXKQGMRSe0ATp0busxfZgG/BPh7h3Xm8LVMqKj64Bavq8S
	c1I42sjgZu/UN5JohYWBVfJ5Wg9RQ3HgKYLDYERsqOC6ycnOJNev3GBylR6+/QvA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ega1t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNq2i695555;
	Fri, 18 Sep 2026 15:09:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fexfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9YQ843909508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F9A62004B;
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B8CD20043;
	Fri, 18 Sep 2026 15:09:34 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:37 +0200
Subject: [PATCH v7 20/21] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-20-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4201;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Xl/IVPjeWMVMgIyZV2GvUtopczkskX2ss7OUApwATC0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5SevTfetPvVvxcelsLJJvd3HP41PcXBYn/y3LOX3
 jG+ablY2lHKwiDGxSArpshSLW6dV9XXunTOQctrMHNYmUCGMHBxCsBE/tUw/BWuuqQ9Z1vP0tVf
 Pmuw7d4Sy+wsPn1GiPbKXoPJ8gzucZMYGc443Xt3+wC3aIGK1BmeWPva7uYv3O4bEucV7tOdEZ1
 7jA8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxvXD6+gL2vHx
 Z04kqtMC3jWQsJfZTTp3wIMR9fSuSUO7ictLwvFFBQiTWKF9ZpCMKU1/mVo9tSPqqVhAKXM6lQ6
 szd2HjBaaSiSioE3AXgV9JNrULyFZGAdMpGYndtyAOLd/SqxO0JSeVHmwCqULv10s9kTjCGpqWY
 Vk+/FKqBHJU9NHA/ocW4McoBNjorvbR/oX8MvnIZZQsTqKpiRTUblbWOqYNkxfrCUNbq3HWRxLH
 3WCG//3132KdKEyQx7vwomieVuoTuGdVMMf9hJSTUJW/1JWCa61aMOlCgzqKJZ+jlxFtTNM1K6Y
 l4m3aMGDAgnc9WvhueUQp7pKJNZdCOugyqlv9NmhHQYMZP33P5Xq4gSNPr4D3xedFrdzZYXknwf
 xpHFr1RPyMdrvPExJM2nD8Vp6ChtdHN2+tKt0WrvUrxbrY1oXF6dxUoeXrF9LkksQfcfe0iuQi8
 zSOF51IRZjGIA1C8JXg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad5433 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=o-mTpO_FGGOuZA_1EAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GLnlOJjlYHfleayh7SrcZ6mdoDKCMBcE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX/6TtUN1tdmMS
 p16WIfz+yN+vSgFl3H9woKlAdQdFWz4t4/Jk1b0Y7WiDEXIr3Bl3xl3c0Fdv+30cwv8K+6+Y72e
 FnGJQ/DmRsPhixim1YGxt1vkBJRYpqw=
X-Proofpoint-GUID: KkaUlAThE-dfoQ0UCvUKVADLRemH-G7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

Instead of creating a full shadow for vSIE control blocks only create a
minimal shadow for SIGP purposes for currently not running guest-3
control blocks. This reduces the overhead to shadow the whole guest-3
configuration.
The minimal shadow only contains the information needed for SIGPI and
SRSI. The shadow will still be recreated fully when a vSIE is entered
with that SCB later.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 54 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 59037964efc9..c99cc03ecb81 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -368,8 +368,7 @@ static void update_intervention_requests(struct vsie_page *vsie_page)
 static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
+	int newflags, cpuflags = atomic_read(&vsie_page->scb_o->cpuflags);
 
 	/* we don't allow ESA/390 guests unless explicitly enabled */
 	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
@@ -722,6 +721,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_o->ihcpu = scb_s->ihcpu;
 }
 
+static int shadow_scb_minimal(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int rc;
+
+	/* make sure we don't have any leftovers when reusing the scb */
+	scb_s->icptcode = 0;
+	scb_s->eca = 0;
+	scb_s->ecb = 0;
+	scb_s->ecb2 = 0;
+	scb_s->ecb3 = 0;
+	scb_s->ecd = 0;
+	scb_s->fac = 0;
+	scb_s->fpf = 0;
+
+	rc = prepare_cpuflags(vcpu, vsie_page);
+	if (rc)
+		return rc;
+
+	scb_s->icpua = scb_o->icpua;
+	scb_s->ecb2 |= scb_o->ecb2 & ECB2_ESCA;
+
+	if (vsie_page->vsie_sca) {
+		scb_s->eca |= scb_o->eca & ECA_SIGPI;
+		scb_s->ecb |= scb_o->ecb & ECB_SRSI;
+		write_scao(scb_s, virt_to_phys(&vsie_page->vsie_sca->ssca));
+		scb_s->osda = virt_to_phys(scb_o);
+	}
+
+	return 0;
+}
+
 /*
  * Setup the shadow scb by copying and checking the relevant parts of the g2
  * provided scb.
@@ -741,17 +773,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	unsigned long new_mso = 0;
 	int rc;
 
-	/* make sure we don't have any leftovers when reusing the scb */
-	scb_s->icptcode = 0;
-	scb_s->eca = 0;
-	scb_s->ecb = 0;
-	scb_s->ecb2 = 0;
-	scb_s->ecb3 = 0;
-	scb_s->ecd = 0;
-	scb_s->fac = 0;
-	scb_s->fpf = 0;
-
-	rc = prepare_cpuflags(vcpu, vsie_page);
+	rc = shadow_scb_minimal(vcpu, vsie_page);
 	if (rc)
 		goto out_validity;
 
@@ -781,8 +803,6 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_KSS))
 		scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
-	scb_s->icpua = scb_o->icpua;
-
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
 		new_prefix &= GUEST_PREFIX_MASK_ESA;
 	else
@@ -2190,7 +2210,7 @@ static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	if (rc)
 		return rc;
 
-	rc = shadow_scb(vcpu, vsie_page_n);
+	rc = shadow_scb_minimal(vcpu, vsie_page_n);
 	update_vsie_sca(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
 	if (rc) {
 		/* copy intercept to primary scb_o, no unshadow_scb() on exit */
@@ -2217,7 +2237,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
-	/* pin and make shadow for ALL scb in the sca */
+	/* pin and make minimal shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
 	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);

-- 
2.55.0

