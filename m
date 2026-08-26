Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1A44E66B;
	Wed, 26 Aug 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756734; cv=none; b=l8wQJOwbZdX9nP5oiw4cpfovuqiikMkLrYXyjyWUyPSTubov38+nL+vuotNhzKt3tlspijwGPvoo14iToUXIsw2BSPDvbuNFlFvUbPTtdIBmOqjz9UxHUDB6pYwogH1cWhqeqA+g2p1xp6cIKfC2vZnz+g3qy/jPFL788m+rf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756734; c=relaxed/simple;
	bh=38hQFSzffAiLXm+6Is4YFJxHIFyrsyFLdYUQaxZ01QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMKFosaGtJ8QxoA4DjtfWaemrDVg5FW9fqi/bgnlUu0NzoILbZDmZ1kZH45koUIpNqWf+SYXOQQlH8mDnWMmCTm1XTTd347+JgW8LYrT7DTfKuvEOBOMQCFhx4Ltgem9S398swEBm0d4g/JRaJuiugbvPkm+fG6CiYBNH49k09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lYX1N1ad; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lYX1N1ad"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1WOc2333711;
	Wed, 26 Aug 2026 15:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3aM2Cb
	AevAm1bLJ4YvH+Wu+jeGdiGT/+aMx8y1PqTQE=; b=lYX1N1adVjiaXMDu2l+s7U
	kf+SMnC3oGWht061x9Gs4OUjBJpIlqhet5+Nne0MekUzDmmH1tjDArEHC0VhuSMw
	wO4gz1aHuOLKuzbdcPWNQRnXtLNXpynZKCtQnRHwlYAevyiWr2f+8+87f4GYSomu
	JbhsXRrQ1gaddrZQtLcypXMgWDKXn5RsrxJcqmcM4+KKPu2i1cBpkZkS2BSyEVdV
	V3S2WSPSmCoO/HbsQFtYCgcIoVKm7VHWtX4zWBqYSd9AGCePfmiaZ66GtkDh8Esh
	GC+zcENLXNWq6UBF5eZ5ROf4Xr6l4P/ieRvYberAhIGpPgqlNB2vQjgXyPUEkgmQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqycgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuI8N015614;
	Wed, 26 Aug 2026 15:05:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5L5E48824644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2968E2004D;
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F01552004B;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:22 +0200
Subject: [PATCH v5 20/21] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-20-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=38hQFSzffAiLXm+6Is4YFJxHIFyrsyFLdYUQaxZ01QM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DGsUldfMk2Su/T9rb8ChLYsbfVPip1YdaP3op384Y
 WXRL7G3HaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzE/T/D/5AT6Y0NQkHXlp/i
 k3sly3Xm1tbP+4ytq3MeaN47ZGHfk8bI8Mh78neWXO6J+w4c7n7R8L2C9fDcpQer2Y3fSq3sOms
 gxg4A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: E3shv9Y4phaI_p40zJxzC-nOI60vN3Ke
X-Proofpoint-ORIG-GUID: cr_twafy9_GO4sLsNjmojOfN1VxRpE6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXyEHE2+bDFDA4
 a/FX7NkyUPz/7UjAl5WMoZQxQSLBPT+dgnTJATmOI1QnurgxjBfefHqMuc6hm0+UgSvip6vgtpF
 hV9Q05zrdkXwKGII/XpkSwOfRj7lQOqJhv8HeCdSu25pahNnuANzKNS2LhGdHBVwpbG90bs9gc8
 iFdXaAnS7RC0VT3k+Q7t4GYqepXET/5whpPlhy68oJVS67wYpnoRoeqXd5P1hAPHmgN8ARLbCCo
 jGX4UnYjIkzRpvPvfgvGo1uRPqEi0Ww6prwHmu1+7VpnalknPpTtXXGl3Wv3zpW37PApagVeX6v
 G0AF+o00OGycSEXQijZz1VLV+dgVfV21m9DykihORDU1LGmG+ZqcAGFbvJBQORZbdgJbJ9OV3ee
 a2ST3FxMvFuvPOlELf2WSTHdJCzetJArLphS/LDJRLxG6RwauNK7olmllCPrQK+vsV/Ri4LT5kS
 xcP+aKbmvSgaU15GRxQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f00b6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=o-mTpO_FGGOuZA_1EAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX8VHEwTMhssKb
 KY4C81CLA8ZvfdapSwxah1PjttsNw8ZQAoGc3zI7E7IESRXK3ZUZhCeL1C/OeV25ViFtsWu6oM8
 A/++WZZYfXHL3eSukeqJxiuROLRVCwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
index 335ed1a927aa..86ccd92233b5 100644
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
@@ -2166,7 +2186,7 @@ static int _shadow_sca_cpu(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	if (IS_ERR(vsie_page_n))
 		return PTR_ERR(vsie_page_n);
 
-	rc = shadow_scb(vcpu, vsie_page_n);
+	rc = shadow_scb_minimal(vcpu, vsie_page_n);
 	update_vsie_sca(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
 	if (rc) {
 		/* copy intercept to primary scb_o, no unshadow_scb() on exit */
@@ -2193,7 +2213,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
 	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
 
-	/* pin and make shadow for ALL scb in the sca */
+	/* pin and make minimal shadow for ALL scb in the sca */
 	cpu_slots = is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLOTS;
 	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots) {
 		rc = get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_entry_hpa);

-- 
2.55.0

