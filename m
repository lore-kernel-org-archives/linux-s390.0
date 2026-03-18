Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8D3E1204;
	Wed, 18 Mar 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852504; cv=none; b=ZMBwv/s9fU3z3Hk6kAR89fwoy2QuZuwbxsTVlnDZbhWAWhKFv9MChK8IVyvgkAmY4flDFpk+x8AZRQr+743OLYgf4BFC84h7rumz5CmaIFLJFwCbZcDH+lp9je+5RzxwpNAYDjXybYz7KRXm5nI5ZKQPFeQyXxch49I0coNwr0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852504; c=relaxed/simple;
	bh=vCUA+cOSJ3XWV3ShPCIE8U2hevDFJz7mNzHtWXortJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoLPWAF/sia/+lOmxkGhiJjQSd+gf+4VPW2TyEa1zL5ZWYpo1U44HqfCBMfexJL5v1PZ9GTAYI7c13m7WnKAvMHto+tGSyNYdfXl6v9xffufhBYg00xljaUyF7REiH84zvx0nGBWqR8I5wHRE87OG4bCDW4X7f0R8qYNKAMOygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pObL+YF6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pObL+YF6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IG0Sgk3794944;
	Wed, 18 Mar 2026 16:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U8+C5J
	sEKI5Hx2NZdT05/uD0xP6LScDFhcO+pyRZFZ8=; b=pObL+YF6Sh6DZPC4mCoIux
	uSboeYtN/9omollNbfsPXy3yKNW05/ybfA2CO+YLOW8++iSlLj6Kjg9s4+w/18KY
	XaxqZuFf+XQsGniN1NxvzRT56h/AWOp9MBLTbPjo0D/obhxQ2VBlEkX7B5ZNFBXh
	SnM3vDGbQmiHdcuauOOUsfXBh4AWIHUQk1Nw03FcLWKNGHWJz91DDTbKakO6S0sE
	sSsi7RUEEs3HAOQytOc2GZjD4hxehpjPvt2ry0TYUA9lptfUcLIsbN+9huucleF1
	HM5+swfqsscLi2rHSclKoG57xZ7L/bmllgwLuasGRs/ocdYAk1ggbwAXZZrwx1fA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsb1ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:48:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ID2IZC005412;
	Wed, 18 Mar 2026 16:48:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sey8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:48:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IGmHqW59965894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 16:48:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A832004E;
	Wed, 18 Mar 2026 16:48:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E572004B;
	Wed, 18 Mar 2026 16:48:17 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 16:48:17 +0000 (GMT)
Date: Wed, 18 Mar 2026 17:48:15 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 05/10] KVM: s390: vsie: Cleanup and fixup of crycb
 handling
Message-ID: <20260318174815.66b3326e@p-imbrenda>
In-Reply-To: <20260316180310.17765-6-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-6-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bad756 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7qAVLcqjNKgLvm1FKecA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: oebLeD_hkfqf6-bZVX8xkHsVaGyQwB4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE0MyBTYWx0ZWRfX6DOG1ikJLvv6
 bfecNMIqFhgS469ypjobSdGv+hev82KpIu/Jg7VU56dWbmC51t8VnNGN5Su4Mub0ZGO6eGYRGUy
 7xWCBuVKnU+0Ndj4uHX+skZMBONCp9oT0b0LcpxdBZjO3nhHwyk/pnZoqD7PIzKiOOg+nIGFWrY
 ZmKIcTi1sER+faGTlp5U4kZs48cS8EqmOFnfiiwLLR13ezV+fbbuqa9UrvugLEj+NextGsdFchp
 vzTSWd+30pUcgSW5EHt975kl/e/lfK03L3XMPBChLIETZ5/pNl2n1ZW55vASUBGQLmEf6eIawg3
 RXwXmJ+nrn0B9imzyBZyz2rDjaK3jvoCXNuaTN4s1mxTvIH3mqqzwDqdU+IC7YOrsB4NDwFvhVM
 JFxcHJ7RLJ4c1PeJqnT/46QSyH1sYa08PYytJ+kWX66xlOldIp6LmNdMvYu/Pe5mU97r8dLVNM/
 F4P2YjR32H+O7IBQ3mA==
X-Proofpoint-GUID: oebLeD_hkfqf6-bZVX8xkHsVaGyQwB4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180143

On Mon, 16 Mar 2026 16:23:52 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> The crycbd denotes an absolute address and as such we need to use
> gpa_t and read_guest_abs() instead of read_guest_real().
> 
> We don't want to copy the reserved fields into the host, so let's
> define size constants that only include the masks and ignore the
> reserved fields.
> 
> While we're at it, remove magic constants with compiler backed
> constants.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |  6 ++++
>  arch/s390/kvm/vsie.c             | 50 +++++++++++++++-----------------
>  2 files changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 64a50f0862aa..52827db2fa97 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -516,6 +516,8 @@ struct kvm_s390_crypto {
>  	__u8 apie;
>  };
>  
> +#define APCB_NUM_MASKS 3
> +
>  #define APCB0_MASK_SIZE 1
>  struct kvm_s390_apcb0 {
>  	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
> @@ -540,6 +542,10 @@ struct kvm_s390_crypto_cb {
>  	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
>  };
>  
> +#define APCB_KEY_MASK_SIZE \
> +	(sizeof_field(struct kvm_s390_crypto_cb, dea_wrapping_key_mask) + \
> +	 sizeof_field(struct kvm_s390_crypto_cb, aes_wrapping_key_mask))
> +
>  struct kvm_s390_gisa {
>  	union {
>  		struct { /* common to all formats */
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c0d36afd4023..13480d65c59d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -155,17 +155,17 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	atomic_set(&scb_s->cpuflags, newflags);
>  	return 0;
>  }
> +
>  /* Copy to APCB FORMAT1 from APCB FORMAT0 */
>  static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
> -			unsigned long crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
> +			gpa_t crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
>  {
>  	struct kvm_s390_apcb0 tmp;
> -	unsigned long apcb_gpa;
> +	gpa_t apcb_gpa;
>  
>  	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
>  
> -	if (read_guest_real(vcpu, apcb_gpa, &tmp,
> -			    sizeof(struct kvm_s390_apcb0)))
> +	if (read_guest_abs(vcpu, apcb_gpa, &tmp, sizeof(tmp)))
>  		return -EFAULT;
>  
>  	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
> @@ -173,7 +173,6 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
>  	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
>  
>  	return 0;
> -
>  }
>  
>  /**
> @@ -186,18 +185,18 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
>   * Returns 0 and -EFAULT on error reading guest apcb
>   */
>  static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
> -			unsigned long crycb_gpa, unsigned long *apcb_h)
> +			gpa_t crycb_gpa, unsigned long *apcb_h)
>  {
> -	unsigned long apcb_gpa;
> +	/* sizeof() would include reserved fields which we do not need/want */
> +	unsigned long len = APCB_NUM_MASKS * APCB0_MASK_SIZE * sizeof(u64);
> +	gpa_t apcb_gpa;
>  
>  	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
>  
> -	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
> -			    sizeof(struct kvm_s390_apcb0)))
> +	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
>  		return -EFAULT;
>  
> -	bitmap_and(apcb_s, apcb_s, apcb_h,
> -		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
> +	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
>  
>  	return 0;
>  }
> @@ -212,19 +211,18 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
>   * Returns 0 and -EFAULT on error reading guest apcb
>   */
>  static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
> -			unsigned long crycb_gpa,
> -			unsigned long *apcb_h)
> +			gpa_t crycb_gpa, unsigned long *apcb_h)
>  {
> -	unsigned long apcb_gpa;
> +	/* sizeof() would include reserved fields which we do not need/want */
> +	unsigned long len = APCB_NUM_MASKS * APCB1_MASK_SIZE * sizeof(u64);
> +	gpa_t apcb_gpa;
>  
>  	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb1);
>  
> -	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
> -			    sizeof(struct kvm_s390_apcb1)))
> +	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
>  		return -EFAULT;
>  
> -	bitmap_and(apcb_s, apcb_s, apcb_h,
> -		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb1));
> +	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
>  
>  	return 0;
>  }
> @@ -244,8 +242,7 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
>   * Return 0 or an error number if the guest and host crycb are incompatible.
>   */
>  static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
> -	       const u32 crycb_gpa,
> -	       struct kvm_s390_crypto_cb *crycb_h,
> +	       const gpa_t crycb_gpa, struct kvm_s390_crypto_cb *crycb_h,
>  	       int fmt_o, int fmt_h)
>  {
>  	switch (fmt_o) {
> @@ -315,7 +312,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>  	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> -	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
> +	/* CRYCB origin is a 31 bit absolute address with a bit of masking */
> +	const gpa_t crycb_addr = crycbd_o & 0x7ffffff8U;
>  	unsigned long *b1, *b2;
>  	u8 ecb3_flags;
>  	u32 ecd_flags;
> @@ -359,8 +357,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		goto end;
>  
>  	/* copy only the wrapping keys */
> -	if (read_guest_real(vcpu, crycb_addr + 72,
> -			    vsie_page->crycb.dea_wrapping_key_mask, 56))
> +	if (read_guest_abs(vcpu,
> +			   crycb_addr + offsetof(struct kvm_s390_crypto_cb, dea_wrapping_key_mask),
> +			   vsie_page->crycb.dea_wrapping_key_mask, APCB_KEY_MASK_SIZE))
>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> @@ -368,10 +367,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  
>  	/* xor both blocks in one run */
>  	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
> -	b2 = (unsigned long *)
> -			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
> +	b2 = (unsigned long *) vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
>  	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
> -	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
> +	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * APCB_KEY_MASK_SIZE);
>  end:
>  	switch (ret) {
>  	case -EINVAL:

