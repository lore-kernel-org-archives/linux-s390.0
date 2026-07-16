Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1983B0ADE;
	Thu, 16 Jul 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211729; cv=none; b=leIq7BWJuabOu8FeFHO+HnO08geMOcES61m0osap34WVMK+VyGCCrOFIpd+0SeX/h9roaSHFcD+iDykVCB4LR5YTyPX0VFs1v9DVx5mUGdT5XgFMq08Pg2wz5aLFYCisGKzk7Kv6brK0qjE4pUZJm+k4gDtPOcMYLU2xHSkm56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211729; c=relaxed/simple;
	bh=mrg7cTZeYgv2D9EWb89FzZGaihfSJmv4t4VXiGlm6s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+w67buKnIawj9Z9jZVlAeokNmwPBLKkGquhoY1YettFo8A+DYAQPC6HBAsEdBBxlTm0CGlcV/LbdlVor2Itpkuh15Gus903iy4ZKYtIUvHJKn/yxJ1wefwMDIYkYSxy5BF9OOGivvgtqYL1hvCpGK6ArNwqXjLwYVFJFqFeGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BxIV8WFj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BxIV8WFj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfjnk3273448;
	Thu, 16 Jul 2026 14:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f4yPaE
	G2q5tM/XGVO0fdQYCkoBUou23QTNwA12JR1F8=; b=BxIV8WFjL+/jzXXGvrpV/b
	H584A31VDpemgrRS/Y+oZLy26/DJIZZwOrUuoLJcG8d/UDLqeBstvstql/tgkUHP
	BZi+8dgJsd77f5kM5VitYfofdYNJBsJcYou2JeUjZHh/1XldYF8E9E4SF6UxLvY8
	5vNAPmWBL/m9UaEYlLrgeBXAIHo4oK9Hgm2Svs6ZNn3B+SK8ULzze4IAM6pvQ+xl
	r39vtuiGpaRUDu2SF7m25oEpgdOv1voo36kuvYsk83Bb9VJfeeyWTt/QMHtmpR7H
	gQGX7HBfjxZc8mmXgLfXa+FNxIIUIiF9JVpruy55V/yh1oKyEnwPYK+FWO0kdPig
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx0g6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:22:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEJmVG006680;
	Thu, 16 Jul 2026 14:22:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyd2ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:22:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GELwTi52691442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 14:21:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CD920040;
	Thu, 16 Jul 2026 14:21:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3056020043;
	Thu, 16 Jul 2026 14:21:58 +0000 (GMT)
Received: from [9.111.49.171] (unknown [9.111.49.171])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 14:21:57 +0000 (GMT)
Message-ID: <ca5af32b-ad55-490d-bbf0-6206d563141b@linux.ibm.com>
Date: Thu, 16 Jul 2026 16:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] KVM: s390: vsie: Shadow VSIE SCA in guest-1
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260709-vsie-sigpi-v1-16-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5y9GjcdfFy9Oh6h7SWjnqIhl_8i12MS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfXz8i9WdNW4RvI
 RVsrUWIQAAWicLoPqE00gbCDTRixTi8MlkWxoDqkwbdjD7lFKVSsLRG/J+O/B/wQ4gOzQo38kwP
 cX2UZqykOuyG9ooBr17tFNUhqjQJXgW6J/dJuSxrM5K9KWbw53+mfFmlQN/06L52ekhWF+radg7
 FaUFn4euItrz2iMyf2OJKFP7pkGfJYyLNWjRepiYu8OU53reS+ekTCj8mXYmJ7EBHFXyw5fx9we
 wKx+C1FuBIOsTD+FSgsNfPd299TJYu9sS1+i+Lqg/5gpRZlQwvULeDo/GU7lShQooaAfRXdNlxZ
 oDucevkIEDOqD0GoqsBwLIP7VcZgbC/TShTagyPq8GVrBzCZL9BCt9+U5Ni9CqRB21v+Z7GKNid
 rLpg8fmbMRy3Xo7PYD5AhrPfD6cw2zFGyW5dayywsIZuNYiNhFW7MP/Ao0lIQgRtzeKL7U1grsG
 av9b0PlqZih+1HeXVQw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58e90b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-V_BxU0aTHG7VP08UxkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5y9GjcdfFy9Oh6h7SWjnqIhl_8i12MS6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfXxJzWgBT4jG9N
 i9eYCccqubYpptknflBAlxMkNoTl9Oic+Tlx0lcTlN8ZAwrjrlPv/80jIvgBys83LPGpXuura9B
 q2FoTTs+FCLspHy7GaS1xlAsq+CSThg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146

On 7/9/26 17:15, Christoph Schlameuss wrote:
> Restructure kvm_s390_handle_vsie() to create a guest-1 shadow of the SCA
> if guest-2 attempts to enter SIE with an SCA. If the SCA is used the
> vsie_pages are stored in a new vsie_sca struct instead of the arch vsie
> struct.
> 
> When the VSIE-Interpretation-Extension Facility is active the shadow SCA
> (ssca_block) will be created and shadows of all CPUs defined in the
> configuration are created. SCAOL/H in the VSIE control block are
> overwritten with references to the shadow SCA.
> 
> The shadow SCA contains the addresses of the original guest-3 SCA as
> well as the original VSIE control blocks. With these addresses the
> machine can directly monitor the intervention bits within the original
> SCA entries, enabling it to handle SENSE_RUNNING and EXTERNAL_CALL sigp
> instructions without exiting VSIE.
> 
> The original SCA will be pinned in guest-2 memory and only be unpinned
> before reuse. This means some pages might still be pinned even after the
> guest 3 VM does no longer exist.
> 
> The vsie_scas including the ssca_blocks are also kept within a map to
> reuse already existing ssca_blocks efficiently. While the map and array
> with references to the vsie_scas are held in the arch vsie struct. The
> use of vsie_scas is tracked using an ref_count.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h       |  21 +-
>   arch/s390/include/asm/kvm_host_types.h |   2 +
>   arch/s390/kvm/vsie.c                   | 575 +++++++++++++++++++++++++++++----
>   3 files changed, 528 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 1439f9496bd0..c0e5caf0eb16 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -621,13 +621,32 @@ struct sie_page2 {
>   };
>   
>   struct vsie_page;
> +struct vsie_sca;
>   
> +/*
> + * vsie_pages, scas and accompanied management vars
> + */
>   struct kvm_s390_vsie {
>   	struct mutex mutex;
>   	struct xarray addr_to_page;
>   	int page_count;
>   	int next;
> -	struct vsie_page *pages[KVM_MAX_VCPUS];
> +	struct vsie_page *pages[KVM_S390_MAX_VSIE_VCPUS];
> +	/*
> +	 * The vsie_sca_lock is used to synchronize access to
> +	 * - the kvm_s390_vsie.scas[]
> +	 * - the kvm_s390_vsie.osca_to_sca map
> +	 * - new vsie_sca creation and initialization
> +	 */
> +	struct rw_semaphore vsie_sca_lock;
> +	struct xarray osca_to_sca;
> +	int sca_count;
> +	int sca_next;
> +	/*
> +	 * In addition to the use of the array when entering and exiting vsie the scas[] is
> +	 * accessed from the gmap_notifier without any lock held.
> +	 */
> +	struct vsie_sca *scas[KVM_S390_MAX_VSIE_VCPUS];
>   };
>   
>   struct kvm_s390_gisa_iam {
> diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
> index d6025b34a66d..ae0c56393475 100644
> --- a/arch/s390/include/asm/kvm_host_types.h
> +++ b/arch/s390/include/asm/kvm_host_types.h
> @@ -6,6 +6,8 @@
>   #include <linux/atomic.h>
>   #include <linux/types.h>
>   
> +#define BYTES_PER_LONG 8
> +
>   #define KVM_S390_MAX_VSIE_VCPUS 256
>   #define KVM_S390_MAX_SCA_PAGES 5
>   
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 4b492af15542..74455c689c51 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -86,6 +86,7 @@ enum vsie_sca_flags {
>   struct vsie_sca {
>   	struct ssca_block	ssca;
>   	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
> +	/* The mutex is used to synchronize access to the pages[] */
>   	struct mutex		mutex;
>   	atomic_t		ref_count;
>   	gpa_t			sca_gpa;
> @@ -120,6 +121,17 @@ static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
>   	scb->scaol = (u32)(u64)hpa;
>   }
>   
> +static inline bool use_vsie_sigpif(struct kvm *kvm, struct kvm_s390_sie_block *scb)
> +{
> +	if (!kvm->arch.use_vsie_sigpif)

So, looking back at patch 6 it was a bad decision to name this 
vsie_sigpif since sigpif makes up only 50% of the features.

If we stay with the spec naming it would be:
use_vsie_interp_extf

Or something similar. Maybe a simple use_ssca would do as well.

> +		return false;
> +	if (!(scb->eca & ECA_SIGPI) && !(scb->ecb & ECB_SRSI))
> +		return false;
> +	if (!read_scao(kvm, scb))
> +		return false;
> +	return true;
> +}
> +
>   /* trigger a validity icpt for the given scb */
>   static int set_validity_icpt(struct kvm_s390_sie_block *scb,
>   			     __u16 reason_code)
> @@ -822,14 +834,18 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   }
>   
>   /* unpin the scb provided by guest 2, marking it as dirty */
> -static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> -		      gpa_t gpa)
> +static void unpin_scb(struct kvm *kvm, struct vsie_page *vsie_page)
>   {
> -	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
> +	hpa_t hpa;
>   
> +	if (!test_bit(VSIE_PAGE_PINNED, &vsie_page->flags))
> +		return;
> +
> +	hpa = virt_to_phys(vsie_page->scb_o);
>   	if (hpa)
> -		unpin_guest_page(vcpu->kvm, gpa, hpa);
> +		unpin_guest_page(kvm, vsie_page->scb_gpa, hpa);
>   	vsie_page->scb_o = NULL;
> +	__clear_bit(VSIE_PAGE_PINNED, &vsie_page->flags);
>   }
>   
>   /*
> @@ -838,19 +854,22 @@ static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
>    * Returns: - 0 if the scb was pinned.
>    *          - > 0 if control has to be given to guest 2
>    */
> -static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> -		   gpa_t gpa)
> +static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   {
>   	hpa_t hpa;
>   	int rc;
>   
> -	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
> +	if (test_bit(VSIE_PAGE_PINNED, &vsie_page->flags))
> +		return 0;
> +
> +	rc = pin_guest_page(vcpu->kvm, vsie_page->scb_gpa, &hpa);
>   	if (rc) {
>   		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   		WARN_ON_ONCE(rc);
>   		return 1;
>   	}
>   	vsie_page->scb_o = phys_to_virt(hpa);
> +	__set_bit(VSIE_PAGE_PINNED, &vsie_page->flags);
>   	return 0;
>   }
>   
> @@ -898,6 +917,74 @@ static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
>   	return 0;
>   }
>   
> +static int get_sca_entry_addr(struct kvm *kvm, struct vsie_sca *vsie_sca, u16 cpu_nr, gpa_t *gpa,
> +			      hpa_t *hpa)
> +{
> +	hpa_t offset;
> +	int pn;
> +
> +	/*
> +	 * We cannot simply access the hva since the esca_block has typically
> +	 * 4 pages (arch max 5 pages) that might not be continuous in g1 memory.
> +	 * The bsca_block may also be stretched over two pages. Only the header
> +	 * is guaranteed to be on the same page.
> +	 */
> +	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags))
> +		offset = offsetof(struct esca_block, cpu[cpu_nr]);
> +	else
> +		offset = offsetof(struct bsca_block, cpu[cpu_nr]);
> +	pn = ((vsie_sca->sca_gpa & ~PAGE_MASK) + offset) >> PAGE_SHIFT;
> +	if (WARN_ON_ONCE(pn >= vsie_sca->sca_o_nr_pages))
> +		return -EINVAL;
> +
> +	if (gpa)
> +		*gpa = vsie_sca->sca_o_pages[pn].gpa + offset;
> +	if (hpa)
> +		*hpa = vsie_sca->sca_o_pages[pn].hpa + offset;
> +	return 0;
> +}
> +
> +static void put_vsie_sca(struct vsie_sca *vsie_sca)
> +{
> +	if (!vsie_sca)
> +		return;
> +
> +	WARN_ON_ONCE(atomic_dec_return(&vsie_sca->ref_count) < 0);
> +}
> +
> +/*
> + * Try to find the address of an existing shadow system control area.
> + * @sca_o_gpa: original system control area address; guest-2 physical
> + *
> + * Called with lock on vsie_sca_lock.
> + */
> +static struct vsie_sca *get_existing_vsie_sca(struct kvm *kvm, hpa_t sca_o_gpa)

Shouldn't sca_o_gpa be of type gpa_t?

> +{
> +	struct vsie_sca *vsie_sca = xa_load(&kvm->arch.vsie.osca_to_sca, sca_o_gpa >> 6);
> +
> +	WARN_ON_ONCE(vsie_sca && atomic_inc_return(&vsie_sca->ref_count) < 1);
> +	return vsie_sca;
> +}
> +
> +/* Try to find and get a currently unused vsie_sca from the vsie struct. */
> +static struct vsie_sca *get_reuseable_vsie_sca(struct kvm *kvm)
> +{
> +	struct vsie_sca *vsie_sca;
> +	int i, ref_count;
> +
> +	for (i = 0; i < kvm->arch.vsie.sca_count; i++) {
> +		vsie_sca = READ_ONCE(kvm->arch.vsie.scas[kvm->arch.vsie.sca_next]);
> +		kvm->arch.vsie.sca_next++;
> +		kvm->arch.vsie.sca_next %= kvm->arch.vsie.sca_count;
> +		ref_count = atomic_inc_return(&vsie_sca->ref_count);
> +		WARN_ON_ONCE(ref_count < 1);
> +		if (ref_count == 1)
> +			return vsie_sca;
> +		atomic_dec(&vsie_sca->ref_count);
> +	}
> +	return ERR_PTR(-EAGAIN);
> +}
> +
>   static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
>   {
>   	free_pages_exact(vsie_sca, sizeof(*vsie_sca));
> @@ -905,7 +992,131 @@ static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
>   
>   static struct vsie_sca *alloc_vsie_sca(void)
>   {
> -	return alloc_pages_exact(sizeof(struct vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	struct vsie_sca *vsie_sca;
> +
> +	vsie_sca = alloc_pages_exact(sizeof(*vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (vsie_sca)
> +		mutex_init(&vsie_sca->mutex);
> +
> +	return vsie_sca;
> +}
> +
> +/* Clear the vsie_sca struct but keep the vsie_page references and ref_count */

And apparently the mutex or did I miscalculate?

> +static void clear_vsie_sca(struct vsie_sca *vsie_sca)
> +{
> +	static_assert(offsetof(struct vsie_sca, pages) < offsetof(struct vsie_sca, ref_count));
> +
> +	unsigned long offset = offsetof(struct vsie_sca, ref_count) + sizeof(vsie_sca->ref_count);
> +	void *vsie_sca_data = (void *)vsie_sca + offset;
> +
> +	memset(&vsie_sca->ssca, 0, sizeof(vsie_sca->ssca));

That could be a normal assign.

> +	memset(vsie_sca_data, 0, sizeof(struct vsie_sca) - offset);

Have a look at QEMU's s390x cpu reset in target/s390x/cpu.c
In that file we have reset markers to make it easier to clear areas.

> +}
> +

> +
>   int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>   {
> +	struct kvm_s390_sie_block *scb_o;
> +	struct vsie_sca *vsie_sca = NULL;
>   	struct vsie_page *vsie_page;
> -	unsigned long scb_addr;
> -	int rc;
> +	gpa_t scb_addr;
> +	hpa_t scb_hpa;
> +	int rc = 0;
>   
>   	vcpu->stat.instruction_sie++;
>   	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIEF2))
> @@ -1731,7 +2111,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>   	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
>   
>   	/* 512 byte alignment */
> -	if (unlikely(scb_addr & 0x1ffUL))
> +	if (unlikely(!scb_addr || scb_addr & 0x1ffUL))

That's unrelated, no?
Also the spec only mentions the alignment and specifically states that 
LAP does not apply. So why are you adding this check?

Using 0 is certainly not a great idea but I'm not convinced that it's a 
spec until you point me to the right part of the architecture.

>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>   
>   	if (kvm_s390_vcpu_has_irq(vcpu, 0) || kvm_s390_vcpu_sie_inhibited(vcpu)) {
> @@ -1739,34 +2119,65 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>   		return 0;
>   	}
>   
> -	vsie_page = get_vsie_page(vcpu->kvm, scb_addr);
> -	if (IS_ERR(vsie_page)) {
> -		return PTR_ERR(vsie_page);
> -	} else if (!vsie_page) {
> +	rc = pin_guest_page(vcpu->kvm, scb_addr, &scb_hpa);
> +	if (rc)
> +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +	scb_o = (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
> +
> +	if (!use_vsie_sigpif(vcpu->kvm, scb_o)) {
> +		/* get the vsie_page with pinned scb_o */
> +		vsie_page = get_vsie_page(vcpu, scb_addr);
> +		if (IS_ERR(vsie_page)) {
> +			rc = PTR_ERR(vsie_page);
> +			goto out_unpin;
> +		}
> +	} else {
> +		/* get the vsie_sca with pinned sca_gpa */

With pinned scb_o or did you mean "and pin guest original sca"?

> +		vsie_sca = get_vsie_sca(vcpu, scb_o, read_scao(vcpu->kvm, scb_o));
> +		if (IS_ERR(vsie_sca)) {
> +			rc = PTR_ERR(vsie_sca);
> +			goto out_unpin;
> +		}
> +		vsie_page = get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr, scb_o->icpua);
> +		if (IS_ERR(vsie_page)) {
> +			rc = PTR_ERR(vsie_page);
> +			goto out_put_sca;
> +		}
[...]

