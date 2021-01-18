Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405641AbhARPRY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 10:17:24 -0500
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Fix uv_call() exception behavior
References: <20210118140344.3074-1-frankja@linux.ibm.com>
 <20210118150922.5229-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d876410c-fd7b-5fb8-1f9e-d3a13e9f44c3@redhat.com>
Date: Mon, 18 Jan 2021 16:15:43 +0100
MIME-Version: 1.0
In-Reply-To: <20210118150922.5229-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 18/01/2021 16.09, Janosch Frank wrote:
> On a program exception we usually skip the instruction that caused the
> exception and continue. That won't work for UV calls since a "brc
> 3,0b" will retry the instruction if the CC is > 1. Let's forgo the brc
> when checking for privilege exceptions and use a uv_call_once().
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> ---
>   lib/s390x/asm/uv.h | 24 ++++++++++++++++--------
>   s390x/uv-guest.c   |  6 +++---
>   2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 4c2fc48..39d2dc0 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -50,19 +50,12 @@ struct uv_cb_share {
>   	u64 reserved28;
>   } __attribute__((packed))  __attribute__((aligned(8)));
>   
> -static inline int uv_call(unsigned long r1, unsigned long r2)
> +static inline int uv_call_once(unsigned long r1, unsigned long r2)
>   {
>   	int cc;
>   
> -	/*
> -	 * The brc instruction will take care of the cc 2/3 case where
> -	 * we need to continue the execution because we were
> -	 * interrupted. The inline assembly will only return on
> -	 * success/error i.e. cc 0/1.
> -	*/
>   	asm volatile(
>   		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> -		"		brc	3,0b\n"
>   		"		ipm	%[cc]\n"
>   		"		srl	%[cc],28\n"
>   		: [cc] "=d" (cc)
> @@ -71,4 +64,19 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
>   	return cc;
>   }
>   
> +static inline int uv_call(unsigned long r1, unsigned long r2)
> +{
> +	int cc;
> +
> +	/*
> +	 * CC 2 and 3 tell us to re-execute because the instruction
> +	 * hasn't yet finished.
> +	 */
> +	do {
> +		cc = uv_call_once(r1, r2);
> +	} while (cc > 1);
> +
> +	return cc;
> +}
> +
>   #endif
> diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
> index d47333e..091a19b 100644
> --- a/s390x/uv-guest.c
> +++ b/s390x/uv-guest.c
> @@ -31,7 +31,7 @@ static void test_priv(void)
>   	uvcb.len = sizeof(struct uv_cb_qui);
>   	expect_pgm_int();
>   	enter_pstate();
> -	uv_call(0, (u64)&uvcb);
> +	uv_call_once(0, (u64)&uvcb);
>   	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>   	report_prefix_pop();
>   
> @@ -40,7 +40,7 @@ static void test_priv(void)
>   	uvcb.len = sizeof(struct uv_cb_share);
>   	expect_pgm_int();
>   	enter_pstate();
> -	uv_call(0, (u64)&uvcb);
> +	uv_call_once(0, (u64)&uvcb);
>   	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>   	report_prefix_pop();
>   
> @@ -49,7 +49,7 @@ static void test_priv(void)
>   	uvcb.len = sizeof(struct uv_cb_share);
>   	expect_pgm_int();
>   	enter_pstate();
> -	uv_call(0, (u64)&uvcb);
> +	uv_call_once(0, (u64)&uvcb);
>   	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>   	report_prefix_pop();

That looks nicer, indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
