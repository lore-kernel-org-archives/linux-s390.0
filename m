Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbgFQI2f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 04:28:35 -0400
Date: Wed, 17 Jun 2020 10:27:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v9 06/12] s390x: clock and delays
 caluculations
Message-ID: <20200617102704.7755e11a.cohuck@redhat.com>
In-Reply-To: <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Mon, 15 Jun 2020 11:31:55 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The hardware gives us a good definition of the microsecond,
> let's keep this information and let the routine accessing
> the hardware keep all the information and return microseconds.
> 
> Calculate delays in microseconds and take care about wrapping
> around zero.
> 
> Define values with macros and use inlines to keep the
> milliseconds interface.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/time.h | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> index 1791380..7f1d891 100644
> --- a/lib/s390x/asm/time.h
> +++ b/lib/s390x/asm/time.h
> @@ -13,14 +13,39 @@
>  #ifndef ASM_S390X_TIME_H
>  #define ASM_S390X_TIME_H
>  
> -static inline uint64_t get_clock_ms(void)
> +#define STCK_SHIFT_US	(63 - 51)
> +#define STCK_MAX	((1UL << 52) - 1)
> +
> +static inline uint64_t get_clock_us(void)
>  {
>  	uint64_t clk;
>  
>  	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>  
>  	/* Bit 51 is incrememented each microsecond */

That comment may now be a tad non-obvious, because the details are
hidden behind the #define? Anyway, no strong opinion.

> -	return (clk >> (63 - 51)) / 1000;
> +	return clk >> STCK_SHIFT_US;
> +}
> +
> +static inline void udelay(unsigned long us)
> +{
> +	unsigned long startclk = get_clock_us();
> +	unsigned long c;
> +
> +	do {
> +		c = get_clock_us();
> +		if (c < startclk)
> +			c += STCK_MAX;
> +	} while (c < startclk + us);
> +}
> +
> +static inline void mdelay(unsigned long ms)
> +{
> +	udelay(ms * 1000);
> +}
> +
> +static inline uint64_t get_clock_ms(void)
> +{
> +	return get_clock_us() / 1000;
>  }
>  
>  #endif

Acked-by: Cornelia Huck <cohuck@redhat.com>
