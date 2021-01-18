Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393146AbhAROlx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:41:53 -0500
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix uv_call() exception behavior
References: <20210118140344.3074-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d402c02-c75a-5a9e-6f02-87a513864e0d@redhat.com>
Date: Mon, 18 Jan 2021 15:40:09 +0100
MIME-Version: 1.0
In-Reply-To: <20210118140344.3074-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 18/01/2021 15.03, Janosch Frank wrote:
> On a program exception we usually skip the instruction that caused the
> exception and continue. That won't work for UV calls since a "brc 3,0b"
> will retry the instruction if the CC is > 1.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I know this isn't very pretty.
> I'm open for suggestions.
> 
> ---
>   lib/s390x/asm/uv.h | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 4c2fc48..252f1a3 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -53,21 +53,23 @@ struct uv_cb_share {
>   static inline int uv_call(unsigned long r1, unsigned long r2)
>   {
>   	int cc;
> +	struct lowcore *lc = 0x0;
>   
>   	/*
> -	 * The brc instruction will take care of the cc 2/3 case where
> -	 * we need to continue the execution because we were
> -	 * interrupted. The inline assembly will only return on
> -	 * success/error i.e. cc 0/1.
> -	*/
> +	 * CC 2 and 3 tell us to re-execute because the instruction
> +	 * hasn't yet finished.
> +	 */
> +	lc->pgm_int_code = 0;
> +retry:
>   	asm volatile(
>   		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> -		"		brc	3,0b\n"
>   		"		ipm	%[cc]\n"
>   		"		srl	%[cc],28\n"
>   		: [cc] "=d" (cc)
>   		: [r1] "a" (r1), [r2] "a" (r2)
>   		: "memory", "cc");
> +	if (!lc->pgm_int_code && cc > 1)
> +		goto retry;

Why not simply:

	do {
		asm volatile(...);
	} while (!lc->pgm_int_code && cc > 1)

?

   Thomas
