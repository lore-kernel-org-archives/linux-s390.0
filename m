Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbgBXTON (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 14:14:13 -0500
Subject: Re: [PATCH v4 16/36] KVM: s390: protvirt: Handle spec exception loops
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-17-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <67cd8b46-2b9a-e7a0-bf60-ca7018d3be56@redhat.com>
Date: Mon, 24 Feb 2020 20:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <20200224114107.4646-17-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 24.02.20 12:40, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> SIE intercept code 8 is used only on exception loops for protected
> guests. That means we need to stop the guest when we see it. This is
> done by userspace.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 00a79442a428..331e620dcfdf 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -231,6 +231,13 @@ static int handle_prog(struct kvm_vcpu *vcpu)
>  
>  	vcpu->stat.exit_program_interruption++;
>  
> +	/*
> +	 * Intercept 8 indicates a loop of specification exceptions
> +	 * for protected guests.
> +	 */
> +	if (kvm_s390_pv_cpu_is_protected(vcpu))
> +		return -EOPNOTSUPP;
> +
>  	if (guestdbg_enabled(vcpu) && per_event(vcpu)) {
>  		rc = kvm_s390_handle_per_event(vcpu);
>  		if (rc)
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
