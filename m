Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgKSI0t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:26:49 -0500
Subject: Re: [kvm-unit-tests PATCH 1/5] s390x: Add test_bit to library
References: <20201117154215.45855-1-frankja@linux.ibm.com>
 <20201117154215.45855-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d61a28d-d822-b9b5-8ec6-1ea0dca1ed70@redhat.com>
Date: Thu, 19 Nov 2020 09:26:38 +0100
MIME-Version: 1.0
In-Reply-To: <20201117154215.45855-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On 17/11/2020 16.42, Janosch Frank wrote:
> Query/feature bits are commonly tested via MSB bit numbers on
> s390. Let's add test bit functions, so we don't need to copy code to
> test query bits.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/bitops.h   | 16 ++++++++++++++++
>  lib/s390x/asm/facility.h |  3 ++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/asm/bitops.h b/lib/s390x/asm/bitops.h
> index e7cdda9..a272dd7 100644
> --- a/lib/s390x/asm/bitops.h
> +++ b/lib/s390x/asm/bitops.h
> @@ -7,4 +7,20 @@
>  
>  #define BITS_PER_LONG	64
>  
> +static inline bool test_bit(unsigned long nr,
> +			    const volatile unsigned long *ptr)
> +{
> +	const volatile unsigned char *addr;
> +
> +	addr = ((const volatile unsigned char *)ptr);
> +	addr += (nr ^ (BITS_PER_LONG - 8)) >> 3;
> +	return (*addr >> (nr & 7)) & 1;
> +}
> +
> +static inline bool test_bit_inv(unsigned long nr,
> +				const volatile unsigned long *ptr)
> +{
> +	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> +}

I think you should mention in the patch description that these functions
match the implementations in the kernel (and thus are good for kernel
developers who are used to these).

Thus I think you should also now add a license statement to this file
("SPDX-License-Identifier: GPL-2.0" or so).

With these modifications:
Reviewed-by: Thomas Huth <thuth@redhat.com>
