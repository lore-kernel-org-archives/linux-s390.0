Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfHUNXj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 09:23:39 -0400
Subject: Re: [kvm-unit-tests PATCH v2 1/4] s390x: Support PSW restart boot
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <05b86a55-2f5b-5692-110f-beb04b9d1ca0@redhat.com>
Date: Wed, 21 Aug 2019 15:23:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190821104736.1470-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 21.08.19 12:47, Janosch Frank wrote:
> Add a boot PSW to PSW restart new, so we can also boot via a PSW
> restart.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  s390x/flat.lds | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/s390x/flat.lds b/s390x/flat.lds
> index 403d967..86dffac 100644
> --- a/s390x/flat.lds
> +++ b/s390x/flat.lds
> @@ -1,14 +1,18 @@
>  SECTIONS
>  {
> -	/*
> -	 * Initial short psw for disk boot, with 31 bit addressing for
> -	 * non z/Arch environment compatibility and the instruction
> -	 * address 0x10000 (cstart64.S .init).
> -	 */
>  	.lowcore : {
> +		/*
> +		 * Initial short psw for disk boot, with 31 bit addressing for
> +		 * non z/Arch environment compatibility and the instruction
> +		 * address 0x10000 (cstart64.S .init).
> +		 */
>  		. = 0;
>  		 LONG(0x00080000)
>  		 LONG(0x80010000)
> +		 /* Restart new PSW for booting via PSW restart. */
> +		 . = 0x1a0;
> +		 QUAD(0x0000000180000000)
> +		 QUAD(0x0000000000010000)
>  	}
>  	. = 0x10000;
>  	.text : {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
