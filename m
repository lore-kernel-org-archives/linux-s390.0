Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD743E488;
	Wed, 12 Aug 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542772; cv=none; b=VSHBGhFwszLe1AkWzjrEPz1uQ+eu4ejbrV4B05yZLKvbSGAXlkFhtBylsrKeupiuAtsLYKANl7+1vG6O610HenJ7+nH7XfoKkmIHDVnEJTXid7H8bzNyf7IEV2c+6LBKXi/5eWymnSpOJq+zGfVw3p824KiDxoRXCnWhXtlPohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542772; c=relaxed/simple;
	bh=IuqVHPZyHK3727+JTwr97kafzSRGF+uCardxW36QnOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Py80xPfq1Uvd3NiK7f5HtQOPhaMdpxm8HmT8N3gZt8WyWTvCaIIUNC9a45FR049COuF2TiAwQBuIhHIude2PG41sDQYi3aaWGUdkjkC1poGnl1FHzS3Y2r3vDpw9TlOrmz7GnDDuLGXaVFQG1I4F5z3pg1osm1HGwxk/aNtb7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=piJoRecv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="piJoRecv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3ft23334319;
	Wed, 12 Aug 2026 13:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BKO8Pd
	8lxXvR17bFFhXi/kmD0sJGw+2ceAx3Cy1wEo4=; b=piJoRecvSut4c83MoMdWjV
	FChRf9xPh8xLY79z6Cdc6y7hSKYu8wBt+sLwrv9TwED3ctDWC7lS8S3c1eNdYL5D
	koC5gjpNPkjDeUopf9FZZH4jy0Wg56fx9Ms93b9AGLELPSd4fdQCkO/+5p659Mrw
	itITrRAZURLZucM7QSM0mZhQXtVVv56Yyv6Wo2YwWoO0SXbg1GTPapSY7MhmzMhG
	6GPoMR/lrFIa9kUokTllasjpBb4+7vBq5/D2UhjcgY5ld5OCXRS0A4K/ewlc0O7t
	5VWycs7LbMsT2Sjz7++uNGmuUSKG6zvU5TCR4b4+VN64P/uwsjVAnVPa68tN6+Uw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw9wed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfd7a009967;
	Wed, 12 Aug 2026 13:52:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6dmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqepJ51708180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FB520040;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992BB2004B;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:40 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:48 +0200
Subject: [PATCH v4 19/20] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-19-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=IuqVHPZyHK3727+JTwr97kafzSRGF+uCardxW36QnOQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VUvi3KV+mNo65TTv2THLY/2foL4Hd2bd4Y+qCgzV0
 2c/2/eyo5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImIJjEydNiWmOXfD1sSwB6z
 9NU/x7Qc/0JfmTIWfXMH0a+PNt6+z8hw4N4aDuFzjkG95158izyQaGoa5hw1b+lRuyt/+9wWH13
 HDQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c7aad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=o-mTpO_FGGOuZA_1EAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KHlcdV5L5AFlHYJGBlMvdlUVZ6gVyr8G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX0W9UOrBJK1Ub
 /EAzsPZUbEWgJQQ22GjR1Ts246zOFqS2LNv80fEw6dRfSIGWkNWF72HxlXMDdQ8OiDJSqkfRiOD
 eM60qp9G8omHCoDo00k4M+g9z4kKzsBBsOCCxuH+xrghFxW01+lAF1nEzPNRgCKtk1aEa83esOG
 sAV+IbG+BPbMxYCu4TgGCHj72FDkrN0Iu1q3Mf3xGkaCD/GazgiBZjOgZyepl5vYKNzIki7Xm4L
 GY+W0w1o6thTgQ5Hrlrn1eiNzAJmiveZzrHnlwHsETxbI7igpD6FGcQbsew/H6tRCqv1gv0BY6l
 bdo+W0XvM1zjZ47gSnllTCRCqoHIOy/9X3Y61fxQBsJys3704m20tMlxK3MUCtmXo1/nvNVXePP
 n6KF3P0A/V7n4cxLnhS2ZQpvZhBhKvQABuu66LxMKmhnb2+M1sfP+4mZ0mvy0zdMR8QW+wPMH+Z
 coRCPfVlmrneK3Dzsfg==
X-Proofpoint-ORIG-GUID: KHlcdV5L5AFlHYJGBlMvdlUVZ6gVyr8G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX6Juut+Jmg+6V
 pr28Bv7q4egmRBELv2n7jzN0zdOKfNIm+euYRgMb9sA/bAZRn8yk3wsZqtvLsM0ENf3Gwtx5Gxr
 ozJqMBPFBHtulXoccGMOLYLSkVw2XvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120110

Instead of creating a full shadow for vSIE control blocks only create a
minimal shadow for SIGP purposes for currently not running guest-3
control blocks. This reduces the overhead to shadow the whole guest-3
configuration.
The minimal shadow only contains the information needed for SIGPI and
SRSI. The shadow will still be recreated fully when a vSIE is entered
with that SCB later.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 54 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a1b679b4aa36..3a7c58dddf22 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -365,8 +365,7 @@ static void update_intervention_requests(struct vsie_page *vsie_page)
 static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
+	int newflags, cpuflags = atomic_read(&vsie_page->scb_o->cpuflags);
 
 	/* we don't allow ESA/390 guests unless explicitly enabled */
 	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
@@ -709,6 +708,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -728,17 +760,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
 		goto out;
 
@@ -768,8 +790,6 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_KSS))
 		scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
-	scb_s->icpua = scb_o->icpua;
-
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
 		new_prefix &= GUEST_PREFIX_MASK_ESA;
 	else
@@ -2138,7 +2158,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
-	/* pin and make shadow for ALL scb in the sca */
+	/* pin and make minimal shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
 	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);
@@ -2164,7 +2184,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 				rc = PTR_ERR(vsie_page_n);
 			if (rc)
 				goto err;
-			rc = shadow_scb(vcpu, vsie_page_n);
+			rc = shadow_scb_minimal(vcpu, vsie_page_n);
 			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
 			put_vsie_page(vsie_page_n);
 			if (rc)

-- 
2.55.0

