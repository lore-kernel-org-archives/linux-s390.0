Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38B33DEF2;
	Mon, 16 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684268; cv=none; b=IIOZAW+yiNHI160FKMoBVaaLWGA/xHZ05R6NoNUWbQ84WgCc0p/4qbsWKB8dsaz/xgg97SpnnR8o+cGLcmMkFpVjy5azA4QNRMC4m/4Lw1oM0A2hD8N4THzWDmB2Lw2oBaF2wCkFeq2L/KEvlIuhoYzj3PZT8TD+HhynGErk288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684268; c=relaxed/simple;
	bh=qhzc3hS/hhq+Lm54bXd4u/84aDnb/m9MCOwYDgUAPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJVhaRM/gUa5uWgznsoXVUSzdhjMuc6Q+G7HtfNr8BYAEu2F1pGwNGpK8NRoUQk4BPPZQkzXnYogmw6KOqR/U9EM8AJjrMtLgVIdq1jNDBChqvEjQF8oG4RjaxLfi4SZ9yBDsa/Ywbcv8QBdtxKY2+PdbsCrzVJdZlIj7mqF8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F6eIZJqO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F6eIZJqO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGvl4A1213329;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LohPFM0PCIaRBKaGZ
	jSTY8mzmwgZVxlIZoQbomWKHkI=; b=F6eIZJqOWqa8IAPqBeDLcb24Y0cjirniq
	IqeC3W1kDE2R6k7wNcR9YJcVvO/uRey6T+v8kwtp8yBxAq9GdX+B2RGfkyVdDXsX
	3Pq7fHKsMuzmGDdF2pghmrFhBSDXYpm5wHChNlsCeYD0XqjlqhBnmbpzpgo95Ts9
	MUSIpXdW6TX8GVCEaebDGy1X3sDQr1gWwpHaGGe9rbX6w8ia1OMR3Oe5YbVmtw5Z
	lIPZ0M4Sddcfubjmzh0FmO9AUMB3QLPHZwf3h0975aNJs5Ur2O2tOHmbplC+zJfy
	6/A41YTYyJ1CH3k7zQ66h5wOJOD1klS8DmGqJZqFmEsMo5u1EkHHg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hrywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEbpem004575;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s5xx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4LMg49414608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23DAD20040;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04AE820043;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 05/10] KVM: s390: vsie: Cleanup and fixup of crycb handling
Date: Mon, 16 Mar 2026 16:23:52 +0000
Message-ID: <20260316180310.17765-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cY9X1hlnmawcdYHjGUzlDfwYtUboiGan
X-Proofpoint-ORIG-GUID: cY9X1hlnmawcdYHjGUzlDfwYtUboiGan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX+t7ke9/0mjgU
 5RigsQSkqVu4zxK1fLm/wLiGvu15HxVunJivUtsilKhNW1slhNNxv72o9gaLA/VfkLybhJ8X36W
 Nz3tKuXBgnIwiYuaDaMmSFNwozN8du5oDze8jR388oxlDAG6tfJvjsNRZsLuBFBBl7HQ0soZ4Pa
 A74AnrwdCCZ2Kv0YKK0JbzFwEafy+QN5eyG1IN10z+DJyHeKfxDnMpVDVaRaoxcwDDY7LSnqPjz
 48N+8qJzsV14nl8rQXgg9bgBj4poXE/l+nLZMvO+mAnKPMYHbMsQ7Kq4eqCeIdaqiq4vFCKenxk
 vhR55nTfoU4i1HCPHGGqhhRaFSXqKxX61Z5XqQrJhFPK3c2XGNw4lniRsp24lCTECDXhLOQW4f0
 ia/Pw/DrH/WYCFQJyE5rB9bYIQfQ46BWRnZD2wKDH+Qxiby1CwkMUjdSWBaVFF7TtuKGpfo2hFI
 uyKqDXy3U9S+S72g7gQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b84629 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QpxkGb0qIbYIWvX8zwsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160139

The crycbd denotes an absolute address and as such we need to use
gpa_t and read_guest_abs() instead of read_guest_real().

We don't want to copy the reserved fields into the host, so let's
define size constants that only include the masks and ignore the
reserved fields.

While we're at it, remove magic constants with compiler backed
constants.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  6 ++++
 arch/s390/kvm/vsie.c             | 50 +++++++++++++++-----------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 64a50f0862aa..52827db2fa97 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -516,6 +516,8 @@ struct kvm_s390_crypto {
 	__u8 apie;
 };
 
+#define APCB_NUM_MASKS 3
+
 #define APCB0_MASK_SIZE 1
 struct kvm_s390_apcb0 {
 	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
@@ -540,6 +542,10 @@ struct kvm_s390_crypto_cb {
 	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
 };
 
+#define APCB_KEY_MASK_SIZE \
+	(sizeof_field(struct kvm_s390_crypto_cb, dea_wrapping_key_mask) + \
+	 sizeof_field(struct kvm_s390_crypto_cb, aes_wrapping_key_mask))
+
 struct kvm_s390_gisa {
 	union {
 		struct { /* common to all formats */
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index c0d36afd4023..13480d65c59d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -155,17 +155,17 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	atomic_set(&scb_s->cpuflags, newflags);
 	return 0;
 }
+
 /* Copy to APCB FORMAT1 from APCB FORMAT0 */
 static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
-			unsigned long crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
+			gpa_t crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
 {
 	struct kvm_s390_apcb0 tmp;
-	unsigned long apcb_gpa;
+	gpa_t apcb_gpa;
 
 	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
 
-	if (read_guest_real(vcpu, apcb_gpa, &tmp,
-			    sizeof(struct kvm_s390_apcb0)))
+	if (read_guest_abs(vcpu, apcb_gpa, &tmp, sizeof(tmp)))
 		return -EFAULT;
 
 	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
@@ -173,7 +173,6 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
 	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
 
 	return 0;
-
 }
 
 /**
@@ -186,18 +185,18 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
  * Returns 0 and -EFAULT on error reading guest apcb
  */
 static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
-			unsigned long crycb_gpa, unsigned long *apcb_h)
+			gpa_t crycb_gpa, unsigned long *apcb_h)
 {
-	unsigned long apcb_gpa;
+	/* sizeof() would include reserved fields which we do not need/want */
+	unsigned long len = APCB_NUM_MASKS * APCB0_MASK_SIZE * sizeof(u64);
+	gpa_t apcb_gpa;
 
 	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
 
-	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
-			    sizeof(struct kvm_s390_apcb0)))
+	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h,
-		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
+	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
 
 	return 0;
 }
@@ -212,19 +211,18 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
  * Returns 0 and -EFAULT on error reading guest apcb
  */
 static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
-			unsigned long crycb_gpa,
-			unsigned long *apcb_h)
+			gpa_t crycb_gpa, unsigned long *apcb_h)
 {
-	unsigned long apcb_gpa;
+	/* sizeof() would include reserved fields which we do not need/want */
+	unsigned long len = APCB_NUM_MASKS * APCB1_MASK_SIZE * sizeof(u64);
+	gpa_t apcb_gpa;
 
 	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb1);
 
-	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
-			    sizeof(struct kvm_s390_apcb1)))
+	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h,
-		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb1));
+	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
 
 	return 0;
 }
@@ -244,8 +242,7 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
  * Return 0 or an error number if the guest and host crycb are incompatible.
  */
 static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
-	       const u32 crycb_gpa,
-	       struct kvm_s390_crypto_cb *crycb_h,
+	       const gpa_t crycb_gpa, struct kvm_s390_crypto_cb *crycb_h,
 	       int fmt_o, int fmt_h)
 {
 	switch (fmt_o) {
@@ -315,7 +312,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
-	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
+	/* CRYCB origin is a 31 bit absolute address with a bit of masking */
+	const gpa_t crycb_addr = crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
 	u32 ecd_flags;
@@ -359,8 +357,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		goto end;
 
 	/* copy only the wrapping keys */
-	if (read_guest_real(vcpu, crycb_addr + 72,
-			    vsie_page->crycb.dea_wrapping_key_mask, 56))
+	if (read_guest_abs(vcpu,
+			   crycb_addr + offsetof(struct kvm_s390_crypto_cb, dea_wrapping_key_mask),
+			   vsie_page->crycb.dea_wrapping_key_mask, APCB_KEY_MASK_SIZE))
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
@@ -368,10 +367,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-	b2 = (unsigned long *)
-			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
+	b2 = (unsigned long *) vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
 	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
-	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
+	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * APCB_KEY_MASK_SIZE);
 end:
 	switch (ret) {
 	case -EINVAL:
-- 
2.51.0

