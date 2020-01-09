Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725791AbgAIQoH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 11:44:07 -0500
Subject: Re: [kvm-unit-tests PATCH v6 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
 <20200109161625.154894-4-imbrenda@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c6f563e-3d09-5274-b050-a64122097e9b@redhat.com>
Date: Thu, 9 Jan 2020 17:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200109161625.154894-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 09/01/2020 17.16, Claudio Imbrenda wrote:
> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> use it instead of using inline assembly everywhere.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 10 ++++++++++
>  s390x/intercept.c        | 33 +++++++++++++--------------------
>  2 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 1a5e3c6..465fe0f 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -284,4 +284,14 @@ static inline int servc(uint32_t command, unsigned long sccb)
>  	return cc;
>  }
>  
> +static inline void spx(uint32_t *new_prefix)

Looking at this a second time ... why is new_prefix a pointer? A normal
value should be sufficient here, shouldn't it?

> +{
> +	asm volatile("spx %0" : : "Q" (*new_prefix) : "memory");
> +}
> +
> +static inline void stpx(uint32_t *current_prefix)
> +{
> +	asm volatile("stpx %0" : "=Q" (*current_prefix));
> +}
> +

 Thomas
