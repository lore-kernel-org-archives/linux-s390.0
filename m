Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47733E346;
	Mon, 16 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684271; cv=none; b=Etjaj7Nw/gI1IgJDF/MOmNadJCpjnbXus7pkcjVfddpyGmREZkUht2/Pi4boCuSs23jErb2d93WR9y0GH7lNA35WcpWnLJQFdYois+KsvLov6R6P1ZIAtfnPcfX2cnu1FRHu0IZhVUTxqdLbT9bifi4tAFn9r5yXFmDtFTKuArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684271; c=relaxed/simple;
	bh=P4BtXoCwYSGe4FPYAKwTlj2ViOidJvwe2ipFtG6nKxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgCBOmD0cMjy/snHdxQgiacaTdqwJF2faK4cF5+5nVyTC4MoNdIGGo1NwOPLYecnoqSZa2Ttu+RuqK4AQRZevlupwtejZ6MTry7azmref09WVwygqW/8O6Uq2pQ3dmd32qspIjwknbP4RrPfiO4OZ8ld2MEuSNBYS+Gs7YPi55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NK3pdSPx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NK3pdSPx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEdoGc596541;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s3y4dMVjn1A0xKDrH
	U6gwu0uIljLq6rJg5OHNFQH+P0=; b=NK3pdSPxXSbhhitout2CLw2gh7FVtManc
	LTTyieOPc9xMO0UGa0eXMnRmfrm3s3qaVpICIUL43sIekilv6UnZymlTBzC+kBmE
	X7bm+3HrHO7/4oyd2HYd6+MqcfcO2zv/OTFozJGp1k1mc4mXCQJOBYM931h3cBA6
	CA2H40dZHkUncYNwRQA65Ex5qALdS1bm+uenXk/P7JcmsZbV+5ireF5PclTciNYP
	TwSoCg3LPXogw2LVazVlzbfEVZ8PZ0ynihCwEpI66fS6x3QqlHByM8H52JY6F1Kp
	jA7S0Oc7AbX12eqZQ/ywUBn7A1bBBvzBo68wRohJsmVw38B31vCLA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cru56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFL9un015644;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n5tsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4Lbb49414610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F4720043;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29CE02004B;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:21 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 06/10] KVM: s390: Rework lowcore access functions
Date: Mon, 16 Mar 2026 16:23:53 +0000
Message-ID: <20260316180310.17765-7-frankja@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b84629 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HkVQy8GD3fLFj98UWZwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX3RTmbL34E/fN
 7wUf6yrw6QoTPBI/30k9VHl5QUyu04sb0qWo7nBt1BbGgd0YxxWvNpmXJMDr852fk3mu6Wre7lU
 u+iwjB57Yg7BEzlQQRkjb7MXAWLMZMUQg2uRG9immHan93Ol0s0Fk46vHFY3fw+eR0UpF3aiOXU
 ApHOPxBl9UDcIjWPjnXsRsp1lWaxKg4tB3WE89FmdmiGo2wefQe3V4SoarTIFzvzzc8xpg+TMXL
 nhLBBPJW19xt2MoDxV2x8bqTJGa/KrrvTHIlR5QcLbsTN2qKJN+9gjBL3uKuS3ECd6V5pKj+2cj
 XYrAEeNB8Asa3TpQ72jlFjB/nrLqBWVxRGSd+oa0qi8KP7Qzs7fFIT0FVNFnif/NuNjAIQJP9oU
 a64S7B/Ubbq566xQ+217Gi/HRnF4qP8xERDaaNLJ+p5hSBiGhG1Pg/EnGarHrfRecyLGKme/9HQ
 ENc52ZxG3IIlHtMryig==
X-Proofpoint-GUID: JCwouGBSi9Fye6v-Kv9nJX_xWOsNrvIV
X-Proofpoint-ORIG-GUID: JCwouGBSi9Fye6v-Kv9nJX_xWOsNrvIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139

These functions effectively always use offset constants and no
addresses at all. Therefore make it clear that we're accessing offsets
and sprinkle in compile and runtime warnings for more safety.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.h | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index ee346b607a07..086da7b040b5 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -89,6 +89,13 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
 	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
 }
 
+static inline gpa_t lc_addr_from_offset(struct kvm_vcpu *vcpu, unsigned int off)
+{
+	gpa_t addr = kvm_s390_get_prefix(vcpu);
+
+	return addr + off;
+}
+
 /*
  * put_guest_lc, read_guest_lc and write_guest_lc are guest access functions
  * which shall only be used to access the lowcore of a vcpu.
@@ -117,13 +124,14 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
  *	 would be to terminate the guest.
  *	 It is wrong to inject a guest exception.
  */
-#define put_guest_lc(vcpu, x, gra)				\
+#define put_guest_lc(vcpu, x, off)				\
 ({								\
 	struct kvm_vcpu *__vcpu = (vcpu);			\
-	__typeof__(*(gra)) __x = (x);				\
-	unsigned long __gpa;					\
+	__typeof__(*(off)) __x = (x);				\
+	gpa_t __gpa;						\
 								\
-	__gpa = (unsigned long)(gra);				\
+	BUILD_BUG_ON(!__builtin_constant_p(off));		\
+	__gpa = (unsigned long)(off);				\
 	__gpa += kvm_s390_get_prefix(__vcpu);			\
 	kvm_write_guest(__vcpu->kvm, __gpa, &__x, sizeof(__x));	\
 })
@@ -131,7 +139,7 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
 /**
  * write_guest_lc - copy data from kernel space to guest vcpu's lowcore
  * @vcpu: virtual cpu
- * @gra: vcpu's source guest real address
+ * @off: offset into the lowcore
  * @data: source address in kernel space
  * @len: number of bytes to copy
  *
@@ -146,18 +154,20 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
  *	 It is wrong to inject a guest exception.
  */
 static inline __must_check
-int write_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+int write_guest_lc(struct kvm_vcpu *vcpu, unsigned int off, void *data,
 		   unsigned long len)
 {
-	unsigned long gpa = gra + kvm_s390_get_prefix(vcpu);
+	gpa_t gpa = lc_addr_from_offset(vcpu, off);
 
+	BUILD_BUG_ON(!__builtin_constant_p(off) || !__builtin_constant_p(len));
+	BUILD_BUG_ON(off + len >= 2 * PAGE_SIZE);
 	return kvm_write_guest(vcpu->kvm, gpa, data, len);
 }
 
 /**
  * read_guest_lc - copy data from guest vcpu's lowcore to kernel space
  * @vcpu: virtual cpu
- * @gra: vcpu's source guest real address
+ * @off: offset into the lowcore
  * @data: destination address in kernel space
  * @len: number of bytes to copy
  *
@@ -172,11 +182,13 @@ int write_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
  *	 It is wrong to inject a guest exception.
  */
 static inline __must_check
-int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+int read_guest_lc(struct kvm_vcpu *vcpu, unsigned int off, void *data,
 		  unsigned long len)
 {
-	unsigned long gpa = gra + kvm_s390_get_prefix(vcpu);
+	gpa_t gpa = lc_addr_from_offset(vcpu, off);
 
+	BUILD_BUG_ON(!__builtin_constant_p(off) || !__builtin_constant_p(len));
+	BUILD_BUG_ON(off + len >= 2 * PAGE_SIZE);
 	return kvm_read_guest(vcpu->kvm, gpa, data, len);
 }
 
-- 
2.51.0

