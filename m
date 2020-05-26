Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbgEZSQi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 14:16:38 -0400
Subject: Re: [kvm-unit-tests PATCH v7 06/12] s390x: use get_clock_ms() to
 calculate a delay in ms
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a490dc16-b323-5a52-2d29-f4707d89a1d6@redhat.com>
Date: Tue, 26 May 2020 20:16:24 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 18/05/2020 18.07, Pierre Morel wrote:
> use get_clock_ms() to calculate a delay in ms
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/time.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> index 25c7a3c..931a119 100644
> --- a/lib/s390x/asm/time.h
> +++ b/lib/s390x/asm/time.h
> @@ -23,4 +23,14 @@ static inline uint64_t get_clock_ms(void)
>  	return (clk >> (63 - 51)) / 1000;
>  }
>  
> +static inline void mdelay(unsigned long ms)
> +{
> +	unsigned long startclk;
> +
> +	startclk = get_clock_ms();
> +	for (;;)
> +		if (get_clock_ms() - startclk > ms)
> +			break;

Maybe rather:

    for (;get_clock_ms() - startclk <= ms;)
	;

?
Or:

    while (get_clock_ms() - startclk <= ms)
        ;
?

 Thomas
