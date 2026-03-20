Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C489264612;
	Fri, 20 Mar 2026 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008102; cv=none; b=KabPhLwDYKqdRP1BiZ6SaX0RLyRN+r8r8GQxUHFb/TQLfjnlG4VImIQvY3LQayTdBdoxgrjd9/dKAESJAaZ2iYs89NiOFtjlIx1IFTb5COuCC2+gH41np+4908Tm98eRoCVHTEU//SRhQej8Kbfxev1fNFMNoPFp2na/JnCPMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008102; c=relaxed/simple;
	bh=gz18zbCVm0sr6y2h/CVfQv69oVWgUovG4pMT8i+56ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2oXNNNKIfU+FPfKfXPmfCw/N7yN2q/zlbswZ9J0A3R8GYnMQDewVspaideT5IREWZunQgq42iOUNOosnqCIBUDwWXj4xomhVyv7HTQL9TYSZ+gN+aO/uHQ972JZywML2EqJT3DJUz8b7iUyAIEqDQvPqogjoVuBpLGfRECeXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bICvUfPK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bICvUfPK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K3U8Jq532485;
	Fri, 20 Mar 2026 12:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=snwT/c
	MthzktX0q1U9GbWRK2f2AGp4W9m/ORi/D7gOM=; b=bICvUfPKzLUDsZANdfN0nj
	5Od+xOYMXtamegNo3i9UwZxCXHYddOKvWvsRxZjjIQNHugTLuX7JdjMioUDuZNuQ
	d6nV2Y1ICWcef908QmsIpd+uhqjDHBRFdcMcn2d65g8aZeK/wvHf2ex2m0b+7Nqn
	EXL/nRb3vm7Zyo9KFTHH7gAN+hiG4K99I6kKaUvMQxiKyx0gYxvjSODP8u/uLbtl
	C4JZz8cNLI/S8X3I0Wpo+K2b0/zr7YwXWINXXqkqcsuOfpDzMGHVYgEkQ/wMyxp1
	d+heZHKOQFwNjFa1vRo9sG3JEqGLIKcrTNRuCR79yZVP/VtR0fGYFv2xGFYDtz+Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3dagw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:01:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBqPJA014011;
	Fri, 20 Mar 2026 12:01:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyf3x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:01:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KC1bGU53805430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 12:01:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806B858045;
	Fri, 20 Mar 2026 12:01:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECDB658050;
	Fri, 20 Mar 2026 12:01:36 +0000 (GMT)
Received: from [9.61.93.103] (unknown [9.61.93.103])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 12:01:36 +0000 (GMT)
Message-ID: <28fafe1d-3b4d-42cf-b503-ca4e5782429c@linux.ibm.com>
Date: Fri, 20 Mar 2026 08:01:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 05/10] KVM: s390: vsie: Cleanup and fixup of crycb handling
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-6-frankja@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260316180310.17765-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd3723 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=7qAVLcqjNKgLvm1FKecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA5MiBTYWx0ZWRfXwbQPnt9KdaBb
 6Mm0B0X3Qh0INCo9EALNNcKbFVXVWf7tOHm0TtD0proQPdFEq3IzXFc6TgxOQLhjrLoA10kAcV9
 y/xlV0k1VjS3VhOzR1A2Q94oFpl+5AIHK+3Q4hfpn4pJ2vbQxmztuGVpS/p1+w9yE4x1fm8DKXF
 ivlEzOHGfUIbB90p0ow9Mngqpei4qotBLCn3h33aR6n2DhVWE7aF6iox88X7UwOGhuEPRVlvMfF
 Vw6zIEacyxI/hJbsKN/u0QF8dqjTwCj81UcNtAbBL75OO9Iq8eHfYXQ55sncwy7kWvfYcAF97dM
 qqJhAn2z8GF2qda3at2pT2fbg/6HDf1iMq6i1YEQqgFMilbUjAFyoiyxj3Blg1ERWT+5/n2kUI1
 BRjkYc/omNo7coQFkETIhV+EfIm7b8sXTHhcx80FFllZ6bOOHXvZPRXeYPsBxWbgmBNKnNyNOJE
 et7OHxqrr5Mq3GSTXpg==
X-Proofpoint-GUID: vI7gJxaIkViExF6RFnTU3CGZ7Mx1rGw_
X-Proofpoint-ORIG-GUID: vI7gJxaIkViExF6RFnTU3CGZ7Mx1rGw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200092



On 3/16/26 12:23 PM, Janosch Frank wrote:
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
> ---
>   arch/s390/include/asm/kvm_host.h |  6 ++++
>   arch/s390/kvm/vsie.c             | 50 +++++++++++++++-----------------
>   2 files changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 64a50f0862aa..52827db2fa97 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -516,6 +516,8 @@ struct kvm_s390_crypto {
>   	__u8 apie;
>   };
>   
> +#define APCB_NUM_MASKS 3
> +
>   #define APCB0_MASK_SIZE 1
>   struct kvm_s390_apcb0 {
>   	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
> @@ -540,6 +542,10 @@ struct kvm_s390_crypto_cb {
>   	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
>   };
>   
> +#define APCB_KEY_MASK_SIZE \

Not critical, but should this maybe be APCB_KEY_MASKS_SIZE
or APCB_WRAPPING_KEY_MASKS_SIZE since
it encompasses both key masks? That notwithstanding:

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> +	(sizeof_field(struct kvm_s390_crypto_cb, dea_wrapping_key_mask) + \
> +	 sizeof_field(struct kvm_s390_crypto_cb, aes_wrapping_key_mask))
> +
>   struct kvm_s390_gisa {
>   	union {
>   		struct { /* common to all formats */
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c0d36afd4023..13480d65c59d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -155,17 +155,17 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	atomic_set(&scb_s->cpuflags, newflags);
>   	return 0;
>   }
> +
>   /* Copy to APCB FORMAT1 from APCB FORMAT0 */
>   static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
> -			unsigned long crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
> +			gpa_t crycb_gpa, struct kvm_s390_apcb1 *apcb_h)
>   {
>   	struct kvm_s390_apcb0 tmp;
> -	unsigned long apcb_gpa;
> +	gpa_t apcb_gpa;
>   
>   	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
>   
> -	if (read_guest_real(vcpu, apcb_gpa, &tmp,
> -			    sizeof(struct kvm_s390_apcb0)))
> +	if (read_guest_abs(vcpu, apcb_gpa, &tmp, sizeof(tmp)))
>   		return -EFAULT;
>   
>   	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
> @@ -173,7 +173,6 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
>   	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
>   
>   	return 0;
> -
>   }
>   
>   /**
> @@ -186,18 +185,18 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
>    * Returns 0 and -EFAULT on error reading guest apcb
>    */
>   static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
> -			unsigned long crycb_gpa, unsigned long *apcb_h)
> +			gpa_t crycb_gpa, unsigned long *apcb_h)
>   {
> -	unsigned long apcb_gpa;
> +	/* sizeof() would include reserved fields which we do not need/want */
> +	unsigned long len = APCB_NUM_MASKS * APCB0_MASK_SIZE * sizeof(u64);
> +	gpa_t apcb_gpa;
>   
>   	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb0);
>   
> -	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
> -			    sizeof(struct kvm_s390_apcb0)))
> +	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
>   		return -EFAULT;
>   
> -	bitmap_and(apcb_s, apcb_s, apcb_h,
> -		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
> +	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
>   
>   	return 0;
>   }
> @@ -212,19 +211,18 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
>    * Returns 0 and -EFAULT on error reading guest apcb
>    */
>   static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
> -			unsigned long crycb_gpa,
> -			unsigned long *apcb_h)
> +			gpa_t crycb_gpa, unsigned long *apcb_h)
>   {
> -	unsigned long apcb_gpa;
> +	/* sizeof() would include reserved fields which we do not need/want */
> +	unsigned long len = APCB_NUM_MASKS * APCB1_MASK_SIZE * sizeof(u64);
> +	gpa_t apcb_gpa;
>   
>   	apcb_gpa = crycb_gpa + offsetof(struct kvm_s390_crypto_cb, apcb1);
>   
> -	if (read_guest_real(vcpu, apcb_gpa, apcb_s,
> -			    sizeof(struct kvm_s390_apcb1)))
> +	if (read_guest_abs(vcpu, apcb_gpa, apcb_s, len))
>   		return -EFAULT;
>   
> -	bitmap_and(apcb_s, apcb_s, apcb_h,
> -		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb1));
> +	bitmap_and(apcb_s, apcb_s, apcb_h, BITS_PER_BYTE * len);
>   
>   	return 0;
>   }
> @@ -244,8 +242,7 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
>    * Return 0 or an error number if the guest and host crycb are incompatible.
>    */
>   static int setup_apcb(struct kvm_vcpu *vcpu, struct kvm_s390_crypto_cb *crycb_s,
> -	       const u32 crycb_gpa,
> -	       struct kvm_s390_crypto_cb *crycb_h,
> +	       const gpa_t crycb_gpa, struct kvm_s390_crypto_cb *crycb_h,
>   	       int fmt_o, int fmt_h)
>   {
>   	switch (fmt_o) {
> @@ -315,7 +312,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>   	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>   	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
> -	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
> +	/* CRYCB origin is a 31 bit absolute address with a bit of masking */
> +	const gpa_t crycb_addr = crycbd_o & 0x7ffffff8U;
>   	unsigned long *b1, *b2;
>   	u8 ecb3_flags;
>   	u32 ecd_flags;
> @@ -359,8 +357,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   		goto end;
>   
>   	/* copy only the wrapping keys */
> -	if (read_guest_real(vcpu, crycb_addr + 72,
> -			    vsie_page->crycb.dea_wrapping_key_mask, 56))
> +	if (read_guest_abs(vcpu,
> +			   crycb_addr + offsetof(struct kvm_s390_crypto_cb, dea_wrapping_key_mask),
> +			   vsie_page->crycb.dea_wrapping_key_mask, APCB_KEY_MASK_SIZE))
>   		return set_validity_icpt(scb_s, 0x0035U);
>   
>   	scb_s->ecb3 |= ecb3_flags;
> @@ -368,10 +367,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   
>   	/* xor both blocks in one run */
>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
> -	b2 = (unsigned long *)
> -			    vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
> +	b2 = (unsigned long *) vcpu->kvm->arch.crypto.crycb->dea_wrapping_key_mask;
>   	/* as 56%8 == 0, bitmap_xor won't overwrite any data */
> -	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * 56);
> +	bitmap_xor(b1, b1, b2, BITS_PER_BYTE * APCB_KEY_MASK_SIZE);
>   end:
>   	switch (ret) {
>   	case -EINVAL:

