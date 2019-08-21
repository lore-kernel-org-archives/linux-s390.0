Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1319 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfHUN1O (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 09:27:14 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/4] s390x: Move stsi to library
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-4-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3a5cc77f-8b2b-269e-3939-3280287b470a@redhat.com>
Date: Wed, 21 Aug 2019 15:27:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190821104736.1470-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 21.08.19 12:47, Janosch Frank wrote:
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
> +}
> +
>  #endif
> diff --git a/s390x/skey.c b/s390x/skey.c
> index b1e11af..fd4fcc7 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -70,24 +70,6 @@ static void test_set(void)
>  	       skey.str.acc == ret.str.acc && skey.str.fp == ret.str.fp);
>  }
>  
> -static inline int stsi(void *addr, int fc, int sel1, int sel2)
> -{
> -	register int r0 asm("0") = (fc << 28) | sel1;
> -	register int r1 asm("1") = sel2;
> -	int rc = 0;
> -
> -	asm volatile(
> -		"	stsi	0(%3)\n"
> -		"	jz	0f\n"
> -		"	lhi	%1,-1\n"
> -		"0:\n"
> -		: "+d" (r0), "+d" (rc)
> -		: "d" (r1), "a" (addr)
> -		: "cc", "memory");
> -
> -	return rc;
> -}
> -
>  /* Returns true if we are running under z/VM 6.x */
>  static bool check_for_zvm6(void)
>  {
> 

You don't simply move, you also modify and change the return value from
o/-1 to cc. AFAIKs, this should be fine.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
