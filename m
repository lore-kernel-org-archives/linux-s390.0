Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726414AbgBQOXb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 09:23:31 -0500
Subject: Re: [PATCH v2 22/42] KVM: s390/mm: handle guest unpin events
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-23-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b080c452-4b22-d0b6-75d4-8848bd152fa4@redhat.com>
Date: Mon, 17 Feb 2020 15:23:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-23-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> The current code tries to first pin shared pages, if that fails (e.g.
> because the page is not shared) it will export them. For shared pages
> this means that we get a new intercept telling us that the guest is
> unsharing that page. We will make the page secure at that point in time
> and revoke the host access. This is synchronized with other host events,
> e.g. the code will wait until host I/O has finished.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 6c9db886381c..1e231058e4b3 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -16,6 +16,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/irq.h>
>  #include <asm/sysinfo.h>
> +#include <asm/uv.h>
>  
>  #include "kvm-s390.h"
>  #include "gaccess.h"
> @@ -484,12 +485,35 @@ static int handle_pv_sclp(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static int handle_pv_uvc(struct kvm_vcpu *vcpu)
> +{
> +	struct uv_cb_share *guest_uvcb = (void *)vcpu->arch.sie_block->sidad;
> +	struct uv_cb_cts uvcb = {
> +		.header.cmd	= UVC_CMD_UNPIN_PAGE_SHARED,
> +		.header.len	= sizeof(uvcb),
> +		.guest_handle	= kvm_s390_pv_handle(vcpu->kvm),
> +		.gaddr		= guest_uvcb->paddr,
> +	};
> +	int rc;
> +
> +	if (guest_uvcb->header.cmd != UVC_CMD_REMOVE_SHARED_ACCESS) {
> +		WARN_ONCE(1, "Unexpected UVC 0x%x!\n", guest_uvcb->header.cmd);
> +		return 0;
> +	}
> +	rc = gmap_make_secure(vcpu->arch.gmap, uvcb.gaddr, &uvcb);
> +	if (rc == -EINVAL)
> +		return 0;
> +	return rc;
> +}
> +
>  static int handle_pv_notification(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.sie_block->ipa == 0xb210)
>  		return handle_pv_spx(vcpu);
>  	if (vcpu->arch.sie_block->ipa == 0xb220)
>  		return handle_pv_sclp(vcpu);
> +	if (vcpu->arch.sie_block->ipa == 0xb9a4)
> +		return handle_pv_uvc(vcpu);
>  
>  	return handle_instruction(vcpu);
>  }
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
