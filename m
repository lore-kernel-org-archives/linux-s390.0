Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGOep (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 09:34:45 -0500
Subject: Re: [PATCH 07/35] KVM: s390: add new variants of UV CALL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-8-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e387472b-4417-9079-2df2-8f6f1689093e@redhat.com>
Date: Fri, 7 Feb 2020 15:34:31 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> This add 2 new variants of the UV CALL.
> 
> The first variant handles UV CALLs that might have longer busy
> conditions or just need longer when doing partial completion. We should
> schedule when necessary.
> 
> The second variant handles UV CALLs that only need the handle but have
> no payload (e.g. destroying a VM). We can provide a simple wrapper for
> those.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 59 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 1b97230a57ba..e1cef772fde1 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/bug.h>
> +#include <linux/sched.h>
>  #include <asm/page.h>
>  #include <asm/gmap.h>
>  
> @@ -91,6 +92,19 @@ struct uv_cb_cfs {
>  	u64 paddr;
>  } __packed __aligned(8);
>  
> +/*
> + * A common UV call struct for calls that take no payload
> + * Examples:
> + * Destroy cpu/config
> + * Verify
> + */
> +struct uv_cb_nodata {
> +	struct uv_cb_header header;
> +	u64 reserved08[2];
> +	u64 handle;
> +	u64 reserved20[4];
> +} __packed __aligned(8);
> +
>  struct uv_cb_share {
>  	struct uv_cb_header header;
>  	u64 reserved08[3];
> @@ -98,6 +112,31 @@ struct uv_cb_share {
>  	u64 reserved28;
>  } __packed __aligned(8);
>  
> +/*
> + * Low level uv_call that takes r1 and r2 as parameter and avoids
> + * stalls for long running busy conditions by doing schedule
> + */
> +static inline int uv_call_sched(unsigned long r1, unsigned long r2)
> +{
> +	int cc;
> +
> +	do {
> +		asm volatile(
> +			"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> +			"		ipm	%[cc]\n"
> +			"		srl	%[cc],28\n"

Maybe remove one TAB before "ipm" and "srl" ?

Apart from that, patch looks fine to me now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
