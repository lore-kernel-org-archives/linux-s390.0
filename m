Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfHWKee (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 06:34:34 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/4] s390x: Move stsi to library
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb1eab5b-de78-686d-0d3a-783b1353be6a@redhat.com>
Date: Fri, 23 Aug 2019 12:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190821104736.1470-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/21/19 12:47 PM, Janosch Frank wrote:
> It's needed in multiple tests now.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 16 ++++++++++++++++
>  s390x/skey.c             | 18 ------------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 4bbb428..5f8f45e 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -240,4 +240,20 @@ static inline void enter_pstate(void)
>  	load_psw_mask(mask);
>  }
>  
> +static inline int stsi(void *addr, int fc, int sel1, int sel2)
> +{
> +	register int r0 asm("0") = (fc << 28) | sel1;
> +	register int r1 asm("1") = sel2;
> +	int cc;
> +
> +	asm volatile(
> +		"stsi	0(%3)\n"
> +		"ipm	%[cc]\n"
> +		"srl	%[cc],28\n"
> +		: "+d" (r0), [cc] "=d" (cc)
> +		: "d" (r1), "a" (addr)
> +		: "cc", "memory");
> +	return cc;

Maybe mention the changed return value in the patch description.

Reviewed-by: Thomas Huth <thuth@redhat.com>
