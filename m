Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729567AbgBMIhZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 03:37:25 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D8SbJr109037
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 03:37:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3u5293mu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 03:37:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 13 Feb 2020 08:37:22 -0000
Subject: Re: [PATCH 20/35] KVM: s390: protvirt: handle secure guest prefix
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-21-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Feb 2020 09:37:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-21-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4f7b8865-9fda-9c1a-cd0b-e138bbbb278b@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 07.02.20 12:39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> The SPX instruction is handled by the ultravisor. We do get a
> notification intercept, though. Let us update our internal view.
> 
> In addition to that, when the guest prefix page is not secure, an
> intercept 112 (0x70) is indicated.  To avoid this for the most common
> cases, we can make the guest prefix page protected whenever we pin it.
> We have to deal with 112 nevertheless, e.g. when some host code triggers
> an export (e.g. qemu dump guest memory). We can simply re-run the
> pinning logic by doing a no-op prefix change.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/intercept.c        | 16 ++++++++++++++++
>  arch/s390/kvm/kvm-s390.c         | 14 ++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 05949ff75a1e..0e3ffad4137f 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -225,6 +225,7 @@ struct kvm_s390_sie_block {
>  #define ICPT_INT_ENABLE	0x64
>  #define ICPT_PV_INSTR	0x68
>  #define ICPT_PV_NOTIFY	0x6c
> +#define ICPT_PV_PREF	0x70
>  	__u8	icptcode;		/* 0x0050 */
>  	__u8	icptstatus;		/* 0x0051 */
>  	__u16	ihcpu;			/* 0x0052 */
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index db3dd5ee0b7a..2a966dc52611 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -451,6 +451,15 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
>  	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
>  }
>  
> +static int handle_pv_spx(struct kvm_vcpu *vcpu)
> +{
> +	u32 pref = *(u32 *)vcpu->arch.sie_block->sidad;
> +
> +	kvm_s390_set_prefix(vcpu, pref);
> +	trace_kvm_s390_handle_prefix(vcpu, 1, pref);
> +	return 0;
> +}
> +
>  static int handle_pv_sclp(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
> @@ -477,6 +486,8 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
>  
>  static int handle_pv_notification(struct kvm_vcpu *vcpu)
>  {
> +	if (vcpu->arch.sie_block->ipa == 0xb210)
> +		return handle_pv_spx(vcpu);
>  	if (vcpu->arch.sie_block->ipa == 0xb220)
>  		return handle_pv_sclp(vcpu);
>  
> @@ -534,6 +545,11 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  	case ICPT_PV_NOTIFY:
>  		rc = handle_pv_notification(vcpu);
>  		break;
> +	case ICPT_PV_PREF:
> +		rc = 0;
> +		/* request to convert and pin the prefix pages again */
> +		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1797490e3e77..63d158149936 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3678,6 +3678,20 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>  		rc = gmap_mprotect_notify(vcpu->arch.gmap,
>  					  kvm_s390_get_prefix(vcpu),
>  					  PAGE_SIZE * 2, PROT_WRITE);
> +		if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
> +			do {
> +				rc = uv_convert_to_secure(
> +						vcpu->arch.gmap,
> +						kvm_s390_get_prefix(vcpu));
> +			} while (rc == -EAGAIN);
> +			WARN_ONCE(rc, "Error while importing first prefix page. rc %d", rc);
> +			do {
> +				rc = uv_convert_to_secure(
> +						vcpu->arch.gmap,
> +						kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
> +			} while (rc == -EAGAIN);
> +			WARN_ONCE(rc, "Error while importing second prefix page. rc %d", rc);

I think it might be better to move this hunk in the ICPT_IV_PREF handler. 
Then we can cleanup the convert to secure handling a bit. 

> +		}
>  		if (rc) {
>  			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>  			return rc;
> 
