Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C743E08A;
	Wed, 26 Aug 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756728; cv=none; b=kfVfqy5ivMqlWY7oXjCyyTL45eHI4XFNVEdLI+pK+H1G14oo112DyK0V9UsmoRn2aRgTrRaWsopcgnZMIwqJasuPN1JOsE9DF9na0XQ3oPC1P2swMmk7/oM+BXFksUyrunclAduqncKBZb98oksYAX1eKP8k/aez1oy512AT0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756728; c=relaxed/simple;
	bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkXQW8dJrvYIBRZE9GBYspy3NlEjBinaScLWpGZ9Ks73JuBELzvxtDouMe211LXIQfreYDFP5SkNPb0Cf0jy0/1breHkpguoZNio/pBggOEmYd/NAN3X62i1j+uG3pqGCORlUvHBvUUfbUKzeRP/83sSCuHBf3FJjK1VUUZ3sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nS4f2Ssy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nS4f2Ssy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1dX74185190;
	Wed, 26 Aug 2026 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EawxfB
	yVCxZV8wl4WZ3USXO4DBROisUO9TVRaXdLcTM=; b=nS4f2Ssy/vQpqlmRm3EL+F
	DaJB8CYMIfi9HQma+FEfI+g6hEbsXHaRWT9sLvOY4Gh5qDFMOcadOxxvxq18Oq0B
	VPcr139qMX0FmDcwYPaDSiY+PpLSlKD3/RyiyEwD6byD1aocK+i0qHdpB5RQGlku
	9El0EMDb/GjPzHisrQ2nziBAVHMz3LIy/c26KiHiaz5FPqX7/EyizpBeSCODLrgK
	+/BtjynCDUTFBpkwiwLe6xexVVp4VCvJgZ1dxFfgv/A6eYY3TX3a4eJFKjQUa2zq
	scL1uELxd64bRJRi9swo0qd6KzJOGLwNErkiYiFkoec61Xd4uWUnBfI3rjk7pTnA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73947ew3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuHL5015592;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5Hb243778338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54AAC20040;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 272B620043;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:04 +0200
Subject: [PATCH v5 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-2-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=V4HbsfI2pYUPkmn8tlci7EFaFet7C5Gz2K4iT2PASkk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKsijF5f9YpVDspfHmysttde6kFa6pzkBss1UXqab
 1Z1nnToKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCInljL8U3G+KjiFhzv37qoD
 QXcrVwfdWbPRWOL73g9ynAU2eyVtjjH8z1p77ci14BsX5/JmF9+SKp+87V666adlYfOVzz20TuP
 gZwMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OSFdpq6iZ4gxLV_UakAUdPeeoyI-Z7mg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX8qB7cNwdFikK
 hAECxozcahUIIFhYznJTC0uX0SjY36tqjwhyw8bWdVHckNmssCwOwCekdWCaoXEkbXfkbhzArqk
 wdv23/6tEWwzu+H+tkOoPh7gullyBdCPOlHGnzeknYf+1sll9gqKkmOiAXYUZFFIuWnNNICFYEG
 0V+zemfxpypJd/i6hLPaVWXRjQ4LWXHdrac8LrW7/8sYuu8GKxX2KYaHS1Nz2azCr0P5Agdtp2s
 rth/zVs9Ypi8mnrG4DQ83QIwEAdtadGzlRl2UKFOLZQai1FqRi6nLOr6HgbSK8Tie8UYeW5tf0Z
 hqIe6OOYbk1kISppl3vbpgy1VmQ6fMVtFJ5bV+WsU4hnpBFqkRyGeY1SToQGYCAUhKBlK097XAF
 eyteRJa08o0IUSphSwsNEC+N8NleruOTmNhwOBk6R3p1MJFl53Act6Ydy7xMIewKxqoiDnApSe9
 td2voiUfNT60G10WIJQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=e9sD66FpFztUsjZjJoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX68ZOS71fzDhp
 y2qXgrzD1f4VDruL9Nd3qCR7GsDYrb2rpCJfpd1/xzjqEC9X+nSm99+f8c0B27oBI9GU5HgWE6j
 8ym6OSr6E6jKPy5EhWyPcqDzVeuhqYk=
X-Proofpoint-ORIG-GUID: MjzZjGnAiXFIoy3-ppeLt2qlBD9r7QM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Improve readability as well as allow re-use in coming patches.

In particular add the logic to be able to check the validity of BSCA and
ESCA origin addresses.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 61096ee991c8..04cb38aad33c 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
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

