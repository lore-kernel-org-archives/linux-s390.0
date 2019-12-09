Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727326AbfLILnD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 06:43:03 -0500
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-5-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc6e103d-100b-151b-4a6e-359f3103d5fa@redhat.com>
Date: Mon, 9 Dec 2019 12:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <1575649588-6127-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 06/12/2019 17.26, Pierre Morel wrote:
> To serve multiple times, the function get_clock_ms() is moved
> from intercept.c test to the new file asm/time.h.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/asm/time.h | 27 +++++++++++++++++++++++++++
>  s390x/intercept.c    | 11 +----------
>  2 files changed, 28 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h
> 
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> new file mode 100644
> index 0000000..b07ccbd
> --- /dev/null
> +++ b/lib/s390x/asm/time.h
> @@ -0,0 +1,27 @@
> +/*
> + * Clock utilities for s390
> + *
> + * Authors:
> + *  Thomas Huth <thuth@redhat.com>
> + *
> + * Copied from the s390/intercept test by:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#ifndef _ASM_S390X_TIME_H_
> +#define _ASM_S390X_TIME_H_
> +
> +static inline uint64_t get_clock_ms(void)
> +{
> +	uint64_t clk;
> +
> +	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> +
> +	/* Bit 51 is incrememented each microsecond */
> +	return (clk >> (63 - 51)) / 1000;
> +}
> +
> +

Please remove one of the two empty lines.

With that cosmetic nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>
